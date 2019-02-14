//libraries
import controlP5.*;
import hypermedia.net.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import java.util.Vector;
import java.lang.reflect.Method;

//audio
Minim minim;

//Graphics
PGraphics pg;

//SoundScape
String city = "Boston";
SoundScape soundScape;

//Master control
MasterControl masterControl;

//GUI
ControlP5 cp5;

//UDP
UDP udp;

//density modifier
ArrayList<Density> densityList;
boolean onceDensity = true;

//Draw Map
MapRender mapRender;

boolean drawMap = true;
boolean drawPath = true;

//Map SVG
MapPath mapPath;

float scaleW = 0.0;
float scaleH = 0.0;

//setup
void setup() {


  //graphics setup
  size(1594, 851);
  smooth(8);

  //graphics
  pg = createGraphics(1594, 851);

  //network
  setupNetwork();

  //gui
  cp5 = new ControlP5(this);

  //audio
  minim = new Minim(this);

  //loading a soundScape
  soundScape = new SoundScape(city, 20, 20);
  soundScape.createGUI();

  //load master control interface
  masterControl = new MasterControl("Master", 1200, 540);

  //density manager
  densityList = new ArrayList<Density>();

  //
  {//low
    Density den = new Density("low", 0);
    den.addSoundFile("Truck_0");
    den.addSoundFile("Car_0");
    den.addSoundFile("Truck_2");
    densityList.add(den);
  }

  {//low
    Density den = new Density("m-low", 1);
    den.addSoundFile("Truck_1");
    den.addSoundFile("Car_1");
    densityList.add(den);
  }

  //Map
  mapRender = new MapRender();

  //Map SVG
  mapPath = new MapPath(this);


  //1594, 851
  scaleW = 1594.0/1600.0;
  scaleH = 851.0/900.0;

  println(scaleW+" "+scaleH);
}

void draw() {
  background(150);

  //update progress bar
  updateProgress();

  if (drawMap) {
    mapRender.drawMap();
  }

  if (drawPath) {
    pushMatrix();
    translate(width/2.0 -270, height/2.0 -20);
    //scale(scaleW, scaleH);
    mapPath.draw();
    mapPath.drawPath();
    mapPath.updatePath();
    popMatrix();
  }
}

//update progress
void updateProgress() {

  //repeat sound

  for (UrbanClass uc : soundScape.urbanClass) {
    for (UrbanSound sounds : uc.sounds) {
      cp5.getController(sounds.progressName).setValue(sounds.getProgress());
      //if (sounds.isFinish()) {
      // println("finish p");
      //((controlP5.Toggle)cp5.getController(sounds.toggleName)).setState(false);
      if (sounds.isLoop()) {
        println("finish l");
        sounds.rewind();
      }
      //}
    }
  }


  //update volumen
  for (UrbanClass uc : soundScape.urbanClass) {
    for (UrbanSound sounds : uc.sounds) {
      float vol = ((controlP5.Slider)cp5.getController(sounds.volumenName)).getValue();
      // sounds.setVolume(vol);
    }
  }


  //update spectrum
  for (UrbanClass uc : soundScape.urbanClass) {
    for (UrbanSound sounds : uc.sounds) {
      if (sounds.loadPlayer() ) {
        uc.spectrumCanvas.addSpectrum(sounds.player.left.toArray(), sounds.player.right.toArray(), sounds.player.bufferSize());
      }
    }
  }

  //master density
}
/*
     Play a sequence of sounds depending of the density value
 */


void checkDensity(int densityIde) {

  ArrayList<String> desity = densityList.get(densityIde).getSoundNames();
  println("changed to: "+densityList.get(densityIde).tag);

  for (UrbanClass uc : soundScape.urbanClass) {
    for (UrbanSound sounds : uc.sounds) {

      //update the current density value
      for (String den : desity) {
        if (sounds.soundName.equals(den)) {
          sounds.playSound();
        }
      }
    }
  }
}


void keyPressed() {
  if (key == 'm') {
    drawMap= !drawMap;
  }
  if (key == 'p') {
    drawPath = !drawPath;
  }

  if (key == '1') {
    scaleW +=0.01;
    println(scaleW+" "+scaleH);
  }

  if (key == '2') {
    scaleW -=0.01;
    println(scaleW+" "+scaleH);
  }


  if (key == '3') {
    scaleH +=0.01;
    println(scaleW+" "+scaleH);
  }

  if (key == '4') {
    scaleH -=0.01;
    println(scaleW+" "+scaleH);
  }
}
