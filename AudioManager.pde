//音関係のライブラリ
import processing.sound.*;

class AudioManager {
  final private SoundFile music1;
  final private SoundFile effect1;
  
  public AudioManager (PApplet parent) {
    music1 = new SoundFile(parent, "music1.wav");
    effect1 = new SoundFile(parent, "effect1.wav");
  }
}
