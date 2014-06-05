//
//  Circle.h
//  openNiSample007
//
//  Created by Jehyeok on 6/5/14.
//
//

#pragma once
class Circle
{
public:
	Circle(void);
	~Circle(void);
    
	void update();
	void display();
    void isCollided(float posX, float posY);
    void setRandColor();
private:
    int color[3];
    int radius;
    float velX;
    float velY;
	float positionX;
	float positionY;
};