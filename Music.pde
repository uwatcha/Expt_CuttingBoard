import processing.sound.*;

class Music {
  private SoundFile music;
  final private float BPM;
  
  public Music(SoundFile soundFile, float bpm) {
    music = soundFile;
    BPM = bpm;
  }
  
  public void play() {
    if (!music.isPlaying()) {
      music.play();
    }
  }
  
  public float getBpm() { return BPM; }
}
