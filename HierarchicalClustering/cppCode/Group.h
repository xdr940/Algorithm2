#pragma once
using namespace std;

class Group
{
public:
	friend float distance(const Group &g1,const Group& g2);
	friend void Merge(Group &g1, Group &g2);
	Group();
	Group(int id, vector<Point>& Points);
	Group(int id);

	void display()const;//显示group里的点数啥的
	void setGroupId(int id) {
		this->groupId = id;
	}
	int  getGroupId()const {
		return this->groupId;
	}
	void add(const Point&p);//加点到group，并更新p点的所属信息
	void rmv(const int i);//把vector第i个点抹去
	void update();//更新重心和类内离差距（标量）
	int size()const {
		return this->Points.size();
	}//group点个数
	Point getMp()const {
		return *Mp;
	}//得到重心点
	float rhormv(const Point& p)const;//如果移除p，组内离差距能变化多少
	float rhoadd(const Point& p)const;//如果加上p，组内离差距能变化多少
	int inGroup(const Point&p)const;//p如果存在组内，返回位置，否则返回-1
	float getJ()const;//组内离差距
	void pop_back();
	Point back()const;
	Point at(const int i)const;

	string toString() const;


	~Group();
private:

	vector<Point> Points;
	Point *Mp;
	int groupId;
	bool updateFlag = true;
	float J = 0;
};

