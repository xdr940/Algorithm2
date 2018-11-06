#pragma once
using namespace std;

class Group
{
public:
	Group();
	Group(int id, vector<Point>& Points);
	Group(int id);
	void display()const;
	void setGroupId(int id) {
		this->groupId = id;
	}
	int  getGroupId() {
		return this->groupId;
	}
	void add(const Point&p);
	void rmv(const int i);
	void update();
	int size()const {
		return this->Points.size();
	}
	Point getMp()const {
		return *Mp;
	}
	float rhormv(const Point& p)const;
	float rhoadd(const Point& p)const;
	int inGroup(const Point&p)const;
	float getJ()const;
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

