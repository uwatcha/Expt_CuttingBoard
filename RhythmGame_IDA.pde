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
final color RING  = color(0, 167, 219);

//テキストサイズ定数
final int JUDGE_DISPLAY = 70;

//判定フレーム定数
final int GOOD_FRAME = 4;
final int NICE_FRAME = 8;
final int BAD_FRAME = 12;

//フレーム定数
final int FRAME_RATE = 120;
final int JUDGE_DISPLAY_DURATION = 30;

//グローバル変数
PImage noteImage;
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

//システム関係
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
  audioManager.playMusic();
}

void draw() {
  background(0);
  frame = frameCount-1;
  ////notesから現在のフレームで呼び出すノーツをrunningNotesに入れる。
  for (int i=noteLoadIndex; i<notes.length; i++) {
    if (frame == notes[i].getShowFrame()) {
      runningNotes.add(notes[i].create());
    } else if (frame < notes[i].getShowFrame()) { //新しくfor文がはじまったときに、runningNotesに追加すべきnoteのインデックスを記録している。こうすることで、notesを毎回先頭からチェックしなくて良くなる。
      noteLoadIndex = i;
      break;
    }
  }
  //runningNotesに表示期限を迎えたノーツがあれば削除する
  for (int i=0; i<runningNotes.size(); i++) {
    if (runningNotes.get(i).getKillFrame() < frame) {
      runningNotes.remove(runningNotes.get(i--));
      continue;
    } else {
      runningNotes.get(i).run();
    }
  }
  //audioManager.playMusic();
  println("最大メモリ: " + runtime.maxMemory() / 1024 / 1024 + " MB");
  println("割り当て済みメモリ: " + runtime.totalMemory() / 1024 / 1024 + " MB");
  println("空きメモリ: " + runtime.freeMemory() / 1024 / 1024 + " MB");
  println("使用中メモリ: " + (runtime.totalMemory() - runtime.freeMemory()) / 1024 / 1024 + " MB");
}
