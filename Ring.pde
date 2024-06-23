class Ring {
  final private  color COLOR = GREEN;
  final private float INITIAL_RADIUS;
  final private float FINAL_RADIUS;
  final private float STROKE = 6;
  final private float SHRINK_RATE = 60.0f/frameRate;
  private Note note;
  private PVector coordinate;
  private float radius;

  public Ring(Note note) {
    INITIAL_RADIUS = note.getRadius() * 2;
    FINAL_RADIUS = 335/400 * note.getRadius();
    this.note = note;
    coordinate = note.getCoordinate();
    radius = INITIAL_RADIUS;
  }

  public void run(int index) {
    shrink();
    circleDisplay(coordinate, radius, STROKE, COLOR);
  }

  private void shrink() {
    if (radius > FINAL_RADIUS) {
      radius -= SHRINK_RATE;
    }
  }

  private void resetRing() {
    radius = INITIAL_RADIUS;
  }
}
//インデックスが0だったら、4拍子なら1拍目にちょうどリングが重なるようにリングを動かす
//消すのも時間で行う
