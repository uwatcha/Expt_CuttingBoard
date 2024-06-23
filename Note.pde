class Note{
  final private float ACTIVE_RATE = 3.0f/6.0f;
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
  
  public void run() {
    changeActive();
    if (active) {
      image(noteImage, coordinate.x, coordinate.y);
    }
  }
  
  private void changeActive() {
    if (0 < frame&&frame < frameRate*ACTIVE_RATE) {
      active = true;
    } else {
      active = false;
    }
  }

  //ゲッター
  public PVector getCoordinate() { return this.coordinate; }
  public float getRadius() { return this.radius; }
  public boolean getActive() { return this.active; }
}
