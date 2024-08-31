class JsonBuffer {
  final private String FILE_PATH;
  private JSONObject json;
  
   JsonBuffer(String filePath) {
     FILE_PATH = filePath;
     try {
       json = loadJSONObject(sketchPath("") + "/" + FILE_PATH);
     } catch (Exception e) {
       json = loadJSONObject(FILE_PATH);
     }
   }
   
   public boolean myGetBoolean(String jsonKey) { return json.getBoolean(jsonKey); }
   public void mySetBoolean(String jsonKey, boolean state) {json.setBoolean(jsonKey, state); }
   
   public void saveJSON() {
     saveJSONObject(json, FILE_PATH);
     println("JSON saved");
     println("Buffer: " + json);
     println("SavedFile: " + loadJSONObject(sketchPath("") + "/" + FILE_PATH));
   }
}

//メモ
//・Processing for Androidで、saveJSONObjectでは「/」付きのパスを処理することができない
//・loadJSONObject()に渡すパスが絶対パス（sketchPath("")から始まるパス）の場合、次のようなエラーが発生する。
//Couldn't create a reader for /data/user/0/processing.test.expt_rhythmgame/files/developer_config.json
//・loadJSONObject()に渡すパスが「processing.test.expt_rhythmgame」からの相対パスの場合、読み込むことはできる。
//・saveJSONObject()に渡すパスが相対/絶対に関わらず、この関数で保存されたjsonファイルにloadJSONObject()でアクセスするときは、絶対パスでないと到達できない。
//・Processing for Androidで、Run on Deviceを行うとき、saveJSONObject()で保存したjsonファイルは変更されずに残る
