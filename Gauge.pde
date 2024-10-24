class Gauge {
  final private int X = width*3/4;
  final private int Y = height/5;
  final private int SIZE = 200;
  final private color FRAME_COLOR = DARK_GREY;
  final private color FILL_COLOR = LIGHT_GREY;
  private boolean isActive;
  private int fillHeight;
  
  Gauge() {
    setIsActive();
    fillHeight = 0;
  }
  
  public void run() {
    if (isActive) {
      calcFillHeight();
      displayFrame();
      displayFill();
    }
  }
  
  public void setIsActive() {
    isActive = faciSettings.myGetBoolean(isActiveGauge);
  }
  
  private void calcFillHeight() {
    int subtractedLoopFrame = loopFrame-(int)sec(0.1);
    if (subtractedLoopFrame >= 0) {
      fillHeight = subtractedLoopFrame;
    } else {
      if (playingFrame < touchIntervalFrame) {
        fillHeight = 0;
      } else {
        fillHeight = touchIntervalFrame+subtractedLoopFrame;
      }
    }
    fillHeight = (int)map(fillHeight, 0, touchIntervalFrame, 0, SIZE);
  }
  
  public void displayFrame() {
    if (isActive) {
      displaySquare(X, Y, SIZE, STROKE_DEFAULT, FRAME_COLOR, BLACK);
    }
  }
  
  private void displayFill() {
    displayRect(X, Y, SIZE, fillHeight, STROKE_DEFAULT, FILL_COLOR);
  }
}
