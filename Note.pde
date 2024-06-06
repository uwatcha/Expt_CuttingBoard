class Note{
  final private float ACTIVE_RATE = 1/6;
  private PImage noteImage;
  private PVector coordinate;
  //private PVector velocity;
  private float radius;
  private boolean active;
  
  Note(float x, float y, PImage noteImage) {
    this.noteImage = noteImage;
    coordinate = new PVector(x, y);
    radius = noteImage.width/2;
    active = false;
  }
  
  public void display() {
    this.changeActive();
    if (active) {
      image(noteImage, coordinate.x, coordinate.y);
    }
  }
  
  public Judgments judgeTouch() {
    if (getTouchedPointer()!=null) {
      if (active) {
        return Judgments.Good;
      } else {
        return Judgments.Bad;
      }
    } else {
      return null;
    }
  }
  
  public void changeActive() {
    if (0 < (frame%60)&&(frame&60) < frameRate*ACTIVE_RATE) {
      this.active = true;
    } else {
      this.active = false;
    }
  }
  
  public processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch: touches) {
      if (dist(touch.x, touch.y, this.coordinate.x, this.coordinate.y) <= radius) {
        return touch;
      }
    }
    return null;
  }
}
