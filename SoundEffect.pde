class SoundEffect {
  private SoundFile soundEffect;
  
  public SoundEffect(PApplet parent, String fileName) {
    soundEffect = new SoundFile(parent, fileName);
  }
  
  public void play() {
    if (!soundEffect.isPlaying()) {
      soundEffect.play();
    }
  }
}
