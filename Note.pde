class Note {
  private PImage noteImage;
  private PVector coordinate;
  //private PVector velocity;
  private float radius;

  public Note(PVector coordinate) {
    this.noteImage = loadImage("note.png");
    coordinate = new PVector(coordinate.x, coordinate.y);
    radius = noteImage.width/2;
  }

  public void run() {
    image(noteImage, coordinate.x, coordinate.y);
  }

  //ゲッター
  public PVector getCoordinate() {
    return this.coordinate;
  }
  public float getRadius() {
    return this.radius;
  }
  public boolean getActive() {
    return this.active;
  }
}
