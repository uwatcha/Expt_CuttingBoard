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
    if (currentScreen == ScreenType.Playing) {
      playingScreen.pause();
    }
    super.onPause();
  }
  
@Override
  public void onStart() {
    super.onStart();
  }
