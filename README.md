# MachiKania-OTHELLO
MachiKania type Pで動作するオセロゲーム。<BR>
<img width="900" height="675" alt="image" src="https://github.com/user-attachments/assets/4d771ada-28d0-4a23-9fb9-8fae62140608" />
<BR>
・操作方法<BR>
【ゲーム開始前】<BR>
LCD画面をタッチ：液晶補正を行う。<BR>
十字ボタン：格子の数を変える。上/右 増やす、下/左 減らす。<BR>
FIREボタン：先行(Black)/後行(White)を選ぶ。<BR>
STARTボタン：ゲーム開始。<BR>
【ゲーム開始後】<BR>
LCD画面をタッチ：ディスクの置き場所を指定する。<BR>
FIREボタン：スキップ。<BR>
<BR>
･内部構造の説明<BR>
配列Pは､(0～N+1) x (0～N+1) のマトリックスになっているが、タッチペンで指定できる範囲は、0～Nの範囲で周囲の1升は常に0になっている。これは周囲にディスクがあるかどうかを判定する処理を簡略化するための工夫。
