class Note {
  private PImage image;
  private PVector coordinate;
  private float radius;
  
  public Note(PVector coordinate) {
    image = noteImage;
    this.coordinate = coordinate;
    radius = noteImage.width/2;
  }

  public void run() {
    image(image, coordinate.x, coordinate.y);
  }
  public PVector getCoordinate() {
    return this.coordinate;
  }
  public float getRadius() {
    return this.radius;
  }
}
