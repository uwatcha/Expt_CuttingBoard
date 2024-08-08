class AudioManager {
  final private Music music;

  private AudioManager() {
    music = new Music("musics/KaeruNoPiano.mp3", 120);
  }
  
  public void playMusic() {
    music.play();
  }
  
  public void pauseMusic() {
    music.pause();
  }
}
