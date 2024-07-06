//曲が始まってからの指定された時間にタッチしたかどうかを判定する
//Good：+-4f以内
//Nice: +-5~8f
//Bad:  +-8~12f
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
    getTouchedPointer();
      return null;
  }
  //private Judgment judge() {
  //}
  private boolean isWithinRange(int value, int lowerBound, int upperBound) {
    return (lowerBound <= abs(value)&&abs(value) <= upperBound);
  }
  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (dist(touch.x, touch.y, note.getCoordinate().x, note.getCoordinate().y) <= note.getRadius()) {
        if (!hasTouched) {
          hasTouched = true;
          touchedFrame = roopingFrameCount;
          println("Touched");
          return touch;
        } else {
          return null;
        }
      }
    }
    return null;
  }
  //private Judgment judgeTouchTiming() {

  //}
}
