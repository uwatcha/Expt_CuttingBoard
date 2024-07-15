import processing.sound.*;

class Music {
  private SoundFile music;
  private float bpm;
  
  public Music(PApplet parent, String fileName, float bpm) {
    music = new SoundFile(parent, fileName);
    this.bpm = bpm;
  }
  
  public void play() {
    if (!music.isPlaying()) {
      music.play();
    }
  }
  
  public float getBpm() { return bpm; }
}
