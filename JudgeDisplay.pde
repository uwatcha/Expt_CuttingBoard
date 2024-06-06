class JudgeDisplay {
  final String GOOD_TEXT = "GOOD!!";
  final String NICE_TEXT = "NICE!";
  final String BAD_TEXT = "BAD...";
  final float TEXT_DISPLAY_TIME = frameRate;
  PVector coordinate;
  boolean goodMode, niceMode, badMode;
  
  JudgeDisplay() {
    this.coordinate = new PVector(width*3/4, height/4);
    this.goodMode = this.niceMode = this.badMode = false;
  }
  
  public void display(Note note) {
    this.setMode(note.judgeTouch());
    
  }
  
 //TEXT_DISPLAY_TIMEのフレームが経過したらmodeフラグをfalseにする関数を作る
 //modeフラグを受けてテキストを表示する関数を作る
  
  private void setMode(Judgments judgments) {
    switch (judgments) {
    case Good:
        goodMode = true;
        niceMode = badMode = false;
        break;
    case Nice:
        niceMode = true;
        goodMode = badMode = false;
        break;
    case Bad:
        badMode = true;
        goodMode = niceMode = false;
        break;
    default:
        goodMode = niceMode = badMode = false;
        break;
}
  }
}
