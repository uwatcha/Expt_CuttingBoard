class SoundEffect {
  private SoundFile soundEffect;
  private boolean hasPlayed;
  
  public SoundEffect(PApplet parent, String fileName) {
    soundEffect = new SoundFile(parent, fileName);
    hasPlayed = false;
  }
  
  public void play() {
    if (!hasPlayed) {
      soundEffect.play();
      hasPlayed = true;
    }
  }
  //タッチしたら再生できなくする
  //ノーツが非表示になったら再生できるようにする
  
}
