//アンドロイド関係のライブラリ
import android.content.Intent;
import android.view.MotionEvent;
import android.os.Environment;
import android.os.Bundle;

//スマホ及びBluetooth関係のライブラリ
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.ui.*;

//音関係のライブラリ
import processing.sound.*;

//ファイル入出力関係のライブラリ
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.BufferedWriter;

//カラー定数
final color WHITE = color(255);
final color BLACK = color(0);
final color RED   = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE  = color(0, 0, 255);
final color RING  = color(0, 167, 219);

//テキストサイズ定数
final int JUDGE_DISPLAY = 70;

//判定フレーム定数
final int GOOD_FRAME = 4;
final int NICE_FRAME = 8;
final int BAD_FRAME = 12;

//フレーム定数(finalでないものもあるが、setup()で初期化しなくてはならないため、finalをつけられない。値を変更しないように注意←)
final int FRAME_RATE = 120;
final int JUDGE_DISPLAY_DURATION = 30;
final int START_FRAME_0 = 0;
int ROOP_FRAME;
int JUST_FRAME_0;
int KILL_FRAME_0;

//グローバル変数
PImage noteImage;
int roopingFrameCount;
boolean isTouch, isTouchDown, isTouchUp, isPointerTouchDown, isPointerTouchUp;
//オブジェクト
ArrayList<NoteRunner> notes;
PVector[] vectors;

//テスト用
NoteRunner note;

//setup()
void setup() {
  //設定
  frameRate(FRAME_RATE);
  imageMode(CENTER);
  //定数初期化
  ROOP_FRAME = (int)(FRAME_RATE*1.5);
  JUST_FRAME_0 = ROOP_FRAME/2;
  KILL_FRAME_0 = JUST_FRAME_0+BAD_FRAME+JUDGE_DISPLAY_DURATION;
  //変数初期化
  noteImage = loadImage("note.png");
  roopingFrameCount = 0;
  //インスタンス初期化
  vectors = new PVector[4];
  vectors[0] = new PVector(width/4, height/4);
  vectors[1] = new PVector(width*3/4, height/4);
  vectors[2] = new PVector(width/4, height*3/4);
  vectors[3] = new PVector(width*3/4, height*3/4);
}

void draw() {
  background(0);
  roopingFrameCount = (frameCount-1)%ROOP_FRAME;
  if (roopingFrameCount == START_FRAME_0) {
    note = new NoteRunner(new PVector(width/2, height/2), JUST_FRAME_0);
  }
  if (roopingFrameCount == KILL_FRAME_0) {
    note = null;
  }
  if (note != null) {
    note.run();
  }
}
