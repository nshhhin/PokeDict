
// ウェブコンテンツ最終課題
// 2620130546 新納 真次郎

import de.bezier.data.sql.*;
SQLite db;

String lines[];
String select_type = "選択なし";
Button buttons[] = new Button[6];
boolean load=false;

void setup() {
  size(640, 480);
  background(255);
  configreButtons();
  db = new SQLite( this, "mydata.db" );

  fill(255);
  strokeWeight(1);
  rect(1, height-100, 98, 98);
  rect(101, height-100, 98, 98);
  rect(210, 1, 425, height-2);
  int count=0;
  if ( db.connect() ) {
    String sql2="SELECT id,name FROM pokemon_table";
    db.query(sql2);
    while (db.next ()) {
      fill(0);
      text(db.getInt("id")+" . "+db.getString("name"), 220, 20+count*20);
      count++;
    }
  }
}

void draw() {
  println(select_type);
  fill(255);
  noStroke();
  rect(0, 0, 210, height);

  stroke(0);
  fill(255, 180, 180);
  rect(1, 1, 200, 20);
  fill(0);

  textAlign(CENTER, CENTER);
  text("タイプを選択", 201/2, 21/2);
  textAlign(BASELINE);

  for (Button button : buttons) {
    button.draw();

    if (button.on) {

      //白rectで上書き
      fill(255);
      strokeWeight(1);
      rect(210, 1, 425, height-2);

      float red = red(button.c);
      float green = green(button.c);
      float blue = blue(button.c);
      button.c = color(red, green, blue, 255);
      select_type = button.text; 

      db = new SQLite( this, "mydata.db" );
      int count=0;
      if ( db.connect() ) {
        String sql="";
        if (select_type.equals("選択なし")) {
          sql="SELECT id,name FROM pokemon_table";
        } else {
          sql="SELECT id,name FROM pokemon_table where type1='"+select_type+"' or type2='"+select_type+"'";
        }
        db.query(sql);
        while (db.next ()) {
          fill(0);
          text(db.getInt("id")+" . "+db.getString("name"), 220, 20+count*20);
          count++;
        }
        button.on=false;
      }
    } else if (!button.on) {
      float red = red(button.c);
      float green = green(button.c);
      float blue = blue(button.c);
      button.c = color(red, green, blue, 100);
    }
  }
}

void configreButtons() {
  buttons[0]=new Button(20, 30, 80, 80, color(255, 0, 0, 20), 0, "ほのお");
  buttons[1]=new Button(110, 30, 80, 80, color(0, 0, 255, 20), 0, "みず");
  buttons[2]=new Button(20, 120, 80, 80, color(0, 255, 0, 20), 0, "くさ");
  buttons[3]=new Button(110, 120, 80, 80, color(255, 2550, 0, 20), 0, "でんき");
  buttons[4]=new Button(20, 210, 80, 80, color(130, 20), 0, "ノーマル");
  buttons[5]=new Button(110, 210, 80, 80, color(255, 20), 0, "選択なし");
}
