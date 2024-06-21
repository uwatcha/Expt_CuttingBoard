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
final color RED   = color(255,0,0);
final color GREEN = color(0,255,0);
final color BLUE  = color(0,0,255);

//テキストサイズ定数
final int JUDGE_DISPLAY = 70;

//グローバル変数
PImage noteImage;
int frame;
boolean isTouch, isTouchDown, isTouchUp, isPointerTouchDown, isPointerTouchUp;
//オブジェクト
Note[] notes;
JudgeDisplay[] judgeDisplays;

void setup() {
  //設定
  frameRate(60);
  imageMode(CENTER);
  //変数初期化
  noteImage = loadImage("note.png");
  frame = 0;
  //インスタンス初期化
  notes = new Note[4];
  notes[0] = new Note(width/4, height/4, noteImage);
  notes[1] = new Note(width*3/4, height/4, noteImage);
  notes[2] = new Note(width/4, height*3/4, noteImage);
  notes[3] = new Note(width*3/4, height*3/4, noteImage);
  judgeDisplays = new JudgeDisplay[4];
  for (int i=0; i<4; i++) {
    judgeDisplays[i] = new JudgeDisplay(notes[i]);
  }
}

void draw() {
  background(0);
  frame = (int)((frame+1)%frameRate);
  for (int i=0; i<4; i++) {
    notes[i].run();
    judgeDisplays[i].run();
  }
}
