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
import processing.sound.*;
import processing.core.PApplet;

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

//グローバル変数
PImage noteImage;
int frame;
int noteLoadIndex;
boolean isRunning;


//ノーツ呼び出し
final int NOTE_COUNT = 512;
NoteCreater[] notes;
ArrayList<NoteRunner> runningNotes;
ArrayList<PVector> vectors;
ArrayList<Integer> showFrames;
ArrayList<Integer> justFrames;

//音楽系オブジェクト
AudioManager audioManager;
SoundEffect testSE;
SoundFile good, nice, bad;

PApplet applet = this;
Runtime runtime = Runtime.getRuntime();

void setup() {
  //設定
  frameRate(FRAME_RATE);
  imageMode(CENTER);

  //変数初期化
  noteImage = loadImage("images/note.png");
  frame = 0;
  noteLoadIndex = 0;
  isRunning = true;

  //インスタンス初期化
  notes = new NoteCreater[NOTE_COUNT]; //実際に曲に合わせてノーツを配置するなら固定長だろうから、配列に入れる。要素がずれないからindexをidとしても使える
  runningNotes = new ArrayList<NoteRunner>();
  vectors = new ArrayList<PVector>();
  makeVectors();
  showFrames = new ArrayList<Integer>();
  justFrames = new ArrayList<Integer>();
  makeShowFrames();
  makeJustFrames();
  makeNotes();
  audioManager = new AudioManager();
  testSE = new SoundEffect();
}
// 各メーカーの動作チェック
void draw() {
  if (isRunning) {
    background(0);
    frame = frameCount-1;
    //notesから現在のフレームで呼び出すノーツをrunningNotesに入れる。
    for (int i=noteLoadIndex; i<notes.length; i++) {
      if (showFrames.get(i)==frame) {
        runningNotes.add(notes[i].create());
      } else if (showFrames.get(i) > frame) {
        noteLoadIndex = i;
        break;
      }
    }
    //runningNotesに表示期限を迎えたノーツがあれば削除する
    for (int i=0; i<runningNotes.size(); i++) {
      if (runningNotes.get(i).getKillFrame() < frame) {
        runningNotes.remove(runningNotes.get(i--));
        continue;
      }
      runningNotes.get(i).run();
    }
    audioManager.playMusic();
  } 
  println("最大メモリ: " + runtime.maxMemory() / 1024 / 1024 + " MB");
  println("割り当て済みメモリ: " + runtime.totalMemory() / 1024 / 1024 + " MB");
  println("空きメモリ: " + runtime.freeMemory() / 1024 / 1024 + " MB");
  println("使用中メモリ: " + (runtime.totalMemory() - runtime.freeMemory()) / 1024 / 1024 + " MB");
}
