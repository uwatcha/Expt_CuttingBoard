class Note {
  private PImage noteImage;
  private PVector coordinate;
  //private PVector velocity;
  private float radius;
  private boolean active;
  
  Note(float x, float y, PImage noteImage) {
    this.noteImage = noteImage;
    coordinate = new PVector(x, y);
    radius = 100;
    active = false;
  }
  
  public void display() {
    println("coordinate.x: "+coordinate.x);
    println("coordinate.y: "+coordinate.y);
    if (true/*active*/) image(noteImage, coordinate.x, coordinate.y);
  }
  
  public void changeActive() {
    if (frame%60 == 0) {
      active = !active;
    }
  }
}
