//LinkedList: テーブルそのもの
//HashMap:    レコード

class CSVObject {
  private LinkedList<HashMap<Field, String>> table;
  private Field[] fields;

  CSVObject() {
    resetCSV();
    fields = new Field[] {Field.TouchTiming, Field.CorrectTiming, Field.TimingDiff, Field.Judgment, Field.TouchPositionX, Field.TouchPositionY};
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
  }

  public boolean saveCSV() {
    File file = new File(EXPORT_PATH+File.separator+getTime()+"_touch.csv");
    FileOutputStream fos;
    OutputStreamWriter isw;
    BufferedWriter bw;
    try {
      fos = new FileOutputStream(file);
      isw = new OutputStreamWriter(fos, "UTF-8");
      bw = new BufferedWriter(isw);
      
      for (String data: tableToArrayList()) {
        bw.write(data);
      }
      bw.flush(); bw.close(); isw.close(); fos.close();
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  public void resetCSV() {
    table = new LinkedList<HashMap<Field, String>>();
  }
  
  private ArrayList<String> tableToArrayList() {
    ArrayList<String> rtn = new ArrayList<String>();
    rtn.add("DateTime: "+ getTime() +"\n");
    rtn.add("Feedback: "+ (faciSettings.myGetBoolean(isActiveFeedback) ? "Active" : "Inactive") + ", ");
    rtn.add("Gauge: "+ (faciSettings.myGetBoolean(isActiveGauge) ? "Active" : "Inactive") + "\n");
    rtn.add("TouchTiming, CorrectTiming, TimingDiff, Judgment, TouchPositionX, TouchPositionY\n");
    for (HashMap<Field, String> record : table) {
      for (int i=0; i<fields.length; i++) {
        String line = "";
        line += record.get(fields[i]);
        line += (i != fields.length-1) ? ", " : "\n";
        rtn.add(line);
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
  
  private String getTime() {
    return nf(year(), 4)+"-"+nf(month(), 2)+"-"+nf(day(), 2)+"--"+nf(hour(), 2)+"-"+nf(minute(), 2);
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
