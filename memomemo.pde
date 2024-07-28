/*
基本的に各オブジェクトの内部処理をするメソッドはprivateにする。
メソッドはrun()メソッドの中などで呼ばれ、run()をdraw()で呼べばそのオブジェクトが正常に動くようにする

ジャッジ仕様書
ノードが表示されている時にタッチすれば、Goodを表示
ノードが表示されていない時にタッチすればBadを表示
タッチしなければ何も表示しない

判定はしばらく表示し続ける

現在、NoteJudgeなどの判定は、テスト用に120bpmの曲を使用する前提で、roopingFrameCountを使用している場合などがある

音がガビガビになるエラーは、重くて処理が遅くなったために起こっている。

surfaceTouchEvent()はなくても動くが、なぜかこれが無いとしばしば音がガビガビになる

一度にノーツを200呼び出すとガビガビになった
100では大丈夫だった

テキストファイルから呼び出すノーツを読み込めるようにする

SoundFileのplay()は、一度だけ呼び出せば再生し続ける

NoteRunnerクラスのサイズ：約41,050Byte
NoteCreaterクラスのサイズ：約20Byte

soundEffectを同時に複数流すために、各NoteRunnerのインスタンスに音源ファイルを持たせているため、サイズ的には非効率。
SoundPoolを使えれば良いが、アプリ内ストレージRにファイルを配置する必要があり、おそらくAndroid Simulatorでのコーディングが必要。

効果音
https://soundeffect-lab.info/

poolにしたら時間経過でガビらなくなった
ガビりの原因はSoundFileの使用メモリの蓄積？

ノーツの大きさは400*400固定だから、デバイスの画面とノーツの比率を固定化する処理を追加した方がいい














































































*/
