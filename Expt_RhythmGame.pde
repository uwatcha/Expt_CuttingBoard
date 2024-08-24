//アンドロイド関係のライブラリ
import android.content.Intent;
//import android.content.Context;
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
final color GREY  = color(150);
final color RING  = color(0, 167, 219);
final color LINE  = color(0, 167, 219);

//サイズ定数
final int JUDGE_TEXT_SIZE = 70;
final int BUTTON_TEXT_SIZE = 80;
final float STANDARD_LINE_STROKE = 12;

//判定フレーム定数
final int GOOD_FRAME = 4;
final int NICE_FRAME = 8;
final int BAD_FRAME = 12;

//フレーム定数
final int FRAME_RATE = 120;
final int JUDGE_DISPLAY_DURATION = 30;

//座標定数
int INITIAL_LINE_X;
int STANDARD_LINE_X;
int UPPER_NOTE_Y;
int LOWER_NOTE_Y;

//JSON キー
final String isActiveFeedback = "is_active_feedback";

//グローバル変数
PImage noteImage;
PImage woodImage;
int frame;
boolean isRunning;



//ノーツ関係
final int NOTE_COUNT = 512;
int noteLoadIndex;
NoteCreater[] notes;
LinkedList<NoteRunner> runningNotes;

//音楽系オブジェクト
AudioManager audioManager;
SoundFile[] goodSEPool;
SoundFile[] niceSEPool;
SoundFile[] badSEPool;

//フラグ
Screen screen;

//入出力オブジェクト
FileBuffer faciSettingJSON;
FileBuffer devConfigJSON;

//システム関係
PApplet applet = this;
Runtime runtime = Runtime.getRuntime();


void setup() {
  //設定
  frameRate(FRAME_RATE);
  imageMode(CENTER);

  //変数初期化
  noteImage = loadImage("images/note.png");
  woodImage = loadImage("images/wood.webp");
  frame = 0;
  noteLoadIndex = 0;
  isRunning = true;
  STANDARD_LINE_X = width*3/4;
  INITIAL_LINE_X = width/8;
  UPPER_NOTE_Y = height/4;
  LOWER_NOTE_Y = height*3/4;
  screen = Screen.ModeChange;
  faciSettingJSON = new FileBuffer("data/files/facilitator_settings.json");
  devConfigJSON = new FileBuffer("data/files/developer_config.json");

  //インスタンス初期化
  notes = new NoteCreater[NOTE_COUNT]; //実際に曲に合わせてノーツを配置するなら固定長だろうから、配列に入れる。要素がずれないからindexをidとしても使える
  noteSetup();
  runningNotes = new LinkedList<NoteRunner>();
  audioManager = new AudioManager();
  goodSEPool = new SoundFile[5];
  niceSEPool = new SoundFile[5];
  badSEPool  = new SoundFile[5];
  for (int i=0; i<5; i++) {
    goodSEPool[i] = new SoundFile(applet, "SEs/good.mp3");
    niceSEPool[i] = new SoundFile(applet, "SEs/nice.mp3");
    badSEPool[i]  = new SoundFile(applet, "SEs/bad.mp3");
  }
}

void draw() {
  playingScreen();
}
