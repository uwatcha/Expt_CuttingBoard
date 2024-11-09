class Gauge {
  private final int X = width*3/4;
  private final int Y = height/5;
  private static final int SIZE = 200;
  private final color FRAME_COLOR = colors.DARK_GREY;
  private final color FILL_COLOR = colors.LIGHT_GREY;
  private static final int HUMAN_REACTION_OFFSET = 100;
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
      displaySquare(X, Y, SIZE, STROKE_DEFAULT, FRAME_COLOR, colors.BLACK);
    }
  }
  
  private void displayFill() {
    displayRect(X, Y, SIZE, fillHeight, STROKE_DEFAULT, FILL_COLOR);
  }
}
