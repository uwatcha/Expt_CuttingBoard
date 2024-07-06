class Ring {
  final private color COLOR = RING;
  final private float INITIAL_RADIUS;
  final private float STROKE = 12;
  final private float SHRINK_SPEED;
  private int justFrame;
  private Note note;
  private PVector coordinate;
  private float radius;

  public Ring(Note note, int justFrame) {
    INITIAL_RADIUS = note.getRadius() * 4;
    this.justFrame = justFrame;
    this.note = note;
    coordinate = note.getCoordinate();
    radius = INITIAL_RADIUS;
    SHRINK_SPEED = (INITIAL_RADIUS-note.getRadius())/justFrame;
  }

  public void run() {
    if (isActive()) {
      shrink();
      display();
    }
  }

  private void display() {
    ringDisplay(coordinate, radius, STROKE, COLOR);
  }
  private void shrink() {
    radius -= SHRINK_SPEED;
  }
  private boolean isActive() {
    return roopingFrameCount <= justFrame+BAD_FRAME;
  }
}
//ノーツより大きい半径の円を、justFrameでちょうど円に重なるように縮める
//開始タイミングは生成の瞬間
//終了タイミングは時間切れによる自動破棄の瞬間
