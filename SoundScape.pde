/*
  A city SoundScape
 */
class SoundScape {

  //Urban class
  Vector<UrbanClass> urbanClass;

  //GUI for various accordions
  Vector<Accordion> accordions;
  Vector<Group> accMaster;

  //soundscape of the city
  String city;

  //position
  float guiPosX;
  float guiPosY;

  //soundSpace sound groups
  String  soundGroups [] = {"Motorized", "Nature", "People", "Mobility"};

  SoundScape(String city, float guiPosX, float guiPosY) {
    this.guiPosX = guiPosX;
    this.guiPosY = guiPosY;
    this.city = city;

    //Urban Class
    this.urbanClass = new Vector<UrbanClass>();

    //gui class
    accordions = new Vector<Accordion>();

    accMaster = new Vector<Group>();
    for (int i = 0; i < 4; i++) {
      Group master = cp5.addGroup("master")
        .setBackgroundColor(color(0, 64));
      accMaster.add(master);
    }

    //Fill the different sounds

    //Cars
    {
      UrbanClass uc = new UrbanClass("Car", city, 0);
      urbanClass.add(uc);
    }

    {
      UrbanClass uc = new UrbanClass("ambulance", city, 0);
      urbanClass.add(uc);
    }

    //Trucks
    {
      UrbanClass uc = new UrbanClass("moto", city, 1);
      urbanClass.add(uc);
    }

    //construction
    {
      UrbanClass uc = new UrbanClass("pedestrians", city, 2);
      urbanClass.add(uc);
    }

    //construction
    {
      UrbanClass uc = new UrbanClass("construction", city, 3);
      urbanClass.add(uc);
    }
  }


  //create GUI Groups
  void createGUI() {

    for (int i = 0; i < 4; i++) {
      Accordion  accordionClass;

      float posXGUI =  guiPosX + 360*i;
      float posYGUI =  guiPosY;

      String className = soundGroups[i];

      println("name "+className+" "+posXGUI+" "+posYGUI);

      accordionClass = cp5.addAccordion(className)
        .setPosition(posXGUI, posYGUI)
        .setWidth(340);

      // use Accordion.MULTI to allow multiple group 
      // to be open at a time.
      accordionClass.setCollapseMode(Accordion.MULTI);

      //add the group to the sound
      for ( UrbanClass urbanC : urbanClass) {
        if (i == urbanC.getGroupId()) {
          accordionClass.addItem(urbanC.soundGroupGUI);
        }
      }

      //add the accordion to the vector
     accordions.add(accordionClass);
     accMaster.get(i).add(accordionClass);
    }
  }
}
