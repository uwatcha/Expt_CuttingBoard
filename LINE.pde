class Line {
  final private color COLOR = LINE;
  final private float SPEED;
  final private int   JUST_FRAME;
  private float x;

  public Line(Note note, int showFrame, int justFrame) {
    JUST_FRAME = justFrame;
    x = INITIAL_LINE_X;
    SPEED = (INITIAL_LINE_X-STANDARD_LINE_X)/(justFrame-showFrame); //距離÷時間
  }

  public void run() {
    if (isActive()) {
      move();
      display();
    }
  }

  private void display() {
    displayVerticalLine(x, STANDARD_LINE_STROKE, COLOR);
  }
  private void move() {
    x -= SPEED;
  }
  private boolean isActive() {
    return frame <= JUST_FRAME+BAD_FRAME;
  }
}
