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
      makeDirectory(path);
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
      println(table);
      return true;
    }
    catch (Exception e) {
      return false;
    }
  }
  
  private void makeDirectory(String path) {
    int startIndex = EXPORT_PATH.length();
    int endIndex = path.lastIndexOf(File.separator);
    String directoryName = path.substring(startIndex, endIndex);
    File dir = new File(EXPORT_PATH+File.separator+directoryName);
    if (!(dir.exists() && dir.isDirectory())) {
      dir.mkdirs();
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
}

//------------------------------------------------------------------------------------------------------------------------------------------

class GeneralCSV extends CSVObject implements GeneralTable {
  GeneralCSV() {
    super(GENERAL_TABLE_FIELDS);
  }
  
  public void createRecord(int actionID, int justFrame, int diff, Judgment judgment, float touchX, float touchY) {
    addRecord();
    addTouchTiming(playingFrame, table, TOUCH_TIMING);
    addAction(actionID, table, ACTION);
    addCorrectTiming(justFrame, table, CORRECT_TIMING);
    addTimingDiff(diff, table, TIMING_DIFF);
    addJudgment(judgment, table, JUDGMENT);
    addTouchPosition(touchX, touchY, table, TOUCH_POSITION_X, TOUCH_POSITION_Y);
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class TouchCSV extends CSVObject implements TouchTable {
  TouchCSV () {
    super(TOUCH_TABLE_FIELDS);
  }
  
  
  public void createRecord(int justFrame, int diff, Judgment judgment, float touchX, float touchY) {
    addRecord();
    addTouchTiming(playingFrame, table, TOUCH_TIMING);
    addCorrectTiming(justFrame, table, CORRECT_TIMING);
    addTimingDiff(diff, table, TIMING_DIFF);
    addJudgment(judgment, table, JUDGMENT);
    addTouchPosition(touchX, touchY, table, TOUCH_POSITION_X, TOUCH_POSITION_Y);
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class ActionCSV extends CSVObject implements ActionTable {
  
  ActionCSV() {
    super(ACTION_TABLE_FIELDS);
  }
  
  void createRecord(int actionID, int justFrame, float touchX, float touchY) {
    addRecord();
    addAction(actionID, table, ACTION);
    addTouchTiming(playingFrame, table, TOUCH_TIMING);
    addCorrectTiming(justFrame, table, CORRECT_TIMING);
    addTouchPosition(touchX, touchY, table, TOUCH_POSITION_X, TOUCH_POSITION_Y);
  }
}
