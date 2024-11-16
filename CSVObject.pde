abstract class CSVObject implements CommonTable {
  protected final String SEPARATOR;
  protected final String EXPORT_FOLDER_PATH;
  protected final Field[] FIELDS;

  protected HashMap<String, String> record;

  protected File file;
  protected FileOutputStream fos;
  protected OutputStreamWriter osw;
  protected BufferedWriter bw;

  CSVObject(Field[] fields) {
    SEPARATOR = File.separator;
    EXPORT_FOLDER_PATH = getActivity().getExternalFilesDir("").getPath();
    resetRecord();
    this.FIELDS = fields;
  }
  
  public Field[] getFields() { return FIELDS; }

  private String getFileNameDateTime() {
    return nf(year(), 4)+"-"+nf(month(), 2)+"-"+nf(day(), 2)+"--"+nf(hour(), 2)+"-"+nf(minute(), 2)+"-"+nf(second(), 2);
  }
  private String getDateTime() {
    return nf(year(), 4)+"/"+nf(month(), 2)+"/"+nf(day(), 2)+" "+nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2);
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
    addTargetTiming(record, Field.TargetTiming.toString(), justMillis);
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

  protected void writeRecordToFile() {
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
      String value = record.get(FIELDS[i].toString()); //null
      if (value!=null) {
        rtn += value;
      } else {
        switch(FIELDS[i]) {
        case Action:
          rtn += "----------";
          break;
        case ActualTiming:
          rtn += "-----";
          break;
        case TimingDiff:
          rtn += "-----";
          break;
        case Judgment:
          rtn += "----";
          break;
        case TouchPositionX:
          rtn += "----";
          break;
        case TouchPositionY:
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
    super(new Field[] {Field.Action, Field.ActualTiming, Field.TargetTiming, Field.TimingDiff, Field.Judgment, Field.TouchPositionX, Field.TouchPositionY});
  }

  public void createFile() {
    super.createFile(getExportPath("general"));
  }

  public void createRecord(HashMap<Field, Object> field) {
    resetRecord();
    addAction(record, Field.Action.toString(), (Action)field.get(Field.Action));
    addActualTiming(record, Field.ActualTiming.toString(), (int)field.get(Field.ActualTiming));
    addTargetTiming(record, Field.TargetTiming.toString(), (int)field.get(Field.TargetTiming));
    addTimingDiff(record, Field.TimingDiff.toString(), (int)field.get(Field.TimingDiff));
    addJudgment(record, Field.Judgment.toString(), (Judgment)field.get(Field.Judgment));
    addTouchPosition(record, Field.TouchPositionX.toString(), Field.TouchPositionY.toString(), (int)field.get(Field.TouchPositionX), (int)field.get(Field.TouchPositionY));
    writeRecordToFile();
  }
}
