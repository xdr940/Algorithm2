#include "pch.h"
#include "Point.h"



Point::Point() {
	this->x1 = 0;
	this->x2 = 0;
}
Point::Point(int id, float x1, float x2) {
	this->pointId = id;
	this->x1 = x1;
	this->x2 = x2;
	this->belongto = -1;
}
/*
Point::Point(const Point & p)
{
	this->x1 = p.x1;
	this->x2 = p.x2;
	this->pointId = p.getPointId();
	//this->belongto = -1;//add的时候会在外层调用更新这个，所以不用问

}
*/
Point::Point(float x1, float x2) {
	this->x1 = x1;
	this->x2 = x2;
	pointId = -1;//一般用到的都是聚心
	this->belongto = -1;
}

string Point::toString() const
{

	return "(" + to_string(this->getX1()) + ", " + to_string(this->getX2()) + ")";
}

void
Point::display()const {

	cout << "ID = " << pointId << " (" << this->x1 << "," << this->x2 << ")" << "belongto " << this->belongto << endl;
}
Point::~Point()
{
}
Point Point::operator+(const Point& p)const {
	return Point(-1, x1 + p.x1, x2 + p.x2);
}
Point Point::operator-(const Point&p)const {
	return Point(-1, x1 - p.x1, x2 - p.x2);

}
Point & Point::operator=(const Point&p) {//深复制
	this->x1 = p.getX1();
	this->x2 = p.getX2();
	this->pointId = p.getPointId();
	return *this;
}

bool Point::operator==(const Point & p) const
{
	if (this->getX1() == p.getX1() && this->getX2() == p.getX2()) {
		return true;
	}
	else {
		return false;
	}
}

Point &Point::operator/(const float a) {
	this->x1 /= a;
	this->x2 /= a;

	return *this;
}