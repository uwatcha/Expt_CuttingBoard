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


//グローバル変数
PImage noteImage;
int frame;
boolean isTouch, isTouchDown, isTouchUp, isPointerTouchDown, isPointerTouchUp;
//オブジェクト
Note note;
JudgeDisplay judgeDisplay;

void setup() {
  //設定
  frameRate(60);
  imageMode(CENTER);
  //初期化
  noteImage = loadImage("note.png");
  frame = 0;
  note = new Note(width/2, height/2, noteImage);
  judgeDisplay = new JudgeDisplay();
}

void draw() {
  background(0);
  frame++;
  note.display();
  judgeDisplay.display(note);
}
