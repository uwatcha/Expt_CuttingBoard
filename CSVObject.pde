//LinkedList: テーブルそのもの
//HashMap:    レコード

class CSVObject {
  private LinkedList<HashMap<Field, String>> table;

  CSVObject() {
    table = new LinkedList<HashMap<Field, String>>();
  }

  public void createRecord(Judgment judgment) {
    if (judgment!=null) {
      addRecord();
      writeTouchTiming();
      writeCorrectTiming();
      writeTimingDiff();
      writeJudgment(judgment);
      writeTouchPosition();
    }
    //println(table);
    Field[] f = {Field.TouchTiming, Field.CorrectTiming, Field.TimingDiff, Field.Judgment, Field.TouchPositionX, Field.TouchPositionY};
    ListToString(f);///////
  }
  
  public boolean saveCSV() {
    try {
      
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  private String ListToString(Field[] outputField) {
    String rtn = "";
    rtn += "Feedback: "+ (faciSettings.myGetBoolean(isActiveFeedback) ? "Active" : "Inactive") + ", ";
    rtn += "Gauge: "+ (faciSettings.myGetBoolean(isActiveGauge) ? "Active" : "Inactive") + "\n";
    rtn += "TouchTiming, CorrectTiming, TimingDiff, Judgment, TouchPositionX, TouchPositionY\n";
    for (HashMap<Field, String> record : table) {
      for (int i=0; i<outputField.length; i++) {
        rtn += record.get(outputField[i]);
        rtn += (i != outputField.length-1) ? ", " : "\n";
      }
    }
    println(rtn);
    return rtn;
  }

  private void addRecord() {
    table.add(new HashMap<Field, String>());
  }

  private void writeTouchTiming() {
    table.getLast().put(Field.TouchTiming, String.format("%5s", str(playingFrame)));
  }

  private void writeCorrectTiming() {
    table.getLast().put(Field.CorrectTiming, String.format("%5s", str(judgeField.getJustFrame())));
  }

  //TODO: +-表示する
  private void writeTimingDiff() {
    table.getLast().put(Field.TimingDiff, String.format("%3s", str(judgeField.getTimingDiff())));
  }

  private void writeJudgment(Judgment judgment) {
    table.getLast().put(Field.Judgment, judgmentToString(judgment));
  }
  
//TODO: 画面上に複数の指が触れている場合を想定したコードに書き直す
//TODO: JudgeFieldから必要な値をまとめて受け取るメソッドを作ったほうがいい？　JudgeFieldの中でないと判定されたtouchが何番目かわからない？ 末尾のtouchが判定されたtouch？
  private void writeTouchPosition() {
    processing.event.TouchEvent.Pointer touch = touches[touches.length-1];
    table.getLast().put(Field.TouchPositionX, String.format("%4s", str((int)touch.x)));
    table.getLast().put(Field.TouchPositionY, String.format("%4s", str((int)touch.y)));
  }

  private String judgmentToString(Judgment judgment) {
    switch (judgment) {
    case Good:
      return "Good";
    case Nice:
      return "Nice";
    case Bad:
      return " Bad";
    default:
      return "Error";
    }
  }
  
  
//TODO: TouchActionはこのテーブルでは保持しない。現在の仕様ではでは結果的にTOUCH_DOWNの瞬間のみにレコードが記録されるので、タッチした時のフレームとTouchActionだけを保持するテーブルを用意する。
//TODO: または、TOUCH_UPの時はTouchTiming, TouchAction, TouchPosition以外は空欄のレコードを追加するべき？
 // private String touchActionToString() {
 //   if (isTouchD
    
 //){
      
 //   }
 // }
  
//boolean isTouch, isTouchDown, isTouchUp, isPointerTouchDown, isPointerTouchUp;
}

//enum Field {
//  TouchTiming,
//  CorrectTiming,
//  TimingDiff,
//  //TouchAction,
//  Judgment,
//  TouchPositionX,
//  TouchPositionY
//}
