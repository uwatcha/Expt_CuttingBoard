class Note {
  private PVector coordinate;
  private float radius;
  
  public Note(PVector coordinate) {
    this.coordinate = coordinate;
    radius = noteImage.width/2;
  }

  public void run() {
    image(noteImage, coordinate.x, coordinate.y);
  }
  public PVector getCoordinate() {
    return this.coordinate;
  }
  public float getRadius() {
    return this.radius;
  }
}
