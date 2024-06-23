class Note{
  final private float ACTIVE_RATE = 3.0f/6.0f;
  private PImage noteImage;
  private PVector coordinate;
  //private PVector velocity;
  private float radius;
  private boolean active;
  private boolean hasTouched;
  
  Note(float x, float y, PImage noteImage) {
    this.noteImage = noteImage;
    coordinate = new PVector(x, y);
    radius = noteImage.width/2;
    active = false;
    hasTouched = false;
  }
  
  public void run() {
    changeActive();
    if (active) {
      image(noteImage, coordinate.x, coordinate.y);
    }
  }
  
  public Judgments judgeTouch() {
    if (getTouchedPointer()!=null && !hasTouched) {
      if (active) {
        hasTouched = true;
        return Judgments.Good;
      } else {
        hasTouched = true;
        return Judgments.Bad;
      }
    } else {
      return null;
    }
  }
  
  public void changeActive() {
    if (0 < frame&&frame < frameRate*ACTIVE_RATE) {
      active = true;
      hasTouched = false;
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
