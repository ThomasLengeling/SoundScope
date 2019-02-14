/*
Class to manage indivial sounds
 */
class UrbanSound {
  AudioPlayer player;
  FFT fftLog;

  boolean active;
  boolean loop;

  boolean playOnce;

  float volumen;
  int id;

  //
  String fileName;
  String soundName;

  //gui names
  String volumenName;
  String toggleName;
  String loopName;
  String progressName;
  String timeName;
  
  boolean loadPlayer = false;

  UrbanSound(String fileName, String soundName) {
    this.fileName = fileName;
    this.soundName = soundName;
    this.active = false;
    this.loop = false;
    
    this.player = minim.loadFile(this.fileName);
    this.loadPlayer = true;
    
    if(this.player !=null){
      this.loadPlayer = false;
    }
    this.playOnce = true;

    println("File Name: "+ this.fileName);
    println("Sound Name: "+this.soundName);
  }
  
  boolean loadPlayer(){
    return loadPlayer;
  }

  void toogle(boolean v) {
    println("play "+v);
    if ( player.isPlaying() ) {
      player.pause();
    } else {
      player.play();
    }

    if ( player.position() == player.length() ) {
      player.rewind();
    }
  }

  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  void rewind() {

    if ( player.position() == player.length() ) {

      player.rewind();

      if (loop) {
        player.play();
      }
    }
  }

  void reset() {
    player.rewind();
    player.pause();
    playOnce = true;
  }

  boolean isFinish() {
    if (player != null) {
      if (player.position()>=player.length()) {
        return true;
      }
      return false;
    }
    return false;
  }

  void update() {
  }

  void toogleLoop() {
    loop= !loop;
  }

  boolean isLoop() {
    return loop;
  }

  void volumen(float val) {
    float gain = map(val, 0, 1, -50, 30);
    player.setGain(gain);
    println(gain);
  }

  int getProgress() {
    if (player != null) {
      if (player.position()>=player.length()) {
        return 0;
      }

      return int(map(player.position(), 0, player.length(), 0, 255));
    }
    return 0;
  }

  void playSound() {


    if (playOnce) {
      if ( player.position() == player.length() ) {
        player.rewind();
        player.pause();
        playOnce = false;
      } else {
        player.play();
      }
    }
  }



  void progress(int val) {
    val = player.position();
    float posx = map(val, 0, player.length(), 0, 255);
  }

  void updateTime() {
  }

  void drawSpectrum() {
    stroke(255);

    for (int i = 0; i < player.bufferSize() - 1; i++) {
      line(i, 50  + player.left.get(i)*50, i+1, 50  + player.left.get(i+1)*50);
      line(i, 150 + player.right.get(i)*50, i+1, 150 + player.right.get(i+1)*50);
    }
  }
}

class AudioBuffer {
  float[] arrayLeft;
  float[] arrayRight;
  int arraySize;

  AudioBuffer() {
  }
}

class SprectumAudio extends Canvas {
  int id = 0;

  Vector<AudioBuffer> spectrumBuffer = new Vector<AudioBuffer>();

  public void setup(PGraphics pg) {
    println("starting a test canvas.");
  }

  void addSpectrum(float[] arrayLeft, float[] arrayRight, int arraySize) {

    AudioBuffer aBuffer = new AudioBuffer();
    aBuffer.arrayLeft  = arrayLeft.clone();
    aBuffer.arrayRight = arrayRight.clone();
    aBuffer.arraySize  = arraySize;
    spectrumBuffer.add(aBuffer);
  }

  public void draw(PGraphics pg) {

    pg.stroke(255);

    int j = 0;
    for (AudioBuffer buffer : spectrumBuffer) {
      pg.beginShape();
      for (int i = 0; i < buffer.arraySize - 1; i+=3) {
        float x = i/3.0;
        float y = 80  + buffer.arrayLeft[i]*10  +  j*100;
        pg.vertex(x, y);
      }
      pg.endShape();

      pg.beginShape();
      for (int i = 0; i < buffer.arraySize - 1; i+=3) {
        float x = i/3.0;
        float y = 100 + buffer.arrayRight[i]*10 + j*100;
        pg.vertex(x, y);
      }
      pg.endShape();

      j++;
    }
    spectrumBuffer.clear();
  }
}
