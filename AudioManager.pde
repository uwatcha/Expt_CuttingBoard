import processing.sound.*;

class AudioManager { // クラスをトップレベルにする
  final private Music music;
  //final private SoundEffect GOOD;
  //final private SoundEffect BAD;
  
  private AudioManager(PApplet parent) {
    music = new Music(parent, "musics/KaeruNoPiano.mp3", 120);
    //GOOD = new SoundEffect(parent, "SEs/good.mp3");
    //BAD = new SoundEffect(parent, "SEs/bad.mp3");
  }
  
  public void playMusic() {
    music.play();
  }
  //public void playGoodSE() {
  //  GOOD.play();
  //}
  //public void playBadSE() {
  //  BAD.play();
  //}
}
