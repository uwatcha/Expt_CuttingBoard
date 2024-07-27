import processing.sound.*;

class Music {
  private SoundFile music;
  private float bpm;
  
  public Music(String fileName, float bpm) {
    music = new SoundFile(applet, fileName);
    this.bpm = bpm;
  }
  
  public void play() {
    if (!music.isPlaying()) {
      music.play();
    }
  }
  
  public void stop() {
    if (music.isPlaying()) {
      music.stop();
    }
  }
  
  public float getBpm() { return bpm; }
}
