class Note{
  private PImage noteImage;
  private PVector coordinate;
  //private PVector velocity;
  private float radius;
  private boolean active;
  
  Note(float x, float y, PImage noteImage) {
    this.noteImage = noteImage;
    coordinate = new PVector(x, y);
    radius = noteImage.width/2;
    active = true;
  }
  
  public void display() {
    this.changeActive();
    if (active) {
      image(noteImage, coordinate.x, coordinate.y);
    }
  }
  
  public void changeActive() {
  }
  
  public processing.event.TouchEvent.Pointer getTouchPointer() {
    for (processing.event.TouchEvent.Pointer touch: touches) {
      if (dist(touch.x, touch.y, this.coordinate.x, this.coordinate.y) <= radius) {
        return touch;
      }
    }
    return null;
  }
}
