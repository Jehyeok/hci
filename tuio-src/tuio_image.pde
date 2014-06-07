import java.awt.Image;
import java.util.*;
// Processing & TUIO import
import processing.core.*;
import TUIO.*;

  TuioClient client = null;
  long sessionId;
  Photo collidedPhoto;
  PhotoBook collidedPhotoBook;
  float firstPosX;
  float secondPosX;
  float incWidth;
  float firstPosY;
  float secondPosY;
  float incHeight;
  float firstDistribution;
  float secondDistribution;
  
  TuioCursor cursor1 = null;
  TuioCursor cursor2 = null;
  TuioCursor firstCursor = null;
  TuioCursor secondCursor = null;
  // Window Size
  final static int SCREEN_SIZE_X = 1280;
  final static int SCREEN_SIZE_Y = 800;
 
  PhotoBook photoBook;
  ArrayList<Photo> photoList = new ArrayList<Photo>();
  // 1. Setup
  public void setup() {
    // 1. Create TuioClient
    client = new TuioClient();
    client.connect();

    size(SCREEN_SIZE_X, SCREEN_SIZE_Y);
  }

  // 2. draw
  public void draw() {
    // call multi-touch values and update
    updateImageData();
    // set Background color
    background(100);
    // drawing
    if (photoBook != null) {
      photoBook.display();
    }
    
    for (Photo photo : photoList) {
      photo.display();
    }
  }

  // 3. update data
  
  boolean isCollided(TuioCursor tuioCursor) {
    int size = photoList.size();
    for (int i = 0; i < size; i++) {
//      System.out.println("size: " + photoList.size());
      boolean temp = photoList.get(i).isCollided(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
      if (temp) {
        return true;
      }
    }
    return false;
  }
  
  boolean isCollidedPhotoBook(TuioCursor tuioCursor) {
    boolean temp = photoBook.isCollided(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
    return temp;
  }
  
  Photo getCollidedPhoto(TuioCursor tuioCursor) {
    int size = photoList.size();
    for (int i = 0; i < size; i++) {
      boolean temp = photoList.get(i).isCollided(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
      if (temp) {
        return photoList.get(i); 
      }
    }
    return null;
  }
  
  PhotoBook getCollidedPhotoBook(TuioCursor tuioCursor) {
    if (photoBook == null) {
      return null;
    }
    boolean temp = photoBook.isCollided(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
    if (temp) {
      return photoBook;
    }  
    return null;
  }
  
  boolean isIncX() {
    return Math.abs(firstPosX - secondPosX) < Math.abs(cursor1.getX() * SCREEN_SIZE_X - cursor2.getX() * SCREEN_SIZE_X);
  }
  
  boolean isIncY() {
    return Math.abs(firstPosY - secondPosY) < Math.abs(cursor1.getY() * SCREEN_SIZE_Y - cursor2.getY() * SCREEN_SIZE_Y);
  }
              
  float getDistributionX(Vector<TuioCursor> tuioCursors) {
    float sum = 0;
    float mean = 0;
    float distribution = 0;
    for (TuioCursor tuioCursor : tuioCursors) {
      sum += tuioCursor.getX() * SCREEN_SIZE_X; 
    }
    mean = sum / tuioCursors.size();
    for (TuioCursor tuioCursor : tuioCursors) {
      sum += tuioCursor.getX() * SCREEN_SIZE_X;
      distribution += (tuioCursor.getX() * SCREEN_SIZE_X - mean) * (tuioCursor.getX() * SCREEN_SIZE_X - mean); 
    }
    return distribution;
  }
  
  float getDistributionY(Vector<TuioCursor> tuioCursors) {
    float sum = 0;
    float mean = 0;
    float distribution = 0;
    for (TuioCursor tuioCursor : tuioCursors) {
      sum += tuioCursor.getY() * SCREEN_SIZE_Y; 
    }
    mean = sum / tuioCursors.size();
    for (TuioCursor tuioCursor : tuioCursors) {
      sum += tuioCursor.getY() * SCREEN_SIZE_Y;
      distribution += (tuioCursor.getY() * SCREEN_SIZE_Y - mean) * (tuioCursor.getY() * SCREEN_SIZE_Y - mean); 
    }
    return distribution;
  }
  
  boolean isInward(float distributionX, float distributionY) {
    return (distributionX < firstDistribution) && (distributionY < secondDistribution);
  }
  
  boolean isOutward(float distributionX, float distributionY) {
    return (distributionX > firstDistribution) && (distributionY > secondDistribution);
  }
  
  public void updateImageData() {
    
    
    int aliveCursor = client.getTuioCursors().size();
    switch (aliveCursor) {
    // if touch 1 finger
    // Image Position Modify
    case 1:
      Vector<TuioCursor> cursors = client.getTuioCursors();
      // loop - find cursor ( cursorID == 0 )
      for (TuioCursor tuioCursor : cursors) {
        // one finger
        if (0 == tuioCursor.getCursorID()) {
          if (tuioCursor.getSessionID() != sessionId) {
            if (photoBook == null) {
              photoBook = new PhotoBook(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
            }
            
//            if (photoList.size() == 0) {
            if (false) {
//              Photo newPhoto = new Photo(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y); 
//              photoList.add(newPhoto);
              
              //moving
              
//              if (tuioCursor.isMoving()) {
//                newPhoto.setPos(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
//              }
            } else {              
              // not overlapped, then draw
              if (!isCollided(tuioCursor) ) {
//                photoList.add(new Photo(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y));
              }
              // collide
              else {
//                collidedPhoto = getCollidedPhoto(tuioCursor);
//                long intervalTime = collidedPhoto.getIntervalTime();
////                System.out.println("intervalTime: " + intervalTime);
//                // under 500ms, think as double tap
//                if (intervalTime < 500) {
//                  photoList.remove(collidedPhoto);
//                }
              }
              
              // photoBook tap
              if (isCollidedPhotoBook(tuioCursor)) {                
                photoList = photoBook.getPhotos();                
                long intervalTime = photoBook.getIntervalTime();
//
                // under 500ms, think as double tap
                if (intervalTime < 300) {
                  photoList = new ArrayList<Photo>();
                }
              }
              
            }
          }
//          System.out.println("isMoving(): " + tuioCursor.isMoving());
          if (tuioCursor.isMoving()) {
            collidedPhoto = getCollidedPhoto(tuioCursor);
            if (collidedPhoto != null) {  
              collidedPhoto.setPos(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
            }
            collidedPhotoBook = getCollidedPhotoBook(tuioCursor);
            if (collidedPhotoBook != null) {
              collidedPhotoBook.setPos(tuioCursor.getX() * SCREEN_SIZE_X, tuioCursor.getY() * SCREEN_SIZE_Y);
            }
          }
          
          firstPosX = 0;
          secondPosX = 0;
          firstPosY = 0;
          secondPosY = 0;
          incWidth = 0;
          incHeight = 0;
          sessionId = tuioCursor.getSessionID();
          firstDistribution = 0;
          secondDistribution = 0;
        }
      }
      break;
    // if touch 2 fingers
    // Image Size Modify
    case 2:
//      if (collidedPhoto != null) {
//        incWidth = collidedPhoto.getImgWidth();
//        incHeight = collidedPhoto.getImgHeight();
//      }
      // loop - find two cursors ( cursor ID == 0 && ID == 1 )
      for (TuioCursor tuioCursor : client.getTuioCursors()) {
        if (0 == tuioCursor.getCursorID()) {
          cursor1 = tuioCursor;
        }
        if (1 == tuioCursor.getCursorID()) {
//          System.out.println("collidedPhoto: " + collidedPhoto);
          if (collidedPhoto != null) {
            cursor2 = tuioCursor;
//            System.out.println("cursor1: " + cursor1);
//            System.out.println("cursor2: " + cursor2);
            if (cursor1 != null && cursor2 != null) {
//              System.out.println("resizing");
              
              if (firstPosX == 0) {
                firstPosX = cursor1.getX() * SCREEN_SIZE_X;
                secondPosX = cursor2.getX() * SCREEN_SIZE_X;
                firstPosY = cursor1.getY() * SCREEN_SIZE_Y;
                secondPosY = cursor2.getY() * SCREEN_SIZE_Y;
              } else {
                incWidth = (Math.abs(cursor1.getX() * SCREEN_SIZE_X - firstPosX)/2 + Math.abs(cursor2.getX() * SCREEN_SIZE_X - secondPosX)/2);
                incHeight = (Math.abs(cursor1.getY()  * SCREEN_SIZE_Y - firstPosY)/2 + Math.abs(cursor2.getY() * SCREEN_SIZE_Y - secondPosY)/2);

                if (!isIncX()) {
                  incWidth *= -1;
                }
                
                if (!isIncY()) {                                 
                  incHeight *= -1;
                }
                
                firstPosX = cursor1.getX() * SCREEN_SIZE_X;
                secondPosX = cursor2.getX() * SCREEN_SIZE_X;
                firstPosY = cursor1.getY() * SCREEN_SIZE_Y;
                secondPosY = cursor2.getY() * SCREEN_SIZE_Y;
                collidedPhoto.setSize(incWidth, incHeight);
                
                float gradient = (cursor1.getY() - cursor2.getY()) / (cursor1.getX() - cursor2.getX());
                collidedPhoto.setDegree((float)(Math.atan(gradient) * 180.0 /  Math.PI));
                
              }
            }
          }
        }
      }
      break;
    // if touch 3 fingers
    case 3:
      break;
    case 4:
    default:
      
//      firstCursor = (TuioCursor)tuioCursors.get(1);
//      secondCursor = (TuioCursor)tuioCursors.get(tuioCursors.size());
      if (aliveCursor >= 3) {
        Vector tuioCursors = client.getTuioCursors();
        cursor1 = (TuioCursor)tuioCursors.firstElement();
        cursor2 = (TuioCursor)tuioCursors.lastElement();
        if (photoBook != null && photoList.size() != 0) {
          if (firstPosX == 0) {
            firstPosX = cursor1.getX() * SCREEN_SIZE_X;
            secondPosX = cursor2.getX() * SCREEN_SIZE_X;
            firstPosY = cursor1.getY() * SCREEN_SIZE_Y;
            secondPosY = cursor2.getY() * SCREEN_SIZE_Y;
            firstDistribution = getDistributionX(tuioCursors);
            secondDistribution = getDistributionY(tuioCursors);
          } else {
            incWidth = (Math.abs(cursor1.getX() * SCREEN_SIZE_X - firstPosX)/2 + Math.abs(cursor2.getX() * SCREEN_SIZE_X - secondPosX)/2);
            incHeight = (Math.abs(cursor1.getY()  * SCREEN_SIZE_Y - firstPosY)/2 + Math.abs(cursor2.getY() * SCREEN_SIZE_Y - secondPosY)/2);
            
            boolean isMoving = cursor1.isMoving() && cursor2.isMoving();
            
            // Outward Or Inward?
            if (isMoving && isInward(getDistributionX(tuioCursors), getDistributionY(tuioCursors))) {
              photoBook.movePhotosInward(getDistributionX(tuioCursors) - firstDistribution, getDistributionY(tuioCursors) - secondDistribution);
            } else if (isMoving && isOutward(getDistributionX(tuioCursors), getDistributionY(tuioCursors))) {
              photoBook.movePhotosOutward(incWidth, incHeight);
            }
            
            // update
            firstPosX = cursor1.getX() * SCREEN_SIZE_X;
            secondPosX = cursor2.getX() * SCREEN_SIZE_X;
            firstPosY = cursor1.getY() * SCREEN_SIZE_Y;
            secondPosY = cursor2.getY() * SCREEN_SIZE_Y;
            firstDistribution = getDistributionX(tuioCursors);
            secondDistribution = getDistributionY(tuioCursors);            
            
            }                    
          }
      }
      break;    
    }
  }

