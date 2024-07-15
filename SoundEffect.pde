class SoundEffect {
  private AudioPlayer GOOD;
  private AudioPlayer BAD;
  
  public SoundEffect() {
    GOOD = minim.loadFile("SEs/good.mp3");
    BAD = minim.loadFile("SEs/bad.mp3");
  }
  
  public void playGood() {
    if (!GOOD.isPlaying()) {
      GOOD.play();
    }
  }
  
  public void playBad() {
    if (!BAD.isPlaying()) {
      BAD.play();
    }
  }
}
