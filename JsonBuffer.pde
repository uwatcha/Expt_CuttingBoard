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
     //println("Buffer: " + json);
     //println("SavedFile: " + loadJSONObject(sketchPath("") + "/" + FILE_PATH));
   }
}
