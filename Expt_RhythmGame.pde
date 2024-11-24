//TODO: 開発者メニューで、デバッグモードをオンにすると、ログファイルの出力先を変える。本来のログファイルを保存するフォルダを散らかさないため
//TODO: オブジェクトのちょっとした実行順でエラーが起きるので、原因と適切な実行順を明らかにする
import android.view.MotionEvent;
import android.app.Activity;

import processing.sound.SoundFile;
import processing.core.PApplet;

import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;

import java.util.LinkedList;
import java.util.Arrays;
import java.util.Map;
import java.util.Collections;


//JSON キー
final String isActiveFeedback = "is_active_feedback";
final String isActiveGauge = "is_active_gauge";
final String isDevelopMode = "is_develop_mode";
final String bpm = "bpm";

//判定時間
final int GOOD_MILLIS = framesToMillis(6);
final int NICE_MILLIS = framesToMillis(12);

//150: [Device: samsung]で、大文字のSの縦幅が1cm
final int STROKE_DEFAULT = 2;

//画像
PImage woodImage;
PImage gearImage;
PImage goodImage;
PImage niceImage;
PImage badImage;
PImage pauseImage;

//音声
SoundFile[] goodSEPool;
SoundFile[] niceSEPool;
SoundFile[] badSEPool;
SoundFile[] hitSEPool;
SoundFile timingSE;

//時間
final int FRAME_RATE = 60;
TimeManager timeManager;

//IO

//スクリーン
ScreenType currentScreen;
TitleScreen titleScreen;
SettingsScreen settingsScreen;
IntervalScreen intervalScreen;
PlayingScreen playingScreen;
PauseScreen pauseScreen;

final HashMap<String, String> UI_TITLES = new HashMap<String, String>() {
  {
    put(isActiveFeedback, "フィードバック");
    put(isActiveGauge, "ゲージ");
    put(isDevelopMode, "開発モード");
    put(bpm, "BPM");
  }
};

final int INT_RESET_VALUE = Integer.MAX_VALUE;

Action actionFromAndroid;
Action action;
int[] actionPosition;

JsonBuffer faciSettings;

StartButton startButton;
SettingsButton settingsButton;
SettingsToTitleButton settingsToTitleButton;
PlayingToTitleButton playingToTitleButton;
PlayingToPauseButton playingToPauseButton;
ToggleButton feedbackToggleButton;
ToggleButton gaugeToggleButton;
ToggleButton developModeToggleButton;
Slider bpmSlider;
Colors colors;
Gauge gauge;
JudgeField judgeField;
Feedback feedback;
Action nextExpected = Action.Down;
MillisMatchChecker timingSEChecker;
MillisMatchChecker justMillisChecker;
PApplet applet = this;

void setup() {
  //設定
  frameRate(60);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  //変数初期化
  woodImage = loadImage("images/wood.png");
  woodImage.resize(width, height);
  gearImage = loadImage("images/gear.png");
  goodImage = loadImage("images/carrot_good.png");
  niceImage = loadImage("images/carrot_nice.png");
  badImage = loadImage("images/carrot_bad.png");
  pauseImage = loadImage("images/pause_button.png");
  colors = new Colors();
  actionFromAndroid = Action.Other;
  action = Action.Other;
  actionPosition = new int[2];
  faciSettings = new JsonBuffer("facilitator_settings.json");
  timeManager = new TimeManager();
  currentScreen = ScreenType.Title;
  titleScreen = new TitleScreen();
  settingsScreen = new SettingsScreen();
  intervalScreen = new IntervalScreen();
  playingScreen = new PlayingScreen();
  pauseScreen = new PauseScreen();
  

  startButton = new StartButton();
  settingsButton = new SettingsButton();
  settingsToTitleButton = new SettingsToTitleButton();
  playingToTitleButton = new PlayingToTitleButton();
  playingToPauseButton = new PlayingToPauseButton();
  feedbackToggleButton = new ToggleButton(width/4, height/2, isActiveFeedback);
  gaugeToggleButton = new ToggleButton(width/2, height/2, isActiveGauge);
  developModeToggleButton = new ToggleButton(width*3/4, height/2, isDevelopMode);
  bpmSlider = new Slider(width/2, height*3/4, width*3/5, 0, 360, bpm);

  gauge = new Gauge();
  judgeField = new JudgeField();
  feedback = new Feedback();
  timingSEChecker = new MillisMatchChecker();
  justMillisChecker = new MillisMatchChecker();

  //インスタンス初期化
  goodSEPool = new SoundFile[5];
  niceSEPool = new SoundFile[5];
  badSEPool  = new SoundFile[10];
  hitSEPool  = new SoundFile[5];
  for (int i=0; i<10; i++) {
    if (i<5) {
      goodSEPool[i] = new SoundFile(applet, "SEs/slash_good.wav");
      niceSEPool[i] = new SoundFile(applet, "SEs/slash_nice.wav");
      badSEPool[i]  = new SoundFile(applet, "SEs/slash_bad.wav");
      hitSEPool[i]  = new SoundFile(applet, "SEs/hit.wav");
    }
    badSEPool[i]  = new SoundFile(applet, "SEs/slash_bad.wav");
  }
  timingSE = new SoundFile(applet, "SEs/timing.wav");
}

void draw() {
  switch(actionFromAndroid) {
  case Down:
    if (nextExpected == Action.Down) {
      action = actionFromAndroid;
      nextExpected = Action.Up;
    }
    break;
  case Up:
    if (nextExpected == Action.Up) {
      action = actionFromAndroid;
      nextExpected = Action.Down;
    }
    break;
  }

  switch(currentScreen) {
  case Title:
    titleScreen.run();
    break;
  case Settings:
    settingsScreen.run();
    break;
  case Interval:
    intervalScreen.run();
    break;
  case Playing:
    playingScreen.run();
    break;
  case Pause:
    pauseScreen.run();
    break;
  }
  timeManager.run();
  if (action!=Action.Other) {
    action = Action.Other;
    actionPosition[0] = INT_RESET_VALUE;
    actionPosition[1] = INT_RESET_VALUE;
  }
}
