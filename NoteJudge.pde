class NoteJudge {
  final private int JUST_FRAME;
  private Note note;
  private int touchedFrame;
  private boolean hasTouched;

  public NoteJudge(Note note, int justFrame) {
    this.note = note;
    hasTouched = false;
    JUST_FRAME = justFrame;
  }

  public Judgment run() {
    //コンソールに判定を表示する時は以下をアンコメント
    //Judgment judge = judgeTouchTiming();
    //if (judge!=null) { println(judge); }
    if (note!=null) {
      return judgeTouchTiming();
    } else {
      println("null");
      return null;
    }
  }
  
  public void killField() {
    note = null;
  }
  
  private Judgment judgeTouchTiming() {
    if (getTouchedPointer() != null) {
           if (isWithinRange(touchedFrame,          0, GOOD_FRAME))         { return Judgment.Good; } 
      else if (isWithinRange(touchedFrame, GOOD_FRAME, NICE_FRAME))         { return Judgment.Nice; }
      else if (isWithinRange(touchedFrame, NICE_FRAME, Integer.MAX_VALUE))  { return Judgment.Bad;  } 
      else                                                                  { return null; }
    } else {
      return null;
    }
  }
  
  private boolean isWithinRange(int frame, int lowerBoundFrame, int upperBoundFrame) {
    int judgedRange = abs(frame-JUST_FRAME);
    return (lowerBoundFrame <= judgedRange&&judgedRange <= upperBoundFrame);
  }
  
  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (dist(touch.x, touch.y, note.getCoordinate().x, note.getCoordinate().y) <= note.getRadius()) {
        if (!hasTouched) {
          hasTouched = true;
          touchedFrame = frame;
          return touch;
        } else {
          return null;
        }
      }
    }
    return null;
  }
}
