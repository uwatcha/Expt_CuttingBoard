class FileBuffer {
  final private String FILE_PATH;
  private JSONObject json;
  
   FileBuffer(String filePath) {
     FILE_PATH = filePath;
     try {
       json = loadJSONObject(sketchPath("") + "/" + FILE_PATH);
     } catch (Exception e) {
       json = loadJSONObject(FILE_PATH);
     }
   }
   
   public JSONObject getJSON() { return json; }
   
   public void saveJSON() {
     saveJSONObject(json, FILE_PATH);
     println("JSON saved");
   }
}

//メモ
//・Processing for Androidで、FileBufferでは「/」付きのパスを処理することができない
//・loadJSONObject()に渡すパスが絶対パス（sketchPath("")から始まるパス）の場合、次のようなエラーが発生する。
//Couldn't create a reader for /data/user/0/processing.test.expt_rhythmgame/files/developer_config.json
//・loadJSONObject()に渡すパスが「processing.test.expt_rhythmgame」からの相対パスの場合、読み込むことはできる。
//・saveJSONObject()に渡すパスが相対/絶対に関わらず、この関数で保存されたjsonファイルにloadJSONObject()でアクセスするときは、絶対パスでないと到達できない。
//・Processing for Androidで、Run on Deviceを行うとき、saveJSONObject()で保存したjsonファイルは変更されずに残る
