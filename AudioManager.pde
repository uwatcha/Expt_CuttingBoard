import processing.sound.*;

class AudioManager { // クラスをトップレベルにする
  final private Music music;
  
  private AudioManager(PApplet parent) {
    music = new Music(parent, "musics/KaeruNoPiano.mp3", 120);
  }
  
  public void playMusic() {
    music.play();
  }
}
