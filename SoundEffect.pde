class SoundEffect {
  final private SoundFile GOOD;
  final private SoundFile BAD;

  public SoundEffect(PApplet parent) {
    GOOD = new SoundFile(parent, "SEs/good.mp3");
    BAD = new SoundFile(parent, "SEs/bad.mp3");
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
