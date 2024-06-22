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
AudioManager audioManager;
Note note;
JudgeDisplay judgeDisplay;

//SoundFile music;

void setup() {
  //設定
  frameRate(60);
  imageMode(CENTER);
  //初期化
  noteImage = loadImage("note.png");
  frame = 0;
  audioManager = new AudioManager(this);
  note = new Note(width/2, height/2, noteImage);
  judgeDisplay = new JudgeDisplay();
  
  //music = new SoundFile(this, "musics/KaeruNoPiano.mp3");
}

void draw() {
  background(0);
  frame = (int)((frame+1)%frameRate);
  audioManager.playMusic();
  note.run();
  judgeDisplay.run(note);
  //if (!music.isPlaying()) {
  //  music.play();
  //}
}
