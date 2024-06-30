class JudgeDisplay {
  final String GOOD_TEXT = "GOOD!!";
  final String NICE_TEXT = "NICE!";
  final String BAD_TEXT = "BAD...";
  final int DISPLAY_DURATION_MS = 1000;
  final float OFFSET = 200;
  PVector coordinate;
  int startFrame;
  Note note;
  Judgment judgment;

  JudgeDisplay(Note note) {
    this.note = note;
    coordinate = new PVector(note.getCoordinate().x + OFFSET, note.getCoordinate().y - OFFSET);
    startFrame = -1;
  }

  public void run(Judgment judgment) {
    setJudgment(judgment);
    displayText();
  }

  private void setJudgment(Judgment judgment) {
    if (judgment!=null) {
      startFrame = millis();
      this.judgment = judgment;
    } else if (startFrame!=-1 && millis() - startFrame > DISPLAY_DURATION_MS) {
      startFrame = -1;
      judgment = null;
    }
  }

  private void displayText() {
    if (judgment==null) { return; }
    
    switch (judgment) {
    case Good:
      judgmentText(GOOD_TEXT);
      break;
    case Nice:
      judgmentText(NICE_TEXT);
      break;
    case Bad:
      judgmentText(BAD_TEXT);
      break;
    }
  }
  
  private void judgmentText(String text) {
    textDisplay(text, coordinate, JUDGE_DISPLAY, WHITE);
  }
}
