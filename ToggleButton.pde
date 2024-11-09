class ToggleButton {
  //unit-----------------------------------------------------------------
  private static final int SIZE_UNIT = 100;
  private static final int DIAMETER = SIZE_UNIT*2;
  //x, y-----------------------------------------------------------------
  //X:
  //Y:
  //TODO: 確かめる
  private final int X, Y;
  //title----------------------------------------------------------------
  private final String TITLE;
  private static final int TITLE_SIZE = 60;
  private final int TITLE_X, TITLE_Y;
  private final int TEXT_OFFSET_X;
  private static final int TEXT_OFFSET_Y = -70;
  //slider---------------------------------------------------------------
  private static final int RECT_WIDTH = SIZE_UNIT*2;
  //nob------------------------------------------------------------------
  private final int NOB_X_ON;
  private final int NOB_X_OFF;
  //state----------------------------------------------------------------
  private static final String ON = "ON";
  private static final String OFF = "OFF";
  private static final int STATE_TEXT_SIZE = 80;
  private final int STATE_TEXT_X_ON;
  private final int STATE_TEXT_X_OFF;
  private final int STATE_TEXT_Y;
  private final color COLOR_ON = colors.LIGHT_BLUE;
  private final color COLOR_OFF = colors.LIGHT_GREY;
  //JSON-----------------------------------------------------------------
  private final String JSON_KEY;
  
  private String stateText;
  private int stateTextX;
  private color sliderColor;
  private int nobX;
  
  ToggleButton(int x, int y, String jsonKey) {
    X = x-SIZE_UNIT;
    Y = y-SIZE_UNIT;
    TEXT_OFFSET_X = SIZE_UNIT;
    
    TITLE_X = X+TEXT_OFFSET_X;
    TITLE_Y = Y+TEXT_OFFSET_Y;
    
    STATE_TEXT_X_ON = X;
    STATE_TEXT_X_OFF = X+SIZE_UNIT*2;
    STATE_TEXT_Y = Y+SIZE_UNIT;
    
    NOB_X_ON = X+SIZE_UNIT*2;
    NOB_X_OFF = X;
    JSON_KEY = jsonKey;
    
    TITLE = UI_TITLES.get(JSON_KEY);
    
    updateStateVariable(faciSettings.myGetBoolean(JSON_KEY));
  }
  
  public void run() {
    displayText(TITLE, TITLE_X, TITLE_Y, TITLE_SIZE);
    displayButton();
    if (isTouched()) {
      toggleState();
    }
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
    displayText(stateText, stateTextX, STATE_TEXT_Y, STATE_TEXT_SIZE);
  }
  
  private void displayNob() {
    strokeWeight(3);
    fill(colors.WHITE);
    circle(nobX, Y+SIZE_UNIT, DIAMETER);
  }
  
  private void toggleState() {
    boolean newState = !faciSettings.myGetBoolean(JSON_KEY);
    faciSettings.mySetBoolean(JSON_KEY, newState);
    updateStateVariable(newState);
  }
  
  private void updateStateVariable(boolean state) {
    stateText = state ? ON : OFF;
    sliderColor = state ? COLOR_ON : COLOR_OFF;
    stateTextX = state ? STATE_TEXT_X_ON : STATE_TEXT_X_OFF;
    nobX = state ? NOB_X_ON : NOB_X_OFF;

  }

  private boolean isTouched() {
    if (action==Action.Down) {
      if (rectTouchJudge(X-SIZE_UNIT, Y, SIZE_UNIT*2+RECT_WIDTH, DIAMETER, actionPosition[0], actionPosition[1])) {
        return true;
      }
    }
    return false;
  }
}
