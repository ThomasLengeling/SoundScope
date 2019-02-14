/*
Class for Point path.
*/
class PointPath {

  //positions
  float startX;
  float startY;

  float finalX;
  float finalY;

  float currentX;
  float currentY;

  //times
  float time;  
  float timeSpeed;

  //path index in relation with the SVG file
  int pathIndex =0;
  

  int numPoints = 0;

  int currPoint = 0;
  int nextPoint = 0;

  boolean done = false;

  //color and mobility
  int   typeMobility;
  color typeColor;
  int   alphaColor = 10;

  int pointSize = 1;

  //Point path
  PointPath(int  pi) {
    time = 0;
    currPoint = 0;
    nextPoint  = 1;
    pathIndex = pi;
    
    //movement
    timeSpeed = random(0.001, 0.01);
    
    //color
    typeMobility = 1;
    typeColor = color(0, 255, 0);
    
    pointSize = 2;
  }

  color getTypeColor() {
    return typeColor;
  }

  //set index path of the SVG file
  void setPathIndex(int pi){
    pathIndex = pi;
  }
  
  //get index path of the SVG file
  int getPathIndex() {
    return pathIndex;
  }

  void setNumPoints(int num) {
    numPoints = num;
  }

  void setStart(float sx, float sy) {
    this.startX = sx;
    this.startY = sy;
  }

  void setFinal(float fx, float fy) {
    this.finalX = fx;
    this.finalY = fy;
  }

  void update() {
    currentX =  time*(finalX - startX) + startX;
    currentY =  time*(finalY - startY) + startY;

    if (done == false) {
      time += timeSpeed;

      if (time > 1.0) {
        time = 1.0;
        done = true;
      }
    }
  }


  void reset() {
    time = 0;
    done = false;
    timeSpeed = random(0.001, 0.01);
  }

  boolean isDone() {
    return done;
  }

  void incPath() {
    currPoint++;
    nextPoint++;
  }

  boolean isDonePath() {
    if (currPoint == numPoints - 1) {
      currPoint = 0; //start
      nextPoint = 1; //start + 1

       //reset index of SVG Path

      return true;
    }
    return false;
  }

  int getCurrInc() {
    return currPoint;
  }

  int getNexInt() {
    return nextPoint;
  }
  
  //draw 
  void draw() {
    fill(150, 200);
    noStroke();
    ellipse(currentX, currentY, pointSize, pointSize);
  }
  
}
