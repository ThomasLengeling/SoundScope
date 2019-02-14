/*
Master control for the sounds and soundScapes
 */
class MasterControl {

  //GUI
  Accordion accordionMaster;
  Group soundMaster;
  String controlName;

  float posX;
  float posY;

  //generate Master Controls 
  MasterControl(String controlName, float posX, float posY) {
    this.controlName = controlName;
    this.posX = posX;
    this.posY = posY;

    //accordion
    accordionMaster = cp5.addAccordion(this.controlName)
      .setPosition(posX, posY)
      .setWidth(340);

    this.accordionMaster.setCollapseMode(Accordion.MULTI);

    //add to group master
    this.soundMaster = cp5.addGroup(this.controlName+" Sound")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(200);

    //sliders
    float startX = 10;
    float startY = 20;

    //density
    cp5.addSlider("density")
      .setRange( 0, 9 )
      .setPosition(startX, startY)
      .moveTo(this.soundMaster)
      .setValue( 5 )
      .setSize(200, 20)
      .plugTo(this, "updateDensity")
      .setNumberOfTickMarks(10)
      .setColorForeground(color(255, 0, 0));

    //trafic
    cp5.addSlider("traffic")
      .setRange( 0, 255 )
      .setPosition(startX, startY + 50)
      .moveTo(this.soundMaster)
      .setValue( 0 )
      .setSize(200, 20)
      .plugTo(this, "updateTraffic")
      .setNumberOfTickMarks(10)
      .setColorForeground(color(255, 0, 0));

    //start
    cp5.addToggle("Start")
      .setPosition(startX, startY + 90)
      .setSize(35, 35)
      .moveTo(this.soundMaster);

    //edn
    cp5.addToggle("End")
      .setPosition(startX + 50, startY+ 90)
      .setSize(35, 35)
      .moveTo(this.soundMaster);

    //Chage city
    cp5.addSlider("City")
      .setRange( 1, 5 )
      .setPosition(startX + 280, startY)
      .moveTo(this.soundMaster)
      .setValue(0)
      .setSize(20, 150)
      .setNumberOfTickMarks(5);

    //add to the group
    this.accordionMaster.addItem(this.soundMaster);

    println("created Master");
  }

  //update activated sounds for density
  void updateDensity(float val) {
    int densityIndex = int(val);

    //stop all sounds
    for (UrbanClass uc : soundScape.urbanClass) {
      for (UrbanSound sounds : uc.sounds) {
        sounds.reset();
      }
    }

    /*
    //change value of the density
     */
    if (densityIndex == 0) {
      println("low density"); 
      checkDensity(0);
      //update
    }
    if (densityIndex == 1) {
      println("mid-low density"); 
      checkDensity(1);
    }
  }

  //update activated soudns for traffic
  void updateTraffic() {
    println("traffic");
  }
}
