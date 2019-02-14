/*
Groups of UrbanSounds
 */
class UrbanClass {
  
  //class of group sounds
  String name;

  //sound vector
  Vector<UrbanSound> sounds; 

  //group
  Group soundGroupGUI;
  
  //spectrum Audio
  SprectumAudio spectrumCanvas;
  
  int groupId = 0;
  
  //load all the sounds from the class
  UrbanClass(String name, String city, int groupId) {
    
    this.spectrumCanvas = new SprectumAudio();
    this.name = name;
    this.groupId =groupId;

    //gui
    this.soundGroupGUI = cp5.addGroup(name+" "+this.groupId)
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(150);
       
    this.sounds = new Vector<UrbanSound>();

    String path = sketchPath();
    File folder = new File(path+"/data/"+city+"/"+name);

    //load files 
    File[] files = folder.listFiles();

    int i = 0;
    int stepY  = 40;
    int stepX  = 110;
    
    int startX = 20;
    int startY = 20;

    for (File file : files) {
      String dirName = "/"+city+"/"+name+"/"+file.getName();
      String soundName = name+"_"+i;

      println(file.getName());
      println(dirName);
      println(soundName);

      UrbanSound us = new UrbanSound(dirName, soundName);
      sounds.add(us);

      //labels for the GUI
      us.volumenName  = "volumen_"+soundName;
      us.progressName = "p"+soundName;
      us.toggleName   = "bang_"+soundName;
      us.timeName     = "t_"+soundName;
      us.loopName     = "l_"+soundName;
      
      //add GUI
      cp5.addSlider(us.volumenName )
        .setRange( 0.0, 1.0 )
        .setPosition(startX + stepX, startY + i*stepY*2.6)
        .moveTo(this.soundGroupGUI)
        .setValue( 1.0 )
        .setSize(130, 10)
        .plugTo(us, "volumen" );

      //progress name
      cp5.addSlider(us.progressName)
        .setRange( 0, 255 )
        .setPosition(startX + stepX, startY + i*stepY*2.6 + stepY/3.0)
        .moveTo(this.soundGroupGUI)
        .setValue( 0 )
        .plugTo(us, "progress" )
        .setLabelVisible(false)
        .setSize(130, 10)
        .setColorForeground(color(255, 0, 0));
        
      //time sequence
      cp5.addSlider(us.timeName)
        .setPosition(startX + stepX, startY + i*stepY*2.6 + stepY/1.5)
        .moveTo(this.soundGroupGUI)
        .setSize(130, 10)
        .setNumberOfTickMarks(10)
        .plugTo(us, "updateTime" );

      //toogle Name
      cp5.addToggle(us.toggleName)
        .setPosition(startX, startY + i*stepY*2.6- 10)
        .setSize(35, 35)
        .moveTo(this.soundGroupGUI)
        .plugTo(us, "toogle" );

      //timer loop
      cp5.addToggle(us.loopName)
        .setPosition(startX * 3.5, startY + i*stepY*2.6)
        .setSize(12, 12)
        .moveTo(this.soundGroupGUI)
        .plugTo(us, "loop" );

      i++;
    }

    this.soundGroupGUI.setBackgroundHeight( int(2.8 * stepY) * i );
   this.soundGroupGUI.addCanvas(this.spectrumCanvas);
  }
  
  int getGroupId(){
   return groupId; 
  }
}
