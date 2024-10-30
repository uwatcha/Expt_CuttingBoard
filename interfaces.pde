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
  void createRecord(Action action, int justMillis, int diff, Judgment judgment, float touchX, float touchY);
}
interface TouchTable extends AddJudgment, AddTimingDiff {
  void createRecord(int justMillis, int diff, Judgment judgment, float touchX, float touchY);
}
interface ActionTable extends AddAction {
  void createRecord(Action action, int justMillis, float touchX, float touchY);
}

interface AddAction {
  default void addAction(Action action, HashMap<String, String> record, String field) {
    println("action: "+action);
    String output;
    if (action==Action.Down) {
      output = "Touch_DOWN";
    } else if (action==Action.Up) {
      output = "Touch___UP";
    } else {
      output = ""+action;
      println("Not expected Value!!: "+action);
    }
    record.put(field, output);
  }
}
interface AddJudgment {
  default void addJudgment(Judgment judgment, HashMap<String, String> record, String field) {
    if (judgment!=Judgment.None) {
      if (judgment==Judgment.Bad) {
        record.put(field, " "+judgment.name());
      } else {
        record.put(field, judgment.name());
      }
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
    record.put(field, sign+String.format("%4s", str(abs(diff))));
  }
}
