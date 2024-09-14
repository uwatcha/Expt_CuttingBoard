//注意：以下のTableのinterface内のメソッドは仕様上、実装クラスでprivateにできないが、createRecord以外は実装クラス外で使用されることを想定していない
interface CommonTable {
  void addTouchTiming();
  void addCorrectTiming(int justFrame);
  void addTouchPosition(float touchX, float touchY);
}
interface TouchTable {
  void createRecord(int justFrame, int diff, Judgment judgment, float touchX, float touchY);
  void addJudgment(Judgment judgment);
  void addTimingDiff(int diff);
}
interface ActionTable {
  void createRecord(int action, int justFrame, float touchX, float touchY);
  void addAction(int event);
}

//TODO: run()やdisplay()をまとめたinterfaceを作る
//TODO: run()で引数を受け取ったり、値を返したりしないように統一した方がいい？
