//TODO: run()やdisplay()をまとめたinterfaceを作る
//TODO: run()で引数を受け取ったり、値を返したりしないように統一した方がいい？

//注意：以下のTableのinterface内のメソッドは仕様上、実装クラスでprivateにできないが、createRecord以外は実装クラス外で使用されることを想定していない
interface CommonTable {
  default void addTouchTiming(int playingMillis, HashMap<String, String> record, String field) {
    record.put(field, String.format("%5s", str(playingMillis)));
  }

  default void addCorrectTiming(int justMillis, HashMap<String, String> record, String field) {
    record.put(field, String.format("%5s", str(justMillis)));
  }
  default void addTouchPosition(float touchX, float touchY, HashMap<String, String> record, String fieldX, String fieldY) {
    record.put(fieldX, String.format("%4s", str((int)touchX)));
    record.put(fieldY, String.format("%4s", str((int)touchY)));
  }
}
interface GeneralTable extends AddJudgment, AddTimingDiff, AddAction {
  void createRecord(int action, int justMillis, int diff, Judgment judgment, float touchX, float touchY);
}
interface TouchTable extends AddJudgment, AddTimingDiff {
  void createRecord(int justMillis, int diff, Judgment judgment, float touchX, float touchY);
}
interface ActionTable extends AddAction {
  void createRecord(int action, int justMillis, float touchX, float touchY);
}

interface AddAction {
  default void addAction(int actionID, HashMap<String, String> record, String field) {
    String output = "";
    switch (actionID) {
      case MotionEvent.ACTION_DOWN:
      output = "Touch_DOWN";
      break;
      case MotionEvent.ACTION_UP:
      output = "Touch___UP";
      break;
      default: 
      output = ""+actionID;
      println("Not expected Value!!: "+actionID);
    }
    record.put(field, output);

  }
}
interface AddJudgment {
  default void addJudgment(Judgment judgment, HashMap<String, String> record, String field) {
    if (judgment!=Judgment.None) {
      //TODO: Badの時に空白埋めする
      record.put(field, judgment.name());
    } 
  }
}
interface AddTimingDiff {
  default void addTimingDiff(int diff, HashMap<String, String> record, String field) {
    String sign = "";
    if (diff > 0) {
      sign = "+";
    } else if (diff < 0) {
      sign = "-";
    } else {
      sign = " ";
    }
    record.put(field, sign+String.format("%3s", str(abs(diff))));
  }
}
