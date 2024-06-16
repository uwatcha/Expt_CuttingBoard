class Note{
  final private float ACTIVE_RATE = 1.0f/6.0f;
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
    changeActive();
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
    if (0 < frame&&frame < frameRate*ACTIVE_RATE) {
      active = true;
    } else {
      active = false;
    }
  }
  
  public processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch: touches) {
      if (dist(touch.x, touch.y, coordinate.x, coordinate.y) <= radius) {
        return touch;
      }
    }
    return null;
  }
}
