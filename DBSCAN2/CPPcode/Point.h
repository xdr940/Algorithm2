#pragma once

using namespace std;
class Point {

public:
	Point();
	Point(float x1, float x2);
	Point(int id, float x1, float x2);
	//Point(const Point&p);//不必要重写
	string toString()const;
	void set(float x1, float x2) {
		this->x1 = x1;
		this->x2 = x2;
	}
	void display()const;
	float getX1()const {
		return x1;
	}
	float getX2()const {
		return x2;
	}

	int getBelongto()const {
		return belongto;
	}
	int getPointId()const {
		return this->pointId;
	}


	void setPointId(int id) {
		this->pointId = id;
	}
	void setBelongto(int belong) {
		this->belongto = belong;
	}

	Point operator+(const Point& p)const;
	Point operator-(const Point& p)const;
	Point& operator/(const float a);
	Point& operator=(const Point&p);
	bool operator==(const Point&p)const;
	float l2() {
		return sqrt(x1*x1 + x2 * x2);
	}

	~Point();
private:
	int pointId;
	float x1, x2;
	int belongto;

};

