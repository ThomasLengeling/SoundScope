/*

Class the manages the maping drawing

Point A -> B
*/

class MapRender{
  
  PImage imgMap;
  PImage imgPath;
  
  //SVG path
  
  MapRender(){
    imgMap = loadImage("kendall_map_02_c.png");
    
    //
    //imgPath
  }
  
  void drawMap(){
    image(imgMap, 0, 0, width, height);
  }
  
  void drawPath(){
    
  }
  
  void update(){
    
  }
  
  PVector getDim(){
    return new PVector(imgMap.width, imgMap.height);
  }
  

  
}
