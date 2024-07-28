//アンドロイド関係のライブラリ
import android.content.Intent;
import android.content.Context;
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

import java.util.LinkedList;


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
LinkedList<NoteRunner> runningNotes;

//音楽系オブジェクト
AudioManager audioManager;
SoundFile good, nice, bad;
SoundFile[] goodSEPool;
SoundFile[] niceSEPool;
SoundFile[] badSEPool;



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
  noteSetup();
}
// 各メーカーの動作チェック
void draw() {
  if (isRunning) {
    background(0);
    frame = frameCount-1;
    //println("runningNotes.size(): "+runningNotes.size());
    ////notesから現在のフレームで呼び出すノーツをrunningNotesに入れる。
    for (int i=noteLoadIndex; i<notes.length; i++) {
      if (frame == notes[i].getShowFrame()) {
        runningNotes.add(notes[i].create());
        //println("runningNotes.add()");
      } else if (frame < notes[i].getShowFrame()) { //新しくfor文がはじまったときに、runningNotesに追加すべきnoteのインデックスを記録している。こうすることで、notesを毎回先頭からチェックしなくて良くなる。
        //println("noteLoadIndex update");
        //println("notes[i].getShowFrame(): "+ notes[i].getShowFrame());
        //println("frame: "+frame);
        noteLoadIndex = i;
        break;
      }
    }
    //runningNotesに表示期限を迎えたノーツがあれば削除する
    for (int i=0; i<runningNotes.size(); i++) {
      if (runningNotes.get(i).getKillFrame() < frame) {
        //println("runningNotes.remove()");
        runningNotes.remove(runningNotes.get(i--));
        continue;
      } else {
        //println("runningNotes.run()");
        runningNotes.get(i).run();
      }
    }
    audioManager.playMusic();
  } 
  //println("最大メモリ: " + runtime.maxMemory() / 1024 / 1024 + " MB");
  //println("割り当て済みメモリ: " + runtime.totalMemory() / 1024 / 1024 + " MB");
  //println("空きメモリ: " + runtime.freeMemory() / 1024 / 1024 + " MB");
  //println("使用中メモリ: " + (runtime.totalMemory() - runtime.freeMemory()) / 1024 / 1024 + " MB");
}
