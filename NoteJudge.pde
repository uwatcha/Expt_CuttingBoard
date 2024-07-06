//曲が始まってからの指定された時間にタッチしたかどうかを判定する
//Good：+-4f以内
//Nice: +-5~8f
//Bad:  +-8~12f
//
class NoteJudge {
  final int JUST_FRAME;
  final int RESET_DELAY_FRAME = (int)frameRate/2;
  private Note note;
  private int touchedFrame;
  private boolean hasTouched;

  public NoteJudge(Note note, int justFrame) {
    this.note = note;
    hasTouched = false;
    JUST_FRAME = justFrame;
  }

  public Judgment run() {
    Judgment judge = judgeTouchTiming();
    if (judge!=null) { println(judge); }
    return judgeTouchTiming();
  }
  //private Judgment judge() {
  //}
  private boolean isWithinRange(int frame, int lowerBoundFrame, int upperBoundFrame) {
    int judgedRange = abs(frame-JUST_FRAME);
    return (lowerBoundFrame <= judgedRange&&judgedRange <= upperBoundFrame);
  }
  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (dist(touch.x, touch.y, note.getCoordinate().x, note.getCoordinate().y) <= note.getRadius()) {
        if (!hasTouched) {
          hasTouched = true;
          touchedFrame = roopingFrameCount;
          return touch;
        } else {
          return null;
        }
      }
    }
    return null;
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
}
