final int SCREEN_TITLE_SIZE = 150;
//TODO: 全てsetupで初期化するのではなく、各画面で必要な変数だけを初期化し、その画面から出たらメモリ解放する方がいい？

void titleScreen() {
  background(woodImage);
  displayText("タブレットまな板", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
  settingsButton.run();
  startButton.run();
}

void settingsScreen() {
  background(woodImage);
  displayText("Settings", width/2, height/6, SCREEN_TITLE_SIZE, BLACK);
  settingsToTitleButton.run();
  feedbackToggleButton.run();
  gaugeToggleButton.run();
  tempoSlider.run();
}

ArrayList<Object> judgeFieldValues;
int logJustFrame;
int logTimingDiff;
float logTouchPositionX, logTouchPositionY;
Judgment judgment = Judgment.None;
void playingScreen() {
  //背景-----------------------------------------------------------------------------------------------------------------------------------------------
  background(woodImage);
  //オブジェクト実行-------------------------------------------------------------------------------------------------------------------------------------
  playingToTitleButton.run();
  //バッファタイム
  if (frameCount-playStartFrame < START_INTERVAL) {
    displayArcRing(width/2, height/4, 125, 0, map(frameCount-playStartFrame, 0, START_INTERVAL, 0, TWO_PI), 40, LIGHT_GREEN);
    gauge.displayFrame();
    judgeField.display();
  } else {
    //ゲーム実行中
    playingFrame++;
    loopFrame = loopFrame+1<TOUCH_INTERVAL ? loopFrame+1 : 0;
    if (loopFrame==TOUCH_INTERVAL/2) {
      timingSE.play();
    }
    gauge.run();
    judgeFieldValues = judgeField.run();
    ///*
    if (judgeFieldValues.size()!=0) {
      logJustFrame = (int)judgeFieldValues.get(JUST_FRAME_INDEX);
      logTimingDiff = (int)judgeFieldValues.get(TIMING_DIFF_INDEX);
      judgment = (Judgment)judgeFieldValues.get(JUDGMENT_INDEX);
      logTouchPositionX = (float)judgeFieldValues.get(POSITION_X_INDEX);
      logTouchPositionY = (float)judgeFieldValues.get(POSITION_Y_INDEX);
    }
    
    if (actionID==MotionEvent.ACTION_DOWN && judgeField.isTouchInField()) {
      generalCSV.createRecord(actionID, logJustFrame, logTimingDiff, judgment, actionPosition[0], actionPosition[1]);
      actionCSV.createRecord(actionID, logJustFrame, actionPosition[0], actionPosition[1]);
      touchCSV.createRecord(logJustFrame, logTimingDiff, judgment, logTouchPositionX, logTouchPositionY);
    } 
    
    feedback.run(judgment);
    
    if (actionID==MotionEvent.ACTION_UP && judgeField.isTouchInField() && judgment!=Judgment.None) {
      generalCSV.createRecord(actionID, logJustFrame, logTimingDiff, judgment, actionPosition[0], actionPosition[1]);
      actionCSV.createRecord(actionID, logJustFrame, actionPosition[0], actionPosition[1]);
      judgeFieldValues = new ArrayList<Object>();
      logJustFrame = FIELD_RESET_VALUE;
      logTimingDiff = FIELD_RESET_VALUE;
      judgment = Judgment.None;
      logTouchPositionX = FIELD_RESET_VALUE;
      logTouchPositionY = FIELD_RESET_VALUE;

    }

    if (judgeField.getJustFrame()==playingFrame) {
      playHitSE();
      generalCSV.createJustFrameRecord(judgeField.getJustFrame());
      actionCSV.createJustFrameRecord(judgeField.getJustFrame());
      touchCSV.createJustFrameRecord(judgeField.getJustFrame());
    }
  }
}
