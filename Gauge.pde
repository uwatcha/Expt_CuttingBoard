class Gauge {
  final private int X = width*3/4;
  final private int Y = height/5;
  final private int SIZE = 200;
  final private color FRAME_COLOR = DARK_GREY;
  final private color FILL_COLOR = LIGHT_GREY;
  final private int HUMAN_REACTION_OFFSET = 100;
  private boolean isActive;
  private float fillHeight;
  
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
    int subtractedLoopMillis = loopPlayingMillis()-HUMAN_REACTION_OFFSET;
    if (subtractedLoopMillis >= 0) {
      fillHeight = subtractedLoopMillis;
    } else {
      if (playingMillis() < touchIntervalMillis) {
        fillHeight = 0;
      } else {
        fillHeight = touchIntervalMillis+subtractedLoopMillis;
      }
    }
    fillHeight = (int)map(fillHeight, 0, touchIntervalMillis, 0, SIZE);
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
