class Gauge {
  final private int X = width*3/4;
  final private int Y = height/5;
  final private int SIZE = 200;
  final private color FRAME_COLOR = DARK_GREY;
  final private color FILL_COLOR = LIGHT_GREY;
  
  Gauge() {}
  
  public void run() {
    displayFrame();
    displayFill();
  }
  
  private void displayFrame() {
    displaySquare(X, Y, SIZE, STROKE_DEFAULT, FRAME_COLOR, BLACK);
  }
  
  private void displayFill() {
    displayRect(X, Y, SIZE, (int)getGaugeHeight(), STROKE_DEFAULT, FILL_COLOR);
  }
  
  private float getGaugeHeight() {
    return map(loopFrame, 0, TOUCH_INTERVAL, 0, SIZE);
  }
}
