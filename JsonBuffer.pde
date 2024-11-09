class JsonBuffer {
  private final String FILE_PATH;
  private JSONObject json;
  
   JsonBuffer(String filePath) {
     FILE_PATH = filePath;
     try {
       json = loadJSONObject(sketchPath("") + "/" + FILE_PATH);
     } catch (Exception e) {
       json = loadJSONObject(FILE_PATH);
     }
   }
   
   public int myGetInt(String jsonKey) { return json.getInt(jsonKey); }
   public boolean myGetBoolean(String jsonKey) { return json.getBoolean(jsonKey); }
   public void mySetInt(String jsonKey, int value) { json.setInt(jsonKey, value); }
   public void mySetBoolean(String jsonKey, boolean state) { json.setBoolean(jsonKey, state); }
   
   public void saveJSON() {
     saveJSONObject(json, FILE_PATH);
   }
}
