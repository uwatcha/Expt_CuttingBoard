//TODO: 各判定の猶予時間を古い実験ソフトと揃える
//TODO: 開発者メニューで、デバッグモードをオンにすると、ログファイルの出力先を変える
//アンドロイド関係のライブラリ
import android.content.Intent;
import android.view.MotionEvent;
import android.os.Environment;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;

//スマホ及びBluetooth関係のライブラリ
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.ui.*;

//音関係のライブラリ
import processing.sound.SoundFile;
//SoundFileコンストラクタの引数にPApplet変数を入れるため
import processing.core.PApplet;

//ファイル入出力関係のライブラリ
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.BufferedWriter;

import java.util.LinkedList;

//Java関係のライブラリ

//カラー定数
final color WHITE = color(255);
final color BLACK = color(0);
final color LIGHT_GREY  = color(150);
final color DARK_GREY = color(80);
final color CLEAR_GREY = color(150, 150, 150, 50);
final color RING  = color(0, 167, 219);
final color LINE  = color(0, 167, 219);
final color LIGHT_BLUE = color(139, 220, 232);
final color LIGHT_GREEN = color(127, 255, 212);

//サイズ定数
//150: [Device: samsung]で、大文字のSの縦幅が1cm
final int STROKE_DEFAULT = 2;

//TODO: 調整する
//判定フレーム定数
final int GOOD_FRAME = 8;
final int NICE_FRAME = 16;
final int BAD_FRAME = 20;

//フレーム定数
final int FRAME_RATE = 60;
final int JUDGE_DISPLAY_DURATION = 30;
final int TOUCH_INTERVAL = (int)sec(2);
final int NOTICE_INTERVAL = TOUCH_INTERVAL/2;
final int SOUND_LAG_BUFFER = (int)sec(0.05);
final int START_INTERVAL = (int)sec(1);

//JSON キー
final String isActiveFeedback = "is_active_feedback";
final String isActiveGauge = "is_active_gauge";

//パス
String EXPORT_PATH;
String TOUCH_EXPORT_PATH;
String ACTION_EXPORT_PATH;
String GENERAL_EXPORT_PATH;

//CSVフィールド
final String TOUCH_TIMING = "TouchTiming";
final String CORRECT_TIMING = "CorrectTiming";
final String TOUCH_POSITION_X = "TouchPositinoX";
final String TOUCH_POSITION_Y = "TouchPositinoY";

final String JUDGMENT = "Judgment";
final String TIMING_DIFF = "TouchDiff";

final String ACTION = "Action";

final String[] TOUCH_TABLE_FIELDS = {TOUCH_TIMING, CORRECT_TIMING, TIMING_DIFF, JUDGMENT, TOUCH_POSITION_X, TOUCH_POSITION_Y};
final String[] ACTION_TABLE_FIELDS = {ACTION, TOUCH_TIMING, CORRECT_TIMING, TOUCH_POSITION_X, TOUCH_POSITION_Y};
final String[] GENERAL_TABLE_FIELDS = {ACTION, TOUCH_TIMING, CORRECT_TIMING, TIMING_DIFF, JUDGMENT, TOUCH_POSITION_X, TOUCH_POSITION_Y};

//JudgeField出力ArrayList
final int JUST_FRAME_INDEX = 0;
final int TIMING_DIFF_INDEX = 1;
final int JUDGMENT_INDEX = 2;
final int POSITION_X_INDEX = 3;
final int POSITION_Y_INDEX = 4;

//その他定数
HashMap<String, String> BUTTON_TITLES;
final int FIELD_RESET_VALUE = Integer.MAX_VALUE;


//グローバル変数
int playingFrame;
int playStartFrame;
int loopFrame;
boolean isRunning;
int actionIdFromAndroid = FIELD_RESET_VALUE;
int actionID;
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
Screen screen;

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

//その他オブジェクト
Gauge gauge;
JudgeField judgeField;
Feedback feedback;
Action nextExpected = Action.Down;

//システム関係
PApplet applet = this;

void setup() {

  //設定
  //なぜかframeRateを変更できない。FRAME_RATEを60というデフォルトにしておく。
  frameRate(120);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  //定数初期化
  BUTTON_TITLES = new HashMap<String, String>();
  BUTTON_TITLES.put(isActiveFeedback, "フィードバック");
  BUTTON_TITLES.put(isActiveGauge, "ゲージ");
  EXPORT_PATH = getActivity().getExternalFilesDir("").getPath();
  TOUCH_EXPORT_PATH = EXPORT_PATH+File.separator+"touch"+File.separator+getTime()+"_touch.csv";
  ACTION_EXPORT_PATH = EXPORT_PATH+File.separator+"action"+File.separator+getTime()+"_action.csv";
  GENERAL_EXPORT_PATH = EXPORT_PATH+File.separator+"general"+File.separator+getTime()+"_general.csv";

  //変数初期化
  woodImage = loadImage("images/wood.png");
  woodImage.resize(width, height);
  gearImage = loadImage("images/gear.png");
  goodImage = loadImage("images/carrot_good.png");
  niceImage = loadImage("images/carrot_nice.png");
  badImage = loadImage("images/carrot_bad.png");
  pauseImage = loadImage("images/pause_button.png");
  playingFrame = 0;
  loopFrame = 0;
  noteLoadIndex = 0;
  actionID = FIELD_RESET_VALUE;
  actionPosition = new float[2];
  screen = Screen.Title;
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
  gauge = new Gauge();
  judgeField = new JudgeField();
  feedback = new Feedback();

  //インスタンス初期化
  goodSEPool = new SoundFile[5];
  niceSEPool = new SoundFile[5];
  badSEPool  = new SoundFile[5];
  hitSEPool  = new SoundFile[5];
  for (int i=0; i<5; i++) {
    goodSEPool[i] = new SoundFile(applet, "SEs/slash_good.wav");
    niceSEPool[i] = new SoundFile(applet, "SEs/slash_nice.wav");
    badSEPool[i]  = new SoundFile(applet, "SEs/slash_bad.wav");
    hitSEPool[i]  = new SoundFile(applet, "SEs/hit.wav");
  }
  timingSE = new SoundFile(applet, "SEs/timing.wav");
}

void draw() {
  switch(actionIdFromAndroid) {
    case MotionEvent.ACTION_DOWN:
      if (nextExpected == Action.Down) {
        actionID = actionIdFromAndroid;
        nextExpected = Action.Up;
      }
      break;
    case MotionEvent.ACTION_UP:
      if (nextExpected == Action.Up) {
        actionID = actionIdFromAndroid;
        nextExpected = Action.Down;
      }
      break;
    default:
      actionID = FIELD_RESET_VALUE;
      actionPosition[0] = FIELD_RESET_VALUE;
      actionPosition[1] = FIELD_RESET_VALUE;
  }
  if (actionID==MotionEvent.ACTION_DOWN) {
    println("actionID: 0");
  }
  if (actionID==MotionEvent.ACTION_UP) {
    println("actionID: 1");
  }
  switch(screen) {
  case Title:
    titleScreen();
    break;
  case Settings:
    settingsScreen();
    break;
  case Playing:
    playingScreen();
    break;
  }
  appHaltButton();
  if (actionID==MotionEvent.ACTION_DOWN || actionID==MotionEvent.ACTION_UP) {
    actionID = FIELD_RESET_VALUE;
    actionPosition[0] = FIELD_RESET_VALUE;
    actionPosition[1] = FIELD_RESET_VALUE;
  }
}
