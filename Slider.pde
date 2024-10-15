class Slider {
  //X: トラックの左端（丸みは含まない）
  //Y: トラックの上端
  final private int X, Y;
  final private int CENTER_X, CENTER_Y;
  final private int SIZE_UNIT = 20;

  final private String JSON_KEY;

  final private String TITLE;
  final private int TITLE_SIZE = 60;
  final private int TITLE_Y;

  final private int TRACK_WIDTH;
  final private int TRACK_HEIGHT = SIZE_UNIT*2;
  final private color TRACK_COLOR = WHITE;

  final private int THUMB_Y;
  final private int THUMB_DIAMETER = SIZE_UNIT*4;
  final private color THUMB_COLOR = WHITE;

  final private int VALUE_TEXT_SIZE = SIZE_UNIT*2;
  final private int VALUE_TEXT_Y;

  final private int TICK_STROKE = 1;
  final private int TICK_SCALE_VALUE = 10;
  final private float TICK_SCALE_LENGTH;
  final private int TICK_HEIGHT = SIZE_UNIT*4;
  final private int TICK_Y_START, TICK_Y_END;

  final private int VALUE_MIN, VALUE_MAX;
  final private int TRACK_LOWER_LIMIT_VALUE, TRACK_UPPER_LIMIT_VALUE;
  final private float VALUE_MIN_POSITION, VALUE_MAX_POSITION;

  private float thumbX;

  private String valueText;

  private int value;

  private boolean isGrabing;

  Slider(int x, int y, int w, int min, int max, String jsonKey) {
    X = x-w/2-SIZE_UNIT;
    Y = y-SIZE_UNIT;
    CENTER_X = x;
    CENTER_Y = y;
    
    JSON_KEY = jsonKey;

    TITLE = UI_TITLES.get(JSON_KEY);
    TITLE_Y = Y-SIZE_UNIT*5;

    TRACK_WIDTH = w;

    THUMB_Y = CENTER_Y;
    
    VALUE_TEXT_Y = Y-SIZE_UNIT*2;

    VALUE_MIN = min>0 ? min : 1;
    VALUE_MAX = max;
    TRACK_LOWER_LIMIT_VALUE = VALUE_MIN - VALUE_MIN%TICK_SCALE_VALUE;
    TRACK_UPPER_LIMIT_VALUE = VALUE_MAX;
    VALUE_MIN_POSITION = map(VALUE_MIN, TRACK_LOWER_LIMIT_VALUE, VALUE_MAX, X, X+TRACK_WIDTH);
    VALUE_MAX_POSITION = X+TRACK_WIDTH;

    TICK_SCALE_LENGTH = TICK_SCALE_VALUE * ((float)(TRACK_WIDTH)/(float)(TRACK_UPPER_LIMIT_VALUE-TRACK_LOWER_LIMIT_VALUE));
    TICK_Y_START = CENTER_Y+(int)(SIZE_UNIT*2.5);
    TICK_Y_END = CENTER_Y+TICK_HEIGHT;

    setValueToThumbX(faciSettings.myGetInt(JSON_KEY));
    isGrabing = false;
  }

  public void run () {
    displayText(TITLE, CENTER_X, TITLE_Y, TITLE_SIZE);
    setIsGrabing();
    if (isGrabing) {
      setThumbXToValue();
    }
    displayTrack();
    displayThumb();
  }

  private void displayTrack() {
    noStroke();
    fill(TRACK_COLOR);
    rect(X, Y, TRACK_WIDTH, TRACK_HEIGHT);
    circle(X, Y+SIZE_UNIT, TRACK_HEIGHT);
    circle(X+TRACK_WIDTH, Y+SIZE_UNIT, TRACK_HEIGHT);
    displayText(valueText, CENTER_X, VALUE_TEXT_Y, VALUE_TEXT_SIZE);
    displayTicks();
  }

  private void displayThumb() {
    noStroke();
    fill(THUMB_COLOR);
    circle(thumbX, THUMB_Y, THUMB_DIAMETER);
  }

  private void displayTicks() {
    for (int i=0; getTickPositionX(i)<=X+TRACK_WIDTH; i++) {
      displayLine(getTickPositionX(i), TICK_Y_START, getTickPositionX(i), TICK_Y_END, TICK_STROKE, BLACK);
    }
  }
  private float getTickPositionX(int i) { return X+TICK_SCALE_LENGTH*i; }
  
  private void setIsGrabing() {
    if (actionID == MotionEvent.ACTION_DOWN) {
      if (rectTouchJudge(X-SIZE_UNIT*3, Y-SIZE_UNIT*2, TRACK_WIDTH+SIZE_UNIT*3, TRACK_HEIGHT+SIZE_UNIT*2, actionPosition[0], actionPosition[1])) {
        isGrabing = true;
      }
    } else if (actionID == MotionEvent.ACTION_UP) {
      isGrabing = false;
      setValueToJSON();
    }
  }
  
  private void setValueToJSON() {
    faciSettings.mySetInt(JSON_KEY, value);
  }

  private void setValueToThumbX(int value) {
    this.value = value;
    thumbX = map(value, TRACK_LOWER_LIMIT_VALUE, TRACK_UPPER_LIMIT_VALUE, X, X+TRACK_WIDTH);
    valueText = str(value);
  }
  
  private void setThumbXToValue() {
    if (actionPosition[0] <= VALUE_MIN_POSITION) {
      thumbX = VALUE_MIN_POSITION;
    } else if (VALUE_MAX_POSITION <= actionPosition[0]) {
      thumbX = VALUE_MAX_POSITION;
    } else {
      thumbX = actionPosition[0];
    }
    value = (int)map(thumbX-X, 0, TRACK_WIDTH, TRACK_LOWER_LIMIT_VALUE, TRACK_UPPER_LIMIT_VALUE);
    valueText = str(value);
  }
}
