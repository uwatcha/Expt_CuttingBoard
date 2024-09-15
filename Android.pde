//draw()の前に実行される
@Override
  public boolean surfaceTouchEvent(MotionEvent event) {
    //この条件式をscreenのものと共通化
  if (screen == Screen.Playing && frameCount-playStartFrame > START_INTERVAL) {
    println(event.getActionMasked());
    println("touches.length: "+touches.length);
    actionID = event.getActionMasked();
    actionPosition[0] = event.getX(event.getPointerCount()-1);
    actionPosition[1] = event.getY(event.getPointerCount()-1);
  }
  return super.surfaceTouchEvent(event);
}
