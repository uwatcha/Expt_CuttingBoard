import processing.sound.*;

class AudioManager { // クラスをトップレベルにする
  final private SoundFile music;
  final private SoundFile goodSE;
  final private SoundFile badSE;
  
  private AudioManager(PApplet parent) {
    music = new SoundFile(parent, "musics/KaeruNoPiano.mp3");
    goodSE = new SoundFile(parent, "SEs/good.mp3");
    badSE = new SoundFile(parent, "SEs/bad.mp3");
  }
  
  public void playMusic() {
    if (!music.isPlaying()) {
      music.play();
    }
  }
  
  public void playGoodSE() {
    if (mousePressed) {
      goodSE.play();
    }
  }
  
  public void playBadSE() {
    if (mousePressed) {
      badSE.play();
    }
  }
}
