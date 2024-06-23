//曲が始まってからの指定された時間にタッチしたかどうかを判定する
//Good：+-4f以内
//Nice: +-5~8f
//Bad:  +-8~12f
class NoteJudge {
  final int JUST_FRAME;
  private Note note;
  private int touchedFrame;
  private boolean hasTouched;

  public NoteJudge(Note note, int justFrame) {
    this.note = note;
    hasTouched = false;
    JUST_FRAME = justFrame;
  }

  public Judgments run() {
    if (!hasTouched && getTouchedPointer()!=null) {
      int margin = touchedFrame-JUST_FRAME;
      if (abs(margin) <= GOOD_FRAME) {
        return Judgments.Good;
      } else if (GOOD_FRAME < abs(margin)&&abs(margin) <= NICE_FRAME) {
        return Judgments.Nice;
      } else if (NICE_FRAME < abs(margin)&&abs(margin) <= BAD_FRAME) {
        return Judgments.Bad;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (dist(touch.x, touch.y, note.getCoordinate().x, note.getCoordinate().y) <= note.getRadius()) {
        if (!hasTouched) {
          touchedFrame = roopingFrameCount;
        }
        hasTouched = true;
        return touch;
      }
    }
    return null;
  }
}
