class Note {
  private PImage noteImage;
  private PVector coordinate;
  //private PVector velocity;
  private float radius;
  private boolean active;
  
  Note(float x, float y) {
    noteImage = noteImage;
    coordinate = new PVector(x, y);
    radius = 100;
    active = false;
  }
  
  public void display() {
    if (true/*active*/) image(noteImage, coordinate.x, coordinate.y);
  }
  
  public void changeActive() {
    if (frame%60 == 0) {
      active = !active;
    }
  }
}
