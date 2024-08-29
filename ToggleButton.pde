//TODO: getTouchedPointerを改善
//TODO: 定数は、そのクラスでしか使わないものは、デカすぎないorそのクラスをたくさん実体化しない限り、そのクラス内で定義する。
//TODO: jsonを、各ページごとに要素を作り、それらの子要素にそのページで使う定数を要素として持つ
class ToggleButton {
  final private int X, Y;
  final private int TEXT_OFFSET_X, TEXT_OFFSET_Y;
  final private int SIZE_UNIT = 100;
  final private int DIAMETER = SIZE_UNIT*2;
  final private int RECT_WIDTH = SIZE_UNIT*2;
  final private String TITLE;
  final private int TITLE_SIZE = 60;
  final private String ON = "ON";
  final private String OFF = "OFF";
  final private color COLOR_ON = LIGHT_BLUE;
  final private color COLOR_OFF = LIGHT_GREY;
  final private int STATE_TEXT_SIZE = 80;
  final private int STATE_TEXT_X_ON;
  final private int STATE_TEXT_X_OFF;
  final private int STATE_TEXT_Y;
  final private int NOB_X_ON;
  final private int NOB_X_OFF;
  final private String JSON_KEY;
  private String stateText;
  private int titleX, titleY;
  private int stateTextX;
  private color sliderColor;
  private int nobX;
  private boolean hasTouched;
  
  ToggleButton(int x, int y, String jsonKey) {
    X = x-SIZE_UNIT;
    Y = y-SIZE_UNIT;
    TEXT_OFFSET_X = SIZE_UNIT;
    TEXT_OFFSET_Y = -70;
    titleX = X+TEXT_OFFSET_X;
    titleY = Y+TEXT_OFFSET_Y;
    STATE_TEXT_X_ON = X;
    STATE_TEXT_X_OFF = X+SIZE_UNIT*2;
    STATE_TEXT_Y = Y+SIZE_UNIT;
    NOB_X_ON = X+SIZE_UNIT*2;
    NOB_X_OFF = X;
    JSON_KEY = jsonKey;
    TITLE = BUTTON_TITLES.get(JSON_KEY);
    hasTouched = false;
    
    updateStateVariable(faciSettingJSON.getJSON().getBoolean(JSON_KEY));
  }
  
  public void run() {
    displayText(TITLE, titleX, titleY, TITLE_SIZE, BLACK);
    displayButton();
    if (isTouched()) {
      toggleState();
    }
    resetHasTouched();
  }
  
  private void displayButton() {
    displaySlider();
    displayNob();
  }
  
  private void displaySlider() {
    noStroke();
    fill(sliderColor);
    rect(X, Y, RECT_WIDTH, DIAMETER);
    circle(X, Y+SIZE_UNIT, DIAMETER);
    circle(X+RECT_WIDTH, Y+SIZE_UNIT, DIAMETER);
    displayText(stateText, stateTextX, STATE_TEXT_Y, STATE_TEXT_SIZE, BLACK);
  }
  
  private void displayNob() {
    strokeWeight(3);
    fill(WHITE);
    circle(nobX, Y+SIZE_UNIT, DIAMETER);
  }
  
  private void toggleState() {
    JSONObject json = faciSettingJSON.getJSON();
    boolean newState = !json.getBoolean(JSON_KEY);
    json.setBoolean(JSON_KEY, newState);
    updateStateVariable(newState);
  }
  
  private void updateStateVariable(boolean state) {
    stateText = state ? ON : OFF;
    sliderColor = state ? COLOR_ON : COLOR_OFF;
    stateTextX = state ? STATE_TEXT_X_ON : STATE_TEXT_X_OFF;
    nobX = state ? NOB_X_ON : NOB_X_OFF;

  }

  private boolean isTouched() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (rectTouchJudge(X-SIZE_UNIT, Y, SIZE_UNIT*2+RECT_WIDTH, DIAMETER, touch.x, touch.y)) {
        if (!hasTouched) {
          hasTouched = true;
          return true;
        } 
      }
    }
    return false;
  }

  private void resetHasTouched() {
    if (hasTouched && touches.length==0) {
      hasTouched = false;
    }
  }
}
