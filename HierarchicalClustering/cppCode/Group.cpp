#include "pch.h"
#include "Group.h"



Group::Group()
{
	this->Mp = new Point();
	Mp->setPointId(-1);
	this->groupId = -1;
}
Group::Group(int id, vector<Point>&Points)
{
	this->Points = Points;
	this->Mp = new Point();
	Mp->setPointId(-1);
	this->groupId = id;
}
Group::Group(int id)
{
	this->Mp = new Point();
	Mp->setPointId(-1);
	this->groupId = id;
}
Group::~Group()
{
}




void Group::update() {
	//从头统计
	if (updateFlag == false) {
		return;
	}
	/*update Mp*/
	if (size() != 0) {
		float x1 = 0, x2 = 0;
		for (int i = 0; i < size(); i++) {
			x1 += this->Points[i].getX1();
			x2 += this->Points[i].getX2();
		}
		//this->Mp = &Point(x1/size(),x2/size());
		this->Mp = new Point(x1 / size(), x2 / size());//这俩啥区别？？？

		/*update J*/
		J = 0;
		for (int i = 0; i < size(); i++) {
			J += (Points[i] - *Mp).l2();
		}
	}
	
	
	updateFlag = false;//更新完毕


}
float Group::rhormv(const Point& p)const {
	int ret = inGroup(p);
	if (ret == -1) {
		cout << "rhormv err 01" << endl;
		return -1;
	}

	float N = (float)this->size();
	if (N == 1) {
		//cout << "rhormv err 02" << endl;
		return 0;
	}
	else {
		return N / (N - 1)* (*(this->Mp) - p).l2();

	}



}
float Group::rhoadd(const Point&p)const {
	float N = (float)size();
	return (N / (N + 1))* (p - *this->Mp).l2();

}
int Group::inGroup(const Point & p) const
{
	for (int i = 0; i < size(); i++) {
		if (Points[i].getPointId() == p.getPointId()) {
			return i;
		}
	}
	return -1;
}
float Group::getJ() const
{
	return J;
}


void Group::pop_back()
{
	this->updateFlag = true;
	return
		Points.pop_back();

}

Point Group::back() const
{
	return Points.back();
}

Point Group::at(const int i) const
{
	return Points.at(i);
}



void Group::display()const {
	if (this->size() <= 0) {
		cout << " this group is null" << endl;
	}
	else {
		cout << toString();

		for (int i = 0; i < this->size(); i++) {
			this->Points[i].display();
		}
		return;
	}

}
string Group::toString() const
{
	if (size() != 0) {
		return "\ngroupId = " + to_string(this->groupId)
			+ "   size= " + to_string(size())
			+ "   J= " + to_string(this->getJ())
			+ "   Mp: " + (this->Mp->toString()) + "\n\n";
	}
	else {
		return "\ngroupId = " + to_string(this->groupId)
			+ "   size= " + to_string(size())
			+ "  J = null "
			+ "  Mp = null\n\n";
	}
	
}

//把点加到grop里去
void Group::add(const Point&p) {

	this->Points.push_back(p);
	this->Points.back().setBelongto(this->getGroupId());//把这个点所属更新
	updateFlag = true;

}

//从grop把第i个点抹去
void Group::rmv(const int i)
{
	vector<Point>::iterator ite = Points.begin() + i;

	Points.erase(ite);

	updateFlag = true;
	//this->Points.
}

//简单字符串输出


float distance(const Group & g1, const Group & g2)
{
	int size1 = g1.size();
	int size2 = g2.size();
	float temp = INF;

	for (int i = 0; i < size1; i++) {
		for (int j = 0; j < size2; j++) {
			float temp2 = (g1.at(i) - g2.at(j)).l1();
			if (temp2 < temp) {
				temp = temp2;
			
			}
		}
	}

	return temp;
	
}

void Merge(Group & g1, Group & g2)
{	/*
	Group * gtemp;
	if (g1.size() < g2.size()) {//为了减少复杂度，把点少的group倒进多的group
		gtemp = &g1  ;
		g1 = g2;
		g2 = *gtemp;

	}
	*/

	if (g2.size() == 0) {
		return ;
	}
	while (g2.size() != 0) {
		g1.add(g2.back());
		g2.pop_back();
	}
	//合并后记得update（）；

}
