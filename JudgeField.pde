class JudgeField {
  private static final int TOP_LEFT_X = 0;
  private final int TOP_LEFT_Y = height/2;
  private final int WIDTH = width;
  private final int HEIGHT = height/2;
  //TODO: targetMillisに改名する
  private int justMillis;
  private Judgment judgment;
  private int timingDiff;
  private HashMap<Field, Object> CSVFields;

  public JudgeField() {
    justMillis = FIELD_RESET_VALUE;
    judgment = Judgment.None;
    timingDiff = FIELD_RESET_VALUE;
    CSVFields = new HashMap<Field, Object>();
  }

  public void run() {
    calcJustMillis();
    judgeActualTiming();
    if (judgment != Judgment.None) {
      CSVFields.put(Field.Action, action);
      CSVFields.put(Field.ActualTiming, playingMillis());
      CSVFields.put(Field.TargetTiming, justMillis);
      CSVFields.put(Field.TimingDiff, timingDiff);
      CSVFields.put(Field.Judgment, judgment);
      CSVFields.put(Field.TouchPositionX, actionPosition[0]);
      CSVFields.put(Field.TouchPositionY, actionPosition[1]);
    } else {
      CSVFields = new HashMap<Field, Object>();
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

  public HashMap<Field, Object> getGeneralCSVFields() {
    return CSVFields;
  }

  public HashMap<Field, Object> getTouchCSVFields() {
    HashMap<Field, Object> filteredFields = new HashMap<Field, Object>();
    for (Map.Entry<Field, Object> entry : CSVFields.entrySet()) {
      if (Arrays.asList(touchCSV.getFields()).contains(entry.getKey())) {
        filteredFields.put(entry.getKey(), entry.getValue());
      }
    }
    return filteredFields;
  }

  public HashMap<Field, Object> getActionCSVFields() {
    HashMap<Field, Object> filteredFields = new HashMap<Field, Object>();
    for (Map.Entry<Field, Object> entry : CSVFields.entrySet()) {
      if (Arrays.asList(actionCSV.getFields()).contains(entry.getKey())) {
        filteredFields.put(entry.getKey(), entry.getValue());
      }
    }
    return filteredFields;
  }

  private void judgeActualTiming() {
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
    int loopCount = playingMillis()/touchIntervalMillis;
    int loopRemainder = playingMillis()%touchIntervalMillis;
    if (loopRemainder >= touchIntervalMillis/2) {
      loopCount++;
    }
    justMillis = loopCount*touchIntervalMillis;
  }

  private boolean isNowWithinRange(int lowerBoundMillis, int upperBoundMillis) {
    timingDiff = playingMillis()-justMillis;
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
