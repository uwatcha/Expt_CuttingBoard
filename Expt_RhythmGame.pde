//TODO: 開発者メニューで、デバッグモードをオンにすると、ログファイルの出力先を変える。本来のログファイルを保存するフォルダを散らかさないため

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
import java.util.Map;
import java.util.Collections;

//カラー定数
final color WHITE = color(255);
final color BLACK = color(0);
final color LIGHT_GREY  = color(150);
final color DARK_GREY = color(80);
final color CLEAR_GREY = color(150, 150, 150, 50);
final color LIGHT_BLUE = color(139, 220, 232);
final color LIGHT_GREEN = color(127, 255, 212);

//サイズ定数
//150: [Device: samsung]で、大文字のSの縦幅が1cm
final int STROKE_DEFAULT = 2;

//判定フレーム定数
final int GOOD_MILLIS = framesToMillis(6);
final int NICE_MILLIS = framesToMillis(12);

//フレーム定数
final int FRAME_RATE = 60;
final int JUDGE_DISPLAY_DURATION = 30;

//JSON キー
final String isActiveFeedback = "is_active_feedback";
final String isActiveGauge = "is_active_gauge";
final String bpm = "bpm";

//JudgeField出力ArrayList
final int JUST_MILLIS_INDEX = 0;
final int TIMING_DIFF_INDEX = 1;
final int JUDGMENT_INDEX = 2;
final int POSITION_X_INDEX = 3;
final int POSITION_Y_INDEX = 4;

//その他定数
final HashMap<String, String> UI_TITLES = new HashMap<String, String>() {
  {
    put(isActiveFeedback, "フィードバック");
    put(isActiveGauge, "ゲージ");
    put(bpm, "BPM");
  }
};

final int FIELD_RESET_VALUE = Integer.MAX_VALUE;


//グローバル変数
int intervalStartMillis;
int playStartMillis;
int touchIntervalMillis;
boolean isRunning;
Action actionFromAndroid;
Action action;
float[] actionPosition;

//ノーツ関係
final int NOTE_COUNT = 512;
int noteLoadIndex;

//画像系オブジェクト
PImage woodImage;
PImage gearImage;
PImage goodImage;
PImage niceImage;
PImage badImage;
PImage pauseImage;

//音楽系オブジェクト
SoundFile[] goodSEPool;
SoundFile[] niceSEPool;
SoundFile[] badSEPool;
SoundFile[] hitSEPool;
SoundFile timingSE;

//フラグ
ScreenType currentScreen;
boolean isContinueWriting = false;

//スクリーン
TitleScreen titleScreen = new TitleScreen();
SettingsScreen settingsScreen = new SettingsScreen();
PlayingScreen playingScreen = new PlayingScreen();
PauseScreen pauseScreen = new PauseScreen();

//入出力オブジェクト
JsonBuffer faciSettings;
JsonBuffer devConfig;
GeneralCSV generalCSV;
TouchCSV touchCSV;
ActionCSV actionCSV;

//ボタンオブジェクト
StartButton startButton;
SettingsButton settingsButton;
SettingsToTitleButton settingsToTitleButton;
PlayingToTitleButton playingToTitleButton;
ToggleButton feedbackToggleButton;
ToggleButton gaugeToggleButton;

//スライダーオブジェクト
Slider bpmSlider;

//その他オブジェクト
Gauge gauge;
JudgeField judgeField;
Feedback feedback;
Action nextExpected = Action.Down;
MillisMatchChecker timingSEChecker;
MillisMatchChecker justMillisChecker;

//システム関係
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
  noteLoadIndex = 0;
  intervalStartMillis = FIELD_RESET_VALUE;
  playStartMillis = FIELD_RESET_VALUE;
  actionFromAndroid = Action.Other;
  action = Action.Other;
  actionPosition = new float[2];
  currentScreen = ScreenType.Title;
  titleScreen = new TitleScreen();
  settingsScreen = new SettingsScreen();
  playingScreen = new PlayingScreen();
  pauseScreen = new PauseScreen();
  faciSettings = new JsonBuffer("facilitator_settings.json");
  devConfig = new JsonBuffer("developer_config.json");
  generalCSV = new GeneralCSV();
  touchCSV = new TouchCSV();
  actionCSV = new ActionCSV();
  startButton = new StartButton();
  settingsButton = new SettingsButton();
  settingsToTitleButton = new SettingsToTitleButton();
  playingToTitleButton = new PlayingToTitleButton();
  feedbackToggleButton = new ToggleButton(width*2/5, height/2, isActiveFeedback);
  gaugeToggleButton = new ToggleButton(width*3/5, height/2, isActiveGauge);
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
  for (int i=0; i<5; i++) {
    goodSEPool[i] = new SoundFile(applet, "SEs/slash_good.wav");
    niceSEPool[i] = new SoundFile(applet, "SEs/slash_nice.wav");
    badSEPool[i]  = new SoundFile(applet, "SEs/slash_bad.wav");
    hitSEPool[i]  = new SoundFile(applet, "SEs/hit.wav");
  }
  for (int i=5; i<10; i++) {
    badSEPool[i]  = new SoundFile(applet, "SEs/slash_bad.wav");
  }
  timingSE = new SoundFile(applet, "SEs/timing.wav");
}

//TODO: 無印とPOINTERのcase内の処理を関数化し、dryを守る
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
  default:
    action = Action.Other;
    actionPosition[0] = FIELD_RESET_VALUE;
    actionPosition[1] = FIELD_RESET_VALUE;
  }

  switch(currentScreen) {
  case Title:
    titleScreen.run();
    break;
  case Settings:
    settingsScreen.run();
    break;
  case Playing:
    playingScreen.run();
    break;
  case Pause:
    pauseScreen.run();
    break;
  }
  if (action!=Action.Other) {
    action = Action.Other;
    actionPosition[0] = FIELD_RESET_VALUE;
    actionPosition[1] = FIELD_RESET_VALUE;
  }
}
