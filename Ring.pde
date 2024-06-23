class Ring {
  final private color COLOR = RING;
  final private float INITIAL_RADIUS;
  final private float FINAL_RADIUS;
  final private float STROKE = 6;
  final private float SHRINK_RATE;
  final private int TILL_OVERLAP_FRAME = BAD_FRAME*2; //円が表示されてからノーツに重なるまでにかかるフレーム　定数名を改善する余地あり
  private int justFrame;
  private Note note;
  private PVector coordinate;
  private float radius;

  public Ring(Note note, int justFrame) {
    INITIAL_RADIUS = note.getRadius() * 2;
    FINAL_RADIUS = 335/400 * note.getRadius();
    this.justFrame = justFrame;
    this.note = note;
    coordinate = note.getCoordinate();
    radius = INITIAL_RADIUS;
    SHRINK_RATE = (INITIAL_RADIUS-note.getRadius())/TILL_OVERLAP_FRAME;
  }

  public void run() {
    if (justFrame - BAD_FRAME*2 < roopingFrameCount&&roopingFrameCount <= justFrame + BAD_FRAME) {
      shrink();
      ringDisplay(coordinate, radius, STROKE, COLOR);
    } else if (radius != INITIAL_RADIUS) {
      resetRadius();
    }
  }

  private void shrink() {
    //if (radius > FINAL_RADIUS) {
      radius -= SHRINK_RATE;
    //}
  }

  private void resetRadius() {
    radius = INITIAL_RADIUS;
  }
}
