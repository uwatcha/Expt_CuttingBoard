import processing.sound.*;

class Music {
  private SoundFile music;
  final private float bpm;
  
  public Music(String fileName, float bpm) {
    music = new SoundFile(applet, fileName);
    this.bpm = bpm;
  }
  
  public void play() {
    if (!music.isPlaying()) {
      music.play();
    }
  }
  
  public void pause() {
    if (music.isPlaying()) {
      music.pause();
    }
  }
  
  public float getBpm() { return bpm; }
}
