class Slider {
  final private int X, Y;
  final private int SIZE_UNIT = 30;

  final private String JSON_KEY;

  final private String TITLE;
  final private int TITLE_SIZE = 60;
  final private int TITLE_OFFSET_X, TITLE_OFFSET_Y;

  final private int TRACK_WIDTH;
  final private int TRACK_HEIGHT = SIZE_UNIT*2;
  final private color TRACK_COLOR = WHITE;

  final private int THUMB_Y;
  final private int THUMB_DIAMETER = SIZE_UNIT*4;
  final private color THUMB_COLOR = WHITE;

  final private int VALUE_TEXT_SIZE = SIZE_UNIT*4/3;
  final private int VALUE_TEXT_OFFSET_Y = SIZE_UNIT*-2;

  final private int TICK_STROKE = 1;
  final private int TICK_SCALE_VALUE = 10;
  final private int TICK_SCALE_LENGTH;

  final private int VALUE_MIN, VALUE_MAX;

  private int thumbX;

  private String valueText;

  private int value;

  private boolean isGrabing;

  Slider(int x, int y, int w, int min, int max, String jsonKey) {
    X = x-SIZE_UNIT;
    Y = y-SIZE_UNIT;

    JSON_KEY = jsonKey;

    TITLE = UI_TITLES.get(JSON_KEY);
    TITLE_OFFSET_X = SIZE_UNIT;
    TITLE_OFFSET_Y = -70;

    TRACK_WIDTH = w;

    THUMB_Y = Y;

    VALUE_MIN = min;
    VALUE_MAX = max;

    TICK_SCALE_LENGTH = (int)map(TICK_SCALE_VALUE, VALUE_MIN, VALUE_MAX, 0, TRACK_WIDTH);

    setValueToThumbX(faciSettings.myGetInt(JSON_KEY));
    isGrabing = false;
  }

  public void run () {
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
    displayTicks();
  }

  private void displayThumb() {
    noStroke();
    fill(TRACK_COLOR);
    circle(X+thumbX, Y+TRACK_HEIGHT/2, THUMB_DIAMETER);
  }

  private void displayTicks() {
    for (int i=0; i<(VALUE_MAX-VALUE_MIN)/TICK_SCALE_VALUE; i++) {
      displayLine((int)X+TICK_SCALE_LENGTH*i, (int)(Y-SIZE_UNIT*0.2), (int)(X+TICK_SCALE_LENGTH*i), (int)(Y+TRACK_HEIGHT+SIZE_UNIT*0.2));
    }
  }

  private void setIsGrabing() {
    if (actionID == MotionEvent.ACTION_DOWN) {
      if (rectTouchJudge(X, Y, TRACK_WIDTH, TRACK_HEIGHT, actionPosition[0], actionPosition[1])) {
        isGrabing = true;
      }
    } else if (actionID == MotionEvent.ACTION_UP) {
      isGrabing = false;
    }
  }

  private void setValueToThumbX(int value) {
    this.value = value;
    thumbX = (int)map(value, VALUE_MIN, VALUE_MAX, 0, TRACK_WIDTH);
    valueText = str(value);
  }
  
  private void setThumbXToValue() {
    thumbX = (int)actionPosition[0];
    value = (int)map(thumbX, 0, TRACK_WIDTH, VALUE_MIN, VALUE_MAX);
    valueText = str(value);
  }
}
