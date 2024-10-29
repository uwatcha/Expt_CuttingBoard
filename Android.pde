@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
  actionIdFromAndroid = event.getActionMasked();
  actionPosition[0] = event.getX(event.getPointerCount()-1);
  actionPosition[1] = event.getY(event.getPointerCount()-1);
  return super.surfaceTouchEvent(event);
}

@Override
  public void onPause() {
    closeFiles();
    //TODO: アプリを一時停止する処理
    super.onPause();
    
  }
  
@Override
  public void onStart() {
    super.onStart();
    if (isContinueWriting) {
      generalCSV.reopenFile();
      touchCSV.reopenFile();
      actionCSV.reopenFile();
    }
  }
