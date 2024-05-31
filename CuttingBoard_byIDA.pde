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
}

void draw() {
  background(222, 184, 135);
  frame++;
  note.display();
}
