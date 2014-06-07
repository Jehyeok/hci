import java.awt.Image;

class PhotoBook{
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
  ArrayList<Photo> photoList = new ArrayList<Photo>();
  
  PhotoBook(float posX, float posY){
    img = loadImage("book.JPG");
    setPos(posX, posY);
    imageWidth = 200.0F;
    imageHeight = 200.0F;
    imageRotate = 0.0F;
    initPhotos(posX, posY);
  }
  
  void movePhotosOutward(float distDifference, float distDifferenceY) {
    for (int i = 0; i < photoList.size(); i++) {
      Photo photo = photoList.get(i);
      photo.goOurward(imagePositionX, imagePositionY, distDifference, distDifferenceY);
    }
  }
  
  void movePhotosInward(float distDifferenceX, float distDifferenceY) {
    for (int i = 0; i < photoList.size(); i++) {
      Photo photo = photoList.get(i);
      photo.goInward(imagePositionX, imagePositionY, distDifferenceX, distDifferenceY);
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
  
  void initPhotos(float posX, float posY) {
    Photo photo1 = new Photo(posX - 200, posY);
    Photo photo2 = new Photo(posX - 150, posY + 150); 
    Photo photo3 = new Photo(posX, posY + 300);
    Photo photo4 = new Photo(posX + 200, posY);
    Photo photo5 = new Photo(posX + 150, posY - 150);
    
    photoList.add(photo1);
    photoList.add(photo2);
    photoList.add(photo3);
    photoList.add(photo4);
    photoList.add(photo5);
  }
    
  void setPhotos(ArrayList<Photo> photoList) {
    this.photoList = photoList;
  }
  
  ArrayList<Photo> getPhotos() {
    return photoList;
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
