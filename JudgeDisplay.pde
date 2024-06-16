class JudgeDisplay {
  final String GOOD_TEXT = "GOOD!!";
  final String NICE_TEXT = "NICE!";
  final String BAD_TEXT = "BAD...";
  final float TEXT_DISPLAY_DURATION = 60;
  PVector coordinate;
  int textStartTime;

  JudgeDisplay() {
    coordinate = new PVector(width*3/4, height/4);
    textStartTime = -1;
  }

  public void display(Note note) {
    println("--------");
    println(note.judgeTouch());
    println(setMode(note.judgeTouch()));
    println(textStartTime);
    println(TEXT_DISPLAY_DURATION);
    println("--------");
    displayText(setMode(note.judgeTouch()));
  }

  //TEXT_DISPLAY_TIMEのフレームが経過したらmodeフラグをfalseにする関数を作る
  //modeフラグを受けてテキストを表示する関数を作る

  private Judgments setMode(Judgments judgments) {
    if (judgments != null && textStartTime == -1) {
      textStartTime = millis();
      return judgments;
    } else if (millis() - textStartTime <= TEXT_DISPLAY_DURATION) {
      return judgments;
    } else {
      return null;
    }
  }

  private void displayText(Judgments judgments) {
    if (judgments==null) {
      
      return;
    }
    switch (judgments) {
    case Good:
      fill(255);
      text(GOOD_TEXT, coordinate.x, coordinate.y);
      break;
    case Nice:
      fill(255);
      text(NICE_TEXT, coordinate.x, coordinate.y);
      break;
    case Bad:
      fill(255);
      text(BAD_TEXT, coordinate.x, coordinate.y);
      break;
    }
  }
}
