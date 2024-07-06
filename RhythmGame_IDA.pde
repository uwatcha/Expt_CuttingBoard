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

void setup() {
  //設定
  frameRate(120);
  //ROOP_FRAME = (int)frameRate*4;
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
  roopingFrameCount = (frameCount-1)%180;
  if (roopingFrameCount == 0) {
    println("ゼロ");
    note = new NoteRunner(new PVector(width/2, height/2), 60);
  }
  if (roopingFrameCount == 60) {
    println("ジャスト");
  }
  if (roopingFrameCount == 120) {
    println("イチニゼロ");
    note = null;
  }
  if (note != null) {
    note.run();
  }
}
