import processing.sound.*;

class AudioManager {
  final private Music music;

  private AudioManager() {
    music = new Music(music0, 120);
  }
  
  public void playMusic() {
    music.play();
  }
}
