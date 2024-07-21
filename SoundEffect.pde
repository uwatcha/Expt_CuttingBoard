class SoundEffect {
  private SoundFile GOOD;
  private SoundFile BAD;
  
  public SoundEffect() {
    GOOD = new SoundFile(applet, "SEs/good.mp3");
    BAD = new SoundFile(applet, "SEs/bad.mp3");
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
