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

//Java関係のライブラリ
//LinkedListは要素の追加、削除が得意で、要素に対してランダムなアクセスをしない時に使える
import java.util.LinkedList;

//カラー定数
final color WHITE = color(255);
final color BLACK = color(0);
final color LIGHT_GREY  = color(150);
final color DARK_GREY = color(80);
final color CLEAR_GREY = color(150, 150, 150, 50);
final color RING  = color(0, 167, 219);
final color LINE  = color(0, 167, 219);

//位置定数
PVector GAUGE_COORD;

//サイズ定数
final int JUDGE_TEXT_SIZE = 70;
final int BUTTON_TEXT_SIZE = 80;
final float STANDARD_LINE_STROKE = 12;
final float GAUGE_SIZE = 200;
final float STROKE_DEFAULT = 1;

//判定フレーム定数
final int GOOD_FRAME = 8;
final int NICE_FRAME = 16;
final int BAD_FRAME = 20;

//フレーム定数
final int FRAME_RATE = 60;
final int JUDGE_DISPLAY_DURATION = 30;
final int TOUCH_INTERVAL = (int)sec(1.5);
final int NOTICE_INTERVAL = TOUCH_INTERVAL/2;
final int SOUND_LAG_BUFFER = (int)sec(0.05);

//座標定数
int INITIAL_LINE_X;
int STANDARD_LINE_X;
int UPPER_NOTE_Y;
int LOWER_NOTE_Y;

//JSON キー
final String isActiveFeedback = "is_active_feedback";

//グローバル変数
int frame;
int loopFrame;
boolean isRunning;

//ノーツ関係
final int NOTE_COUNT = 512;
int noteLoadIndex;
//LinkedList<NoteRunner> runningNotes;

//画像系オブジェクト
PImage woodImage;
PImage goodImage;
PImage niceImage;
PImage badImage;

//音楽系オブジェクト
SoundFile[] goodSEPool;
SoundFile[] niceSEPool;
SoundFile[] badSEPool;
SoundFile timingSE;

//フラグ
Screen screen;

//入出力オブジェクト
FileBuffer faciSettingJSON;
FileBuffer devConfigJSON;

//その他オブジェクト
Gauge gauge;
JudgeField judgeField;
JudgeOutput judgeOutput;

//システム関係
PApplet applet = this;
Runtime runtime = Runtime.getRuntime();


void setup() {

  //設定
  //なぜかframeRateを変更できない。FRAME_RATEを60というデフォルトにしておく。
  frameRate(FRAME_RATE);
  imageMode(CENTER);

  //定数初期化
  GAUGE_COORD = new PVector(width*3/4, height/5);

  //変数初期化
  woodImage = loadImage("images/wood.png");
  woodImage.resize(width, height);
  goodImage = loadImage("images/goodCarrot.png");
  niceImage = loadImage("images/niceCarrot.png");
  badImage = loadImage("images/badCarrot.png");
  frame = 0;
  loopFrame = 0;
  noteLoadIndex = 0;
  isRunning = true;
  STANDARD_LINE_X = width*3/4;
  INITIAL_LINE_X = width/8;
  UPPER_NOTE_Y = height/4;
  LOWER_NOTE_Y = height*3/4;
  screen = Screen.ModeChange;
  faciSettingJSON = new FileBuffer("files/facilitator_settings.json");
  devConfigJSON = new FileBuffer("files/developer_config.json");
  gauge = new Gauge();
  judgeField = new JudgeField();
  judgeOutput = new JudgeOutput();

  //インスタンス初期化
  //noteSetup();
  //runningNotes = new LinkedList<NoteRunner>();
  goodSEPool = new SoundFile[5];
  niceSEPool = new SoundFile[5];
  badSEPool  = new SoundFile[5];
  for (int i=0; i<5; i++) {
    goodSEPool[i] = new SoundFile(applet, "SEs/goodCutting.wav");
    niceSEPool[i] = new SoundFile(applet, "SEs/niceCutting.wav");
    badSEPool[i]  = new SoundFile(applet, "SEs/badCutting.wav");
  }
  timingSE = new SoundFile(applet, "SEs/timing.wav");
}

void draw() {
  playingScreen();
}
