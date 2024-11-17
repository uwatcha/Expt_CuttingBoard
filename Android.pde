@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
  if (event.getActionMasked()==MotionEvent.ACTION_DOWN || event.getActionMasked()==MotionEvent.ACTION_POINTER_DOWN) {
    actionFromAndroid = Action.Down;
  } else if (event.getActionMasked()==MotionEvent.ACTION_UP || event.getActionMasked()==MotionEvent.ACTION_POINTER_UP) {
    actionFromAndroid = Action.Up;
  }
  actionPosition[0] = (int)event.getX(event.getPointerCount()-1);
  actionPosition[1] = (int)event.getY(event.getPointerCount()-1);
  return super.surfaceTouchEvent(event);
}

@Override
  public void onPause() {
    playingScreen.closeFiles();
    if (currentScreen == ScreenType.Playing) {
      currentScreen = ScreenType.Pause;
    }
    //TODO: PlayingMillis()を停止できていない
    //TODO: 再開時にインターバルを挿入する
    super.onPause();
  }
  
@Override
  public void onStart() {
    super.onStart();
    if (isContinueWriting) {
      playingScreen.reopenFiles();
    }
  }
