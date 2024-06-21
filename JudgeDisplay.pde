class JudgeDisplay {
  final String GOOD_TEXT = "GOOD!!";
  final String NICE_TEXT = "NICE!";
  final String BAD_TEXT = "BAD...";
  final int DISPLAY_DURATION_MS = 1000;
  final float OFFSET = 200;
  PVector coordinate;
  int textStartTime;
  Note note;
  Judgments displayJudgment;

  JudgeDisplay(Note note) {
    this.note = note;
    coordinate = new PVector(note.getCoordinate().x + OFFSET, note.getCoordinate().y - OFFSET);
    textStartTime = -1;
  }

  public void run() {
    setJudgment(note.judgeTouch());
    displayText();
  }

  private void setJudgment(Judgments judgments) {
    if (judgments!=null) {
      textStartTime = millis();
      displayJudgment = judgments;
    } else if (textStartTime!=-1 && millis() - textStartTime > DISPLAY_DURATION_MS) {
      textStartTime = -1;
      displayJudgment = null;
    }
  }

  private void displayText() {
    if (displayJudgment==null) { return; }
    
    switch (displayJudgment) {
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
    textDisplay(text, coordinate.x, coordinate.y, JUDGE_DISPLAY, WHITE);
  }
}
