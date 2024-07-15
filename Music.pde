import processing.sound.*;

class Music {
  private AudioPlayer music;
  final private float BPM;
  
  public Music(String fileName, float bpm) {
    music = minim.loadFile(fileName);
    BPM = bpm;
  }
  
  public void play() {
    if (!music.isPlaying()) {
      music.play();
    }
  }
  
  public float getBpm() { return BPM; }
}
