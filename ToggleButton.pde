class ToggleButton {
  final private PVector COORDINATE;
  final private PVector TEXT_OFFSET = new PVector(0, -30);
  final private float NOB_RADIUS = 100;
  final private String TEXT;
  
  ToggleButton(PVector coordinate, String text) {
    COORDINATE = coordinate;
    TEXT = text;
  }
  
  public void run() {
    displayText(TEXT, COORDINATE.add(TEXT_OFFSET), BUTTON_TEXT_SIZE, BLACK);
    displayButton();
  }
  
  private void displayButton() {
    displaySlider();
    displayNob();
  }
  
  private void displaySlider() {
    noStroke();
    fill(WHITE);
    rect(COORDINATE.x, COORDINATE.y, NOB_RADIUS*2, NOB_RADIUS);
    circle(COORDINATE.x-NOB_RADIUS, COORDINATE.y, NOB_RADIUS*2);
    circle(COORDINATE.x+NOB_RADIUS, COORDINATE.y, NOB_RADIUS*2);
  }
  
  private void displayNob() {
    float nobX = COORDINATE.x + (getState(isActiveFeedback) ? -NOB_RADIUS : NOB_RADIUS);
    strokeWeight(3);
    fill(getState(isActiveFeedback) ? WHITE : GREY);
    circle(nobX, COORDINATE.y, NOB_RADIUS);
  }
  
  private boolean getState(String key) {
    return faciSettingJSON.getJSON().getBoolean(key);
  }
  private void setState(String key, boolean value) {
    faciSettingJSON.getJSON().setBoolean(key, value);
  }
  
  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (true/*長方形の当たり判定*/) {
      }
    }
    return touches[0];
  }

}
