class Gauge {
  final private PVector COORD = GAUGE_COORD;
  final private float SIZE = GAUGE_SIZE;
  final private color FRAME_COLOR = DARK_GREY;
  final private color FILL_COLOR = LIGHT_GREY;
  
  Gauge() {}
  
  public void run() {
    displayFrame();
    displayFill();
  }
  
  private void displayFrame() {
    displaySquare(COORD, SIZE, STROKE_DEFAULT, FRAME_COLOR);
  }
  
  private void displayFill() {
    displayRect(COORD, SIZE, getGaugeHeight(), STROKE_DEFAULT, FILL_COLOR);
  }
  
  private float getGaugeHeight() {
    return map(loopFrame, 0, TOUCH_INTERVAL, 0, GAUGE_SIZE);
  }
}
