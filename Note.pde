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
    this.changeActive();
    print("state is ");
    println(active ? "active" : "inactive");
    if (active) {
      println("note displaying");
      image(noteImage, coordinate.x, coordinate.y);
    }
  }
  
  public void changeActive() {
    if (frame%60 == 0) {
      active = !active;
    }
  }
}
