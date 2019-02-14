/*
Class that manges all the density values
 */

class Density {

  //name of the sound file to play
  ArrayList<String> sounFiles;
  String tag;
  int id;
  
  //repetitions
  int repetition;

  //setup of density
  Density(String tag, int id) {
    this.tag = tag;
    this.id  = id;
    sounFiles = new ArrayList<String>();
  }

  //add sound file to the array
  void addSoundFile(String file) {
    sounFiles.add(file);
  }

  //update density values
  void update() {
  }
  
  ArrayList<String> getSoundNames(){
     return sounFiles; 
  }
  
}
