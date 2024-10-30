abstract class CSVObject implements CommonTable {
  final protected String SEPARATOR;
  final protected String EXPORT_FOLDER_PATH;
  final protected String[] FIELDS;
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

  protected String getExportPath(String fileKindName) {
    return EXPORT_PATH+SEPARATOR+fileKindName+SEPARATOR+getTime()+"_"+fileKindName+".csv";
  }

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
      for (String line : getHeader()) {
        bw.write(line+"\n");
      }
    }
    catch (Exception e) {
    }
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

  public void writeFile() {
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
    int startIndex = EXPORT_PATH.length();
    int endIndex = path.lastIndexOf(File.separator);
    String directoryName = path.substring(startIndex, endIndex);
    File dir = new File(EXPORT_PATH+File.separator+directoryName);
    if (!(dir.exists() && dir.isDirectory())) {
      dir.mkdirs();
    }
  }

  private String recordToString() {
    String rtn = "";
    for (int i=0; i<FIELDS.length; i++) {
      String value = record.get(FIELDS[i]);
      rtn += value!=null ? value : "-------";
      rtn += (i != FIELDS.length-1) ? ", " : "";
    }
    return rtn;
  }

  private ArrayList<String> getHeader() {
    ArrayList<String> rtn = new ArrayList<String>();
    rtn.add("Setting");
    rtn.add("DateTime, Time unit, Good time, Nice time, Feedback, Gauge, BPM");
    String settingValueLine = "";
    settingValueLine += getTime() +", ";
    settingValueLine += "milli second, ";
    settingValueLine += GOOD_MILLIS +", ";
    settingValueLine += NICE_MILLIS +", ";
    settingValueLine += (faciSettings.myGetBoolean(isActiveFeedback) ? "Active" : "Inactive") + ", ";
    settingValueLine += (faciSettings.myGetBoolean(isActiveGauge) ? "Active" : "Inactive") + ", ";
    settingValueLine += (faciSettings.myGetInt(bpm))+"\n";
    rtn.add(settingValueLine);
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
    addCorrectTiming(justMillis, record, CORRECT_TIMING);
    writeFile();
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class GeneralCSV extends CSVObject implements GeneralTable {
  GeneralCSV() {
    super(GENERAL_TABLE_FIELDS);
  }

  public void createFile() {
    super.createFile(getExportPath("general"));
  }

  public void createRecord(int actionID, int justMillis, int diff, Judgment judgment, float touchX, float touchY) {
    resetRecord();
    addTouchTiming(playingMillis(), record, TOUCH_TIMING);
    addAction(actionID, record, ACTION);
    addCorrectTiming(justMillis, record, CORRECT_TIMING);
    addTimingDiff(diff, record, TIMING_DIFF);
    addJudgment(judgment, record, JUDGMENT);
    addTouchPosition(touchX, touchY, record, TOUCH_POSITION_X, TOUCH_POSITION_Y);
    writeFile();
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class TouchCSV extends CSVObject implements TouchTable {
  TouchCSV () {
    super(TOUCH_TABLE_FIELDS);
  }

  public void createFile() {
    super.createFile(getExportPath("touch"));
  }

  public void createRecord(int justMillis, int diff, Judgment judgment, float touchX, float touchY) {
    resetRecord();
    addTouchTiming(playingMillis(), record, TOUCH_TIMING);
    addCorrectTiming(justMillis, record, CORRECT_TIMING);
    addTimingDiff(diff, record, TIMING_DIFF);
    addJudgment(judgment, record, JUDGMENT);
    addTouchPosition(touchX, touchY, record, TOUCH_POSITION_X, TOUCH_POSITION_Y);
    writeFile();
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------

class ActionCSV extends CSVObject implements ActionTable {

  ActionCSV() {
    super(ACTION_TABLE_FIELDS);
  }

  public void createFile() {
    super.createFile(getExportPath("action"));
  }

  void createRecord(int actionID, int justMillis, float touchX, float touchY) {
    resetRecord();
    addAction(actionID, record, ACTION);
    addTouchTiming(playingMillis(), record, TOUCH_TIMING);
    addCorrectTiming(justMillis, record, CORRECT_TIMING);
    addTouchPosition(touchX, touchY, record, TOUCH_POSITION_X, TOUCH_POSITION_Y);
    writeFile();
  }
}
