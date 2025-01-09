class JudgeField {
  private static final int TOP_LEFT_X = 0;
  private final int TOP_LEFT_Y = height/2;
  private final int WIDTH = width;
  private final int HEIGHT = height/2;
  //TODO: targetMillisに改名する
  private int justMillis;
  private Judgment judgment;
  private int timingDiff;
  private HashMap<Field, Object> CSVFieldValues;

  public JudgeField() {
    justMillis = INT_RESET_VALUE;
    judgment = Judgment.None;
    timingDiff = INT_RESET_VALUE;
    CSVFieldValues = new HashMap<Field, Object>();
  }

  public void run() {
    calcJustMillis();
    judgeTouchedTiming();
    if (isTouched()) {
      CSVFieldValues.put(Field.Action, action);
      CSVFieldValues.put(Field.ActualTiming, timeManager.getPlayingMillis());
      CSVFieldValues.put(Field.TargetTiming, justMillis);
      CSVFieldValues.put(Field.TouchPositionX, actionPosition[0]);
      CSVFieldValues.put(Field.TouchPositionY, actionPosition[1]);
      if (action == Action.Down) {
        CSVFieldValues.put(Field.TimingDiff, timingDiff);
        CSVFieldValues.put(Field.Judgment, judgment);
      } else if (action == Action.Up) {
        CSVFieldValues.put(Field.TimingDiff, INT_RESET_VALUE);
        CSVFieldValues.put(Field.Judgment, Judgment.None);
      }
    } else {
      CSVFieldValues = new HashMap<Field, Object>();
    }
    display();
  }

  public void display() {
    displayRect(TOP_LEFT_X, TOP_LEFT_Y, WIDTH, HEIGHT, 0, colors.CLEAR_GREY);
  }

  public boolean hasFieldValues() {
    return judgment != Judgment.None;
  }

  public int getJustMillis() {
    return justMillis;
  }

  public HashMap<Field, Object> getGeneralCSVFieldValues() {
    return CSVFieldValues;
  }

  public HashMap<Field, Object> getTouchCSVFieldValues(Field[] touchCSVFields) {
    HashMap<Field, Object> filteredFields = new HashMap<Field, Object>();
    for (Map.Entry<Field, Object> entry : CSVFieldValues.entrySet()) {
      if (Arrays.asList(touchCSVFields).contains(entry.getKey())) {
        filteredFields.put(entry.getKey(), entry.getValue());
      }
    }
    return filteredFields;
  }

  public HashMap<Field, Object> getActionCSVFieldValues(Field[] actionCSVFields) {
    HashMap<Field, Object> filteredFields = new HashMap<Field, Object>();
    for (Map.Entry<Field, Object> entry : CSVFieldValues.entrySet()) {
      if (Arrays.asList(actionCSVFields).contains(entry.getKey())) {
        filteredFields.put(entry.getKey(), entry.getValue());
      }
    }
    return filteredFields;
  }

  private void judgeTouchedTiming() {
    if (isTouched()) {
      if (isNowWithinRange(0, GOOD_MILLIS)) {
        judgment = Judgment.Good;
      } else if (isNowWithinRange(GOOD_MILLIS, NICE_MILLIS)) {
        judgment = Judgment.Nice;
      } else if (isNowWithinRange(NICE_MILLIS, Integer.MAX_VALUE)) {
        judgment = Judgment.Bad;
      } else {
        judgment = Judgment.None;
      }
    } else {
      judgment = Judgment.None;
    }
  }

  private void calcJustMillis() {
    int loopCount = timeManager.getPlayingMillis()/timeManager.getTouchIntervalMillis();
    int loopRemainder = timeManager.getPlayingMillis()%timeManager.getTouchIntervalMillis();
    if (loopRemainder >= timeManager.getTouchIntervalMillis()/2) {
      loopCount++;
    }
    justMillis = loopCount*timeManager.getTouchIntervalMillis();
  }

  private boolean isNowWithinRange(int lowerBoundMillis, int upperBoundMillis) {
    timingDiff = timeManager.getPlayingMillis()-justMillis;
    return (lowerBoundMillis <= abs(timingDiff)&&abs(timingDiff) <= upperBoundMillis);
  }

  private boolean isTouched() {
    if (action==Action.Down || action==Action.Up) {
      if (isTouchInField()) {
        return true;
      }
    }
    return false;
  }

  public boolean isTouchInField() {
    return rectTouchJudge(TOP_LEFT_X, TOP_LEFT_Y, TOP_LEFT_X+WIDTH, TOP_LEFT_Y+HEIGHT, actionPosition[0], actionPosition[1]);
  }
}
