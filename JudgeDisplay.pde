class JudgeDisplay {
  final String GOOD_TEXT = "GOOD!!";
  final String NICE_TEXT = "NICE!";
  final String BAD_TEXT = "BAD...";
  final int TEXT_DISPLAY_DURATION_MS = 1000;
  PVector coordinate;
  int textStartTime;
  Judgments displayJudgment;

  JudgeDisplay() {
    coordinate = new PVector(width*3/4, height/4);
    textStartTime = -1;
  }

  public void run(Note note) {
    setJudgment(note.judgeTouch());
    displayText();
  }

  //TEXT_DISPLAY_TIMEのフレームが経過したらmodeフラグをfalseにする関数を作る
  //modeフラグを受けてテキストを表示する関数を作る

  private void setJudgment(Judgments judgments) {
    if (judgments!=null) {
      textStartTime = millis();
      displayJudgment = judgments;
    } else if (textStartTime!=-1 && millis() - textStartTime > TEXT_DISPLAY_DURATION_MS) {
      textStartTime = -1;
      displayJudgment = null;
    }
  }

  private void displayText() {
    if (displayJudgment==null) {
      
      return;
    }
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
