abstract class CSVObject implements CommonTable {
  protected final String SEPARATOR;
  protected final String EXPORT_FOLDER_PATH;
  protected final String[] FIELDS;
  
  protected static final String TOUCH_TIMING = "TouchTiming";
  protected static final String CORRECT_TIMING = "CorrectTiming";
  protected static final String TOUCH_POSITION_X = "TouchPositinoX";
  protected static final String TOUCH_POSITION_Y = "TouchPositinoY";
  protected static final String JUDGMENT = "Judgment";
  protected static final String TIMING_DIFF = "TouchDiff";
  protected static final String ACTION = "Action";

  protected HashMap<String, String> record;

  protected File file;
  protected FileOutputStream fos;
  protected OutputStreamWriter osw;
  protected BufferedWriter bw;

  CSVObject(String[] fields) {
    SEPARATOR = File.separator;
    EXPORT_FOLDER_PATH = getActivity().getExternalFilesDir("").getPath();
    resetRecord();
    this.FIELDS = fields;
  }

  private String getFileNameDateTime() {
    return nf(year(), 4)+"-"+nf(month(), 2)+"-"+nf(day(), 2)+"--"+nf(hour(), 2)+"-"+nf(minute(), 2);
  }
  private String getDateTime() {
    return nf(year(), 4)+"/"+nf(month(), 2)+"/"+nf(day(), 2)+" "+nf(hour(), 2)+":"+nf(minute(), 2);
  }

  protected String getExportPath(String fileKindName) {
    return EXPORT_FOLDER_PATH+SEPARATOR+fileKindName+SEPARATOR+getFileNameDateTime()+"_"+fileKindName+".csv";
  }

//TODO: これを、新しいHashMapを返す関数にし、メンバ変数としてrecordを持たないようにする
  protected void resetRecord() {
    record = new HashMap<String, String>();
  }

  public void createFile(String path) {
    file = new File(path);
    isContinueWriting = true;
    try {
      makeDirectory(path);
      fos = new FileOutputStream(file);
      osw = new OutputStreamWriter(fos, "UTF-8");
      bw = new BufferedWriter(osw);
      for (String line: getSettingsTable()) {
        bw.write(line+"\n");
      }
      bw.write("\n");
      for (String line: getHeader()) {
        bw.write(line+"\n");
      }
    }
    catch (Exception e) {
    }
  }
  
  private ArrayList<String> getSettingsTable() {
    ArrayList<String> rtn = new ArrayList<String>();
    rtn.add("Setting");
    rtn.add("DateTime, Time unit, Good time, Nice time, Feedback, Gauge, BPM");
    String settingValueLine = "";
    settingValueLine += getDateTime() +", ";
    settingValueLine += "milli second, ";
    settingValueLine += GOOD_MILLIS +", ";
    settingValueLine += NICE_MILLIS +", ";
    settingValueLine += (faciSettings.myGetBoolean(isActiveFeedback) ? "Active" : "Inactive") + ", ";
    settingValueLine += (faciSettings.myGetBoolean(isActiveGauge) ? "Active" : "Inactive") + ", ";
    settingValueLine += (faciSettings.myGetInt(bpm));
    rtn.add(settingValueLine);
    return rtn;
  }
  
  private ArrayList<String> getHeader() {
    ArrayList<String> rtn = new ArrayList<String>();
    rtn.add("Log");
    String attrNameLine = "";
    for (int i=0; i<FIELDS.length; i++) {
      attrNameLine += FIELDS[i];
      attrNameLine += i!=FIELDS.length-1 ? ", " : "";
    }
    rtn.add(attrNameLine);
    return rtn;
  }
  
  public void createJustMillisRecord(int justMillis) {
    resetRecord();
    addCorrectTiming(record, CORRECT_TIMING, justMillis);
    writeRecordToFile();
  }
  
  public void reopenFile() {
    try {
      fos = new FileOutputStream(file, true);
      osw = new OutputStreamWriter(fos, "UTF-8");
      bw = new BufferedWriter(osw);
    }
    catch (Exception e) {
    }
  }

  public void writeRecordToFile() {
    try {
      bw.write(recordToString()+"\n");
    }
    catch (Exception e) {
    }
  }

  public void closeFile() {
    try {
      bw.flush();
      bw.close();
      osw.close();
      fos.close();
    }
    catch (Exception e) {
    }
  }

  private void makeDirectory(String path) {
    int startIndex = EXPORT_FOLDER_PATH.length();
    int endIndex = path.lastIndexOf(SEPARATOR);
    String directoryName = path.substring(startIndex, endIndex);
    File dir = new File(EXPORT_FOLDER_PATH+SEPARATOR+directoryName);
    if (!(dir.exists() && dir.isDirectory())) {
      dir.mkdirs();
    }
  }
  
//TODO: -の数を、それぞれのFIELDの文字数を取得して変える方法に変更する
  private String recordToString() {
    String rtn = "";
    for (int i=0; i<FIELDS.length; i++) {
      String value = record.get(FIELDS[i]);
      if (value!=null) {
        rtn += value;
      } else {
        switch(FIELDS[i]) {
        case ACTION:
          rtn += "----------";
          break;
        case TOUCH_TIMING:
          rtn += "-----";
          break;
        case TIMING_DIFF:
          rtn += "-----";
          break;
        case JUDGMENT:
          rtn += "----";
          break;
        case TOUCH_POSITION_X:
          rtn += "----";
          break;
        case TOUCH_POSITION_Y:
          rtn += "----";
          break;
        }
      }
      rtn += (i != FIELDS.length-1) ? ", " : "";
    }
    return rtn;
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class GeneralCSV extends CSVObject implements GeneralTable {
  GeneralCSV() {
    super(new String[] {ACTION, TOUCH_TIMING, CORRECT_TIMING, TIMING_DIFF, JUDGMENT, TOUCH_POSITION_X, TOUCH_POSITION_Y});
  }

  public void createFile() {
    super.createFile(getExportPath("general"));
  }
  //TODO: ３種のcreateRecordを、KeyがFIELD文字列変数、Valueがそれに対応する値のHashMapで渡すようにする
  //TODO: そのために、FIELD配列のgetterを作る
  //TODO: touchTiming→actualTiming, correctTiming→targetTimingに名前変更する
  //TODO: potisionフィールドがpotisinoになっている
  public void createRecord(Action action, int justMillis, int diff, Judgment judgment, float touchX, float touchY) {
    resetRecord();
    addTouchTiming(record, TOUCH_TIMING, playingMillis());
    addAction(record, ACTION, action);
    addCorrectTiming(record, CORRECT_TIMING, justMillis);
    addTimingDiff(record, TIMING_DIFF, diff);
    addJudgment(record, JUDGMENT, judgment);
    addTouchPosition(record, TOUCH_POSITION_X, TOUCH_POSITION_Y, touchX, touchY);
    writeRecordToFile();
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class TouchCSV extends CSVObject implements TouchTable {
  TouchCSV () {
    super(new String[] {TOUCH_TIMING, CORRECT_TIMING, TIMING_DIFF, JUDGMENT, TOUCH_POSITION_X, TOUCH_POSITION_Y});
  }

  public void createFile() {
    super.createFile(getExportPath("touch"));
  }

  public void createRecord(int justMillis, int diff, Judgment judgment, float touchX, float touchY) {
    resetRecord();
    addTouchTiming(record, TOUCH_TIMING, playingMillis());
    addCorrectTiming(record, CORRECT_TIMING, justMillis);
    addTimingDiff(record, TIMING_DIFF, diff);
    addJudgment(record, JUDGMENT, judgment);
    addTouchPosition(record, TOUCH_POSITION_X, TOUCH_POSITION_Y, touchX, touchY);
    writeRecordToFile();
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class ActionCSV extends CSVObject implements ActionTable {
  ActionCSV() {
    super(new String[] {ACTION, TOUCH_TIMING, CORRECT_TIMING, TOUCH_POSITION_X, TOUCH_POSITION_Y});
  }

  public void createFile() {
    super.createFile(getExportPath("action"));
  }

  void createRecord(Action action, int justMillis, float touchX, float touchY) {
    resetRecord();
    addAction(record, ACTION, action);
    addTouchTiming(record, TOUCH_TIMING, playingMillis());
    addCorrectTiming(record, CORRECT_TIMING, justMillis);
    addTouchPosition(record, TOUCH_POSITION_X, TOUCH_POSITION_Y, touchX, touchY);
    writeRecordToFile();
  }
}
