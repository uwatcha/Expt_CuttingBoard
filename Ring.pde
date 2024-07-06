class Ring {
  final private color COLOR = RING;
  final private float INITIAL_RADIUS;
  final private float FINAL_RADIUS;
  final private float STROKE = 12;
  final private float SHRINK_RATE;
  final private int TILL_OVERLAP_FRAME; //円が表示されてからノーツに重なるまでにかかるフレーム　定数名を改善する余地あり
  private int justFrame;
  private Note note;
  private PVector coordinate;
  private float radius;

  public Ring(Note note, int justFrame) {
    INITIAL_RADIUS = note.getRadius() * 4;
    FINAL_RADIUS = 335/400 * note.getRadius();
    this.justFrame = justFrame;
    this.note = note;
    coordinate = note.getCoordinate();
    radius = INITIAL_RADIUS;
    TILL_OVERLAP_FRAME = justFrame+BAD_FRAME;
    SHRINK_RATE = (INITIAL_RADIUS-FINAL_RADIUS)/TILL_OVERLAP_FRAME;
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
    radius -= SHRINK_RATE;
  }
  private boolean isActive() {
    return roopingFrameCount <= justFrame;
  }
}
//ノーツより大きい半径の円を、justFrameでちょうど円に重なるように縮める
//開始タイミングは生成の瞬間
//終了タイミングは時間切れによる自動破棄の瞬間
