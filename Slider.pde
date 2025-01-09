class Slider {
  //unit-----------------------------------------------------------------
  private static final int SIZE_UNIT = 20;
  //x, y-----------------------------------------------------------------
  //X: トラックの左端（丸みは含まない）
  //Y: トラックの上端
  private final int X, Y;
  private final int CENTER_X, CENTER_Y;
  //title----------------------------------------------------------------
  private final String TITLE;
  private static final int TITLE_SIZE = 60;
  private final int TITLE_Y;
  //track----------------------------------------------------------------
  private final int TRACK_WIDTH;
  private final static int TRACK_HEIGHT = SIZE_UNIT*2;
  private final color TRACK_COLOR = colors.WHITE;
  //thumb----------------------------------------------------------------
  private final int THUMB_Y;
  private static final int THUMB_DIAMETER = SIZE_UNIT*4;
  private final color THUMB_COLOR = colors.WHITE;
  //valueText------------------------------------------------------------
  private static final int VALUE_TEXT_SIZE = SIZE_UNIT*2;
  private final int VALUE_TEXT_Y;
  //tick-----------------------------------------------------------------
  private static final int TICK_STROKE = 1;
  private static final int TICK_SCALE_VALUE = 10;
  private final float TICK_SCALE_LENGTH;
  private static final int TICK_HEIGHT = SIZE_UNIT*4;
  private final int TICK_Y_START, TICK_Y_END;
  //value, track: min_max------------------------------------------------
  private final int VALUE_MIN, VALUE_MAX;
  private final int TRACK_LOWER_LIMIT_VALUE, TRACK_UPPER_LIMIT_VALUE;
  private final float VALUE_MIN_POSITION, VALUE_MAX_POSITION;
  //JSON-----------------------------------------------------------------
  private final String JSON_KEY;

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

    setValueFromJson();
    isGrabing = false;
  }

  public void run () {
    displayText(TITLE, CENTER_X, TITLE_Y, TITLE_SIZE);
    setIsGrabing();
    if (isGrabing) {
      setValueFromPosition();
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
      displayLine(getTickPositionX(i), TICK_Y_START, getTickPositionX(i), TICK_Y_END, TICK_STROKE);
    }
  }
  private float getTickPositionX(int index) {
    return X+TICK_SCALE_LENGTH*index;
  }

  private void setIsGrabing() {
    if (action == Action.Down) {
      if (rectTouchJudge(X-SIZE_UNIT*3, Y-SIZE_UNIT*2, TRACK_WIDTH+SIZE_UNIT*3, TRACK_HEIGHT+SIZE_UNIT*2, actionPosition[0], actionPosition[1])) {
        isGrabing = true;
      }
    } else if (action == Action.Up) {
      isGrabing = false;
      setValueToJSON();
    }
  }

  private void setValueToJSON() {
    faciSettings.mySetInt(JSON_KEY, value);
  }

  private void setValueFromJson() {
    this.value = faciSettings.myGetInt(JSON_KEY);
    thumbX = getMappedThumbX(value);
    valueText = str(value);
  }

  private void setValueFromPosition() {
    float thumbXCand;
    if (actionPosition[0] <= VALUE_MIN_POSITION) {
      thumbXCand = VALUE_MIN_POSITION;
    } else if (VALUE_MAX_POSITION <= actionPosition[0]) {
      thumbXCand = VALUE_MAX_POSITION;
    } else {
      thumbXCand = actionPosition[0];
    }
    float valueCand = (int)map(thumbXCand-X, 0, TRACK_WIDTH, TRACK_LOWER_LIMIT_VALUE, TRACK_UPPER_LIMIT_VALUE);
    value = round(valueCand / 10) * 10;
    thumbX = getMappedThumbX(value);
    valueText = str(value);
  }
  
  private float getMappedThumbX(int value) {
    return map(value, TRACK_LOWER_LIMIT_VALUE, TRACK_UPPER_LIMIT_VALUE, X, X+TRACK_WIDTH);
  }
}
