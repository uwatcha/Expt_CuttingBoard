abstract class CSVObject implements CommonTable {
  protected LinkedList<HashMap<String, String>> table;
  protected String[] fields;

  CSVObject(String[] fields) {
    resetTable();
    this.fields = fields;
  }

  protected void addRecord() {
    table.add(new HashMap<String, String>());
  }

  public boolean output(String path) {
    File file = new File(path);
    FileOutputStream fos;
    OutputStreamWriter isw;
    BufferedWriter bw;
    try {
      fos = new FileOutputStream(file);
      isw = new OutputStreamWriter(fos, "UTF-8");
      bw = new BufferedWriter(isw);

      for (String data : tableToList()) {
        bw.write(data);
      }
      bw.flush();
      bw.close();
      isw.close();
      fos.close();
      return true;
    }
    catch (Exception e) {
      return false;
    }
  }
  
  private ArrayList<String> tableToList() {
    ArrayList<String> rtn = getHeader();
    for (HashMap<String, String> record : table) {
      for (int i=0; i<fields.length; i++) {
        String line = "";
        line += record.get(fields[i]);
        line += (i != fields.length-1) ? ", " : "\n";
        rtn.add(line);
      }
    }
    return rtn;
  }

  private ArrayList<String> getHeader() {
    ArrayList<String> rtn = new ArrayList<String>();
    rtn.add("DateTime: "+ getTime() +"\n");
    rtn.add("Feedback: "+ (faciSettings.myGetBoolean(isActiveFeedback) ? "Active" : "Inactive") + ", ");
    rtn.add("Gauge: "+ (faciSettings.myGetBoolean(isActiveGauge) ? "Active" : "Inactive") + "\n");
    for (int i=0; i<fields.length; i++) {
      rtn.add(fields[i]);
      rtn.add(i!=fields.length-1 ? ", " : "\n");
    }
    return rtn;
  }

  public void resetTable() {
    table = new LinkedList<HashMap<String, String>>();
  }

  void addTouchTiming() {
    table.getLast().put(TOUCH_TIMING, String.format("%5s", str(playingFrame)));
  }

  void addCorrectTiming(int justFrame) {
    table.getLast().put(CORRECT_TIMING, String.format("%5s", str(justFrame)));
  }
  void addTouchPosition(float touchX, float touchY) {
    table.getLast().put(TOUCH_POSITION_X, String.format("%4s", str((int)touchX)));
    table.getLast().put(TOUCH_POSITION_Y, String.format("%4s", str((int)touchY)));
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class TouchCSV extends CSVObject implements TouchTable {
  TouchCSV () {
    super(TOUCH_TABLE_FIELDS);
  }
  
  
  public void createRecord(int justFrame, int diff, Judgment judgment, float touchX, float touchY) {
    addRecord();
    addTouchTiming();
    addCorrectTiming(justFrame);
    addTimingDiff(diff);
    addJudgment(judgment);
    addTouchPosition(touchX, touchY);
  }
  
  void addJudgment(Judgment judgment) {
    if (judgment!=Judgment.None) {
      table.getLast().put(JUDGMENT, judgment.name());
    } else {
      println("addJudgeのjudgmentがJudgment.Noneです。");
    }
  }
  
  void addTimingDiff(int diff) {
    String sign = "";
    if (diff > 0) {
      sign = "+";
    } else if (diff < 0) {
      sign = "-";
    } else {
      sign = " ";
    }
    table.getLast().put(TIMING_DIFF, sign+String.format("%3s", str(abs(diff))));
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class ActionCSV extends CSVObject implements ActionTable {
  
  ActionCSV() {
    super(ACTION_TABLE_FIELDS);
  }
  
  void createRecord(int actionID, int justFrame, float touchX, float touchY) {
    addRecord();
    addAction(actionID);
    addTouchTiming();
    addCorrectTiming(justFrame);
    addTouchPosition(touchX, touchY);
  }
  
  void addAction(int actionID) {
    String output = "";
    switch (actionID) {
      case MotionEvent.ACTION_DOWN:
      output = "Touch_DOWN";
      break;
      case MotionEvent.ACTION_UP:
      output = "Touch___UP";
      break;
    }
    table.getLast().put(ACTION, output);
  }
}
