class SoundEffect {
  private SoundFile GOOD;
  private SoundFile BAD;
  
  public SoundEffect() {
    GOOD = goodSE;
    BAD = badSE;
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
