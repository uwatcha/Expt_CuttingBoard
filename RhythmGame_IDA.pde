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

//フレーム定数
int FRAME_RATE = 120;
int ROOP_FRAME;

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
  ROOP_FRAME = (int)(FRAME_RATE*1.5);
  imageMode(CENTER);
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
  if (roopingFrameCount == 0) {
    //println("ゼロ");
    note = new NoteRunner(new PVector(width/2, height/2), ROOP_FRAME/2);
  }
  if (roopingFrameCount == ROOP_FRAME/2) {
    //println("ジャスト");
    textDisplay("ジャスト", new PVector(width/2, height/4), JUDGE_DISPLAY*2, WHITE);
  }
  if (roopingFrameCount == ROOP_FRAME*2/3) {
    //println("イチニゼロ");
    note = null;
  }
  if (note != null) {
    note.run();
  }
}
