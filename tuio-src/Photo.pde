import java.awt.Image;

class Photo{
  PImage img;
  // Window Size
  final static int SCREEN_SIZE_X = 1280;
  final static int SCREEN_SIZE_Y = 800;
  // Image Position & Size & Angle
  float imagePositionX;
  float imagePositionY;
  float imageWidth;
  float imageHeight;
  float imageRotate;
  long time;
  
  Photo(float posX, float posY){
    img = loadImage("test.jpg");
    setPos(posX, posY);
    imageWidth = 100.0F;
    imageHeight = 100.0F;
    imageRotate = 0.0F;
  }
  
  void goOurward(float bookPosX, float bookPosY, float incWidth, float incHeight) {
//    float direction = imagePositionX - bookPosX;
    float width = imagePositionX - bookPosX;
    float height = imagePositionY - bookPosY;

    if (width < 0) {
      imagePositionX -= 10;
    } else {
      imagePositionX += 10;
    }
    
    if (height < 0) {
      imagePositionY -= 10;
    } else {
      imagePositionY += 10;
    }
//    imagePositionX += incWidth * 100 / width; 
//    imagePositionY += incHeight * 100 / width;
  }
  
  void goInward(float bookPosX, float bookPosY, float incWidth, float incHeight) {
    float width = imagePositionX - bookPosX;
    float height = imagePositionY - bookPosY;

    if (width < 0) {
      imagePositionX += 10;
    } else {
      imagePositionX -= 10;
    }
    
    if (height < 0) {
      imagePositionY += 10;
    } else {
      imagePositionY -= 10;
    }
  }
  
  boolean isCollided(float posX, float posY) {
    boolean inX = (posX < imagePositionX + imageWidth/2) && (posX > imagePositionX - imageWidth/2);
    boolean inY = (posY < imagePositionY + imageHeight/2) && (posY > imagePositionY - imageHeight/2);
    if (inX && inY) {
      return true;
    }  else {
      return false;
    }
  }
  
  void setDegree(float degree) {
    imageRotate = degree;
  }
  
  void setPos(float posX, float posY) {
    imagePositionX = posX;
    imagePositionY = posY;
  }
  
  void setSize(TuioCursor cursor1, TuioCursor cursor2) {
    imageWidth = Math.abs(cursor1.getX() - cursor2.getX()) * SCREEN_SIZE_X;
    imageHeight = Math.abs(cursor1.getY() - cursor2.getY()) * SCREEN_SIZE_Y;
  }
  
  void setSize(float incWidth, float incHeight) {
    imageWidth += incWidth;
    imageHeight += incHeight;
  }
  
  long getIntervalTime() {
    if (time == 0) {
      setCollidedTime();
      return 9999;
    } else {
      long intervalTime = System.currentTimeMillis() - time;
      if (intervalTime < 500) {
        return intervalTime;
      } else {
        setCollidedTime();
        return 9999;
      }
    }
  }
  
  void setCollidedTime() {
    time = System.currentTimeMillis(); 
  }
  
  void display() {
    pushMatrix();
      translate(imagePositionX, imagePositionY);
      rotate( radians(imageRotate) );
      translate(- imageWidth / 2, - imageHeight / 2);
      image(img, 0, 0, imageWidth, imageHeight);
    popMatrix();
  }
}
