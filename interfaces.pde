//TODO: run()やdisplay()をまとめたinterfaceを作る
//TODO: run()で引数を受け取ったり、値を返したりしないように統一した方がいい？

//注意：以下のTableのinterface内のメソッドは仕様上、実装クラスでprivateにできないが、createRecord以外は実装クラス外で使用されることを想定していない
interface CommonTable {
  void createRecord(HashMap<Field, Object> field);
  default void addActualTiming(HashMap<String, String> record, String field, int playingMillis) {
    record.put(field, String.format("%5s", str(playingMillis)));
  }

  default void addTargetTiming(HashMap<String, String> record, String field, int justMillis) {
    record.put(field, String.format("%5s", str(justMillis)));
  }
  default void addTouchPosition(HashMap<String, String> record, String fieldX, String fieldY, int touchX, int touchY) {
    record.put(fieldX, String.format("%4s", str(touchX)));
    record.put(fieldY, String.format("%4s", str(touchY)));
  }
}
interface GeneralTable extends AddJudgment, AddTimingDiff, AddAction {
}
interface TouchTable extends AddJudgment, AddTimingDiff {
}
interface ActionTable extends AddAction {
}

interface AddAction {
  default void addAction(HashMap<String, String> record, String field, Action action) {
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
  default void addJudgment(HashMap<String, String> record, String field, Judgment judgment) {
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
  default void addTimingDiff(HashMap<String, String> record, String field, int diff) {
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
