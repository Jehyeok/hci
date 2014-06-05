//
//  Circle.cpp
//  openNiSample007
//
//  Created by Jehyeok on 6/5/14.
//
//

#include "Circle.h"
#include "ofMain.h"
#include <math.h>

Circle::Circle(void)
{
    velX = 1.0f;
    velY = 1.0f;
    
    positionX = 200.0f;
    positionY = 200.0f;
    
    color[0] = 0;
    color[1] = 255;
    color[2] = 0;
    
    radius = 30;
}
Circle::~Circle(void)
{
}

void Circle::isCollided(float posX, float posY)
{
    double d = sqrt((positionX - posX) * (positionX - posX) + (positionY - posY) * (positionY - posY));
    ofLog(OF_LOG_NOTICE, "the number is %f", d);
    if (d <= radius)
    {
        setRandColor();
        if (posY > positionY)
        {
            if (velY > 0)
            {
                velY = (-1) * velY;
            }
        }
        
        if (posX > positionX)
        {
            if (velX > 0)
            {
                velX = (-1) * velX;
            }
        }
        
        if (posY < positionY)
        {
            if (velY < 0)
            {
                velY = (-1) * velY;
            }
        }
        
        if (posX < positionX)
        {
            if (velX < 0)
            {
                velX = (-1) * velX;
            }
        }
    }
}

void Circle::setRandColor()
{
    color[0] = rand() % 256;
    color[1] = rand() % 256;
    color[2] = rand() % 256;
}

void Circle::update()
{
    positionX += velX;
    positionY += velY;
    
    if (positionX + radius >= ofGetViewportWidth() || positionX - radius <= 0)
    {
        velX = (-1) * velX;
    }
    
    if (positionY + radius >= ofGetViewportHeight() || positionY - radius <= 0)
    {
        velY = (-1) * velY;
    }
    
}

void Circle::display()
{
    update();
    
	ofSetColor(color[0], color[1], color[2]);
	ofCircle(positionX, positionY, 50);
}