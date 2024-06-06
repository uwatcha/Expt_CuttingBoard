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

//from cuttingBoard_m5_with_sound-------
ArrayList points;
PVector point;
int pId, pIndex;
int count;
int actionID, actionMASK;
boolean touch, touch_down, touch_up, touch_pdown, touch_pup;
//--------------------------------------


PImage noteImage;
int frame;
Note note;

void setup() {
  //設定
  frameRate(60);
  imageMode(CENTER);
  //初期化
  noteImage = loadImage("note.png");
  frame = 0;
  note = new Note(width/2, height/2, noteImage);
  points = new ArrayList();
}

void draw() {
  //初期化
  touch = false;
  touch_down = false;
  touch_up = false;
  touch_pdown = false;
  touch_pup = false;
  background(0);
  frame++;
  note.display();
}
