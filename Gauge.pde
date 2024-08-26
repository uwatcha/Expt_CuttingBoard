class Gauge {
  final private PVector COORD = GAUGE_COORD;
  final private float SIZE = GAUGE_SIZE;
  final private color FRAME_COLOR = DARK_GREY;
  final private color FILL_COLOR = LIGHT_GREY;
  private float gaugeValue;
  
  Gauge() {
    gaugeValue = 0;
  }
  
  public void run() {
    displayFrame();
    displayFill();
  }
  
  private void displayFrame() {
    displaySquare(COORD, SIZE, FRAME_COLOR);
  }
  
  private void displayFill() {
    displayRect(COORD, SIZE, getGaugeHeight(), FILL_COLOR);
  }
  
  private float getGaugeHeight() {
    gaugeValue = gaugeValue+1<TOUCH_INTERVAL ? gaugeValue+1 : 0;
    return map(gaugeValue, 0, TOUCH_INTERVAL, 0, GAUGE_SIZE);
  }
}
