class NoteJudge {
  private Note note;
  private boolean hasTouched;
  

  public NoteJudge(Note note) {
    this.note = note;
    hasTouched = false;
  }

  private processing.event.TouchEvent.Pointer getTouchedPointer() {
    for (processing.event.TouchEvent.Pointer touch : touches) {
      if (dist(touch.x, touch.y, note.getCoordinate().x, note.getCoordinate().y) <= note.getRadius()) {
        return touch;
      }
    }
    return null;
  }

  private Judgments judgeTouch() {
    if (!hasTouched && getTouchedPointer()!=null) {
      hasTouched = true;
      if (note.getActive()) {
        return Judgments.Good;
      } else {
        return Judgments.Bad;
      }
    } else {
      return null;
    }
  }

  private void unsetTouch() {
    
  }
}
