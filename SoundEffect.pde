class SoundEffect {
  final private SoundFile GOOD;
  final private SoundFile NICE;
  final private SoundFile BAD;
  
  public SoundEffect() {
    GOOD = new SoundFile(applet, "SEs/good.mp3");
    NICE = new SoundFile(applet, "SEs/nice.mp3");
    BAD = new SoundFile(applet, "SEs/bad.mp3");
  }
  
  public void playGood() {
    if (!GOOD.isPlaying()) {
      GOOD.play();
    }
  }
  
  public void playNice() {
    if (!NICE.isPlaying()) {
      NICE.play();
    }
  }
  
  public void playBad() {
    if (!BAD.isPlaying()) {
      BAD.play();
    }
  }
}
