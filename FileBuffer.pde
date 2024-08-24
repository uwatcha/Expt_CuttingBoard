class FileBuffer {
  final private String FILE_PATH;
  private JSONObject json;
  
   FileBuffer(String filePath) {
     FILE_PATH = filePath;
     json = loadJSONObject(FILE_PATH);
   }
   
   public JSONObject getJSON() { return json; }
   
   public void saveJSON() {
     saveJSONObject(json, FILE_PATH);
   }
}
