class JudgeField {
  final int TOP_LEFT_X = 0;
  final int TOP_LEFT_Y = height/2;
  final int WIDTH = width;
  final int HEIGHT = height/2;
  private boolean hasTouched;

  public JudgeField() {
    hasTouched = false;
  }

  public Judgment run() {
    displayRect(new PVector(TOP_LEFT_X, TOP_LEFT_Y), WIDTH, HEIGHT, 0, CLEAR_GREY);
    resetHasTouched();
    return judgeTouchTiming();
  }
  
  private Judgment judgeTouchTiming() {
    if (getTouchedPointer() != null) {
           if (isNowWithinPeriod(         0, GOOD_FRAME))         { return Judgment.Good; } 
      else if (isNowWithinPeriod(GOOD_FRAME, NICE_FRAME))         { return Judgment.Nice; }
      else if (isNowWithinPeriod(NICE_FRAME, Integer.MAX_VALUE))  { return Judgment.Bad;  } 
      else                                                        { return null; }
    } else {
      return null;
    }
  }
  
  private boolean isNowWithinPeriod(int lowerBoundFrame, int upperBoundFrame) {
    int judgedPeriod = abs(TOUCH_INTERVAL-loopFrame);
    return (lowerBoundFrame <= judgedPeriod&&judgedPeriod <= upperBoundFrame);
  }
  
  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if ((TOP_LEFT_X <= touch.x&&touch.x <= WIDTH) && (TOP_LEFT_Y <= touch.y&&touch.y <= HEIGHT)) {
        if (!hasTouched) {
          hasTouched = true;
          return touch;
        } else {
          return null;
        }
      }
    }
    return null;
  }
  
  private void resetHasTouched() {
    if (hasTouched && touches.length==0) {
      hasTouched = false;
    }
  }
}
