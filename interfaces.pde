//TODO: run()やdisplay()をまとめたinterfaceを作る
//TODO: run()で引数を受け取ったり、値を返したりしないように統一した方がいい？

//注意：以下のTableのinterface内のメソッドは仕様上、実装クラスでprivateにできないが、createRecord以外は実装クラス外で使用されることを想定していない
interface CommonTable {
  default void addTouchTiming(int playingFrame, LinkedList<HashMap<String, String>> table, String field) {
    table.getLast().put(field, String.format("%5s", str(playingFrame)));
  }

  default void addCorrectTiming(int justFrame, LinkedList<HashMap<String, String>> table, String field) {
    table.getLast().put(field, String.format("%5s", str(justFrame)));
  }
  default void addTouchPosition(float touchX, float touchY, LinkedList<HashMap<String, String>> table, String fieldX, String fieldY) {
    table.getLast().put(fieldX, String.format("%4s", str((int)touchX)));
    table.getLast().put(fieldY, String.format("%4s", str((int)touchY)));
  }
}
interface GeneralTable extends AddJudgment, AddTimingDiff, AddAction {
  void createRecord(int action, int justFrame, int diff, Judgment judgment, float touchX, float touchY);
}
interface TouchTable extends AddJudgment, AddTimingDiff {
  void createRecord(int justFrame, int diff, Judgment judgment, float touchX, float touchY);
}
interface ActionTable extends AddAction {
  void createRecord(int action, int justFrame, float touchX, float touchY);
}

interface AddAction {
  default void addAction(int actionID, LinkedList<HashMap<String, String>> table, String field) {
    String output = "";
    switch (actionID) {
      case MotionEvent.ACTION_DOWN:
      output = "Touch_DOWN";
      break;
      case MotionEvent.ACTION_UP:
      output = "Touch___UP";
      break;
      default: 
      //println("Not expected Value!!: "+actionID);
    }
    table.getLast().put(field, output);

  }
}
interface AddJudgment {
  default void addJudgment(Judgment judgment, LinkedList<HashMap<String, String>> table, String field) {
    if (judgment!=Judgment.None) {
      //TODO: Badの時に空白埋めする
      table.getLast().put(field, judgment.name());
    } else {
      println("addJudgeのjudgmentがJudgment.Noneです。");
    }
  }

}
interface AddTimingDiff {
  default void addTimingDiff(int diff, LinkedList<HashMap<String, String>> table, String field) {
    String sign = "";
    if (diff > 0) {
      sign = "+";
    } else if (diff < 0) {
      sign = "-";
    } else {
      sign = " ";
    }
    table.getLast().put(field, sign+String.format("%3s", str(abs(diff))));
  }
}
