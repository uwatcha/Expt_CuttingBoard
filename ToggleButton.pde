//ボタンは移動する前提じゃないので、PVectorやめる
class ToggleButton {
  final private PVector COORD;
  final private PVector TEXT_OFFSET = new PVector(0, -30);
  final private float NOB_RADIUS = 100;
  final private String TEXT;
  
  ToggleButton(PVector coord, String text) {
    COORD = coord;
    TEXT = text;
  }
  
  public void run() {
    displayText(TEXT, COORD.add(TEXT_OFFSET), BUTTON_TEXT_SIZE, BLACK);
    displayButton();
    if (getTouchedPointer()!=null) {
      setState(isActiveFeedback, !getState(isActiveFeedback));
    }
  }
  
  private void displayButton() {
    displaySlider();
    displayNob();
  }
  
  private void displaySlider() {
    noStroke();
    fill(WHITE);
    rect(COORD.x, COORD.y, NOB_RADIUS*3, NOB_RADIUS*2);
    circle(COORD.x, COORD.y+NOB_RADIUS, NOB_RADIUS*2);
    circle(COORD.x+NOB_RADIUS*3, COORD.y+NOB_RADIUS, NOB_RADIUS*2);
  }
  
  private void displayNob() {
    float nobX = COORD.x + (getState(isActiveFeedback) ? 0 : NOB_RADIUS*3);
    strokeWeight(3);
    fill(getState(isActiveFeedback) ? WHITE : LIGHT_GREY);
    circle(nobX, COORD.y+NOB_RADIUS, NOB_RADIUS*2);
  }
  
  private boolean getState(String jsonKey) {
    return faciSettingJSON.getJSON().getBoolean(jsonKey);
  }
  private void setState(String key, boolean value) {
    faciSettingJSON.getJSON().setBoolean(key, value);
  }
  
  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (rectTouchJudge(COORD.x-NOB_RADIUS, COORD.y, NOB_RADIUS*5, NOB_RADIUS*2, touch.x, touch.y)) {
        return touch;
      }
    }
    return null;
  }

}
