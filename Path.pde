import geomerative.*;

class MapPath {
  RShape grp;
  RPoint[][] pointPaths;
  boolean ignoringStyles = false;

  String pathName = "kendall_map_02_cVector.svg";

  //A point that wiil follow a path
  PointPath [] paths;
  int numPaths = 0;

  //number of moving objets in the scene
  int numPoints = 1;

  MapPath(PApplet papplet ) {

    //generate the path
    RG.init(papplet);
    RG.ignoreStyles(ignoringStyles);

    RG.setPolygonizer(RG.ADAPTATIVE);

    grp = RG.loadShape(pathName);
    grp.centerIn(g, 100, 1, 1);

    pointPaths = grp.getPointsInPaths();

    //fill the path with a particle
    numPaths = pointPaths.length;

    if (numPaths == 0) {
      println("no paths are in the SVG file");
    }

    paths = new PointPath[numPoints];

    println(pointPaths.length);

    for (int i = 0; i < numPoints; i++) {

      int indexPath = (int)random(0, pointPaths.length - 1);
      paths[i] = new PointPath(indexPath);

      int lengthP = pointPaths[indexPath].length;


      paths[i].setNumPoints(lengthP);

      paths[i].reset();
      int curr = paths[i].getCurrInc();
      int next = paths[i].getNexInt();

      RPoint sp = pointPaths[i][curr];
      RPoint fp = pointPaths[i][next];

      paths[i].setStart(sp.x, sp.y);
      paths[i].setFinal(fp.x, fp.y);
    }
  }

  void update() {
  }

  void draw() {
    for (int i = 0; i < paths.length; i++) {
      float sX = paths[i].currentX;
      float sY = paths[i].currentY;
      
      noStroke();
      fill(255);
      ellipse(sX, sY, 5, 5);
    }
  }


  void drawPath() {
    for (int i = 0; i < pointPaths.length; i++) {
      if (pointPaths[i] != null) {
        stroke(255);
        noFill();
        beginShape();
        for (int j = 0; j<pointPaths[i].length -1; j++) {
          vertex(pointPaths[i][j].x, pointPaths[i][j].y);
        }
        endShape();
      }
    }
  }

  void updatePath() {
    for (int i = 0; i < paths.length; i++) {
      paths[i].draw();
      paths[i].update();

      noFill();

      if (paths[i].isDone()) {
        //update new first and last
        paths[i].reset();
        paths[i].incPath();

        //reset path index SVG 
        if (paths[i].isDonePath()) {
          int indexPath = (int)random(0, pointPaths.length - 1);
          paths[i].setPathIndex(indexPath);

          int lengthP = pointPaths[indexPath].length;
          paths[i].setNumPoints(lengthP);

          // println(indexPath+" "+i);
        }

        int curr = paths[i].getCurrInc();
        int next = paths[i].getNexInt();
        int indexSVG =  paths[i].getPathIndex();

        RPoint sp = pointPaths[indexSVG][curr];
        RPoint fp = pointPaths[indexSVG][next];

        paths[i].setStart(sp.x, sp.y);
        paths[i].setFinal(fp.x, fp.y);
      }
    }
  }
}
