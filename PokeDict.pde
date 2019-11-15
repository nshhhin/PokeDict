
// ウェブコンテンツ最終課題
// 2620130546 新納 真次郎

import de.bezier.data.sql.*;
SQLite db;

String lines[];
String select_type="選択なし";
Button b[];


void setup() {
  size(640, 480);
  background(255);
  b = new Button[6];
  // importB=new Button(1, 1, 200, 20, color(255, 180, 180), 0, "データベース化");
  b[0]=new Button(20, 30, 80, 80, color(255, 0, 0, 20), 0, "ほのお");
  b[1]=new Button(110, 30, 80, 80, color(0, 0, 255, 20), 0, "みず");
  b[2]=new Button(20, 120, 80, 80, color(0, 255, 0, 20), 0, "くさ");
  b[3]=new Button(110, 120, 80, 80, color(255, 2550, 0, 20), 0, "でんき");
  b[4]=new Button(20, 210, 80, 80, color(130, 20), 0, "ノーマル");
  b[5]=new Button(110, 210, 80, 80, color(255, 20), 0, "選択なし");

  db = new SQLite( this, "mydata.db" );

 

  /* //インポートする時に使ったコード 
   String line[]=loadStrings("pokemon.html");
   int count=0;
   lines=new String[0];
   for (int i=0; i<line.length; i++) {
   // println(line[i]);
   String []m=match(line[i], "<td class=\"col_number\">(.*?)</td>.*<a href=\"http\\://www.pokemon\\-tools.com/bw/ja/pokemon/\\d{3}/\">(.{1,6})</a>.*<td class=\"col_type\">(.*?)</td>");
   if (m != null) {
   println(m[1]);
   println(m[2]);
   
   String []type1=match(m[3], "<a href.*?>(.*?)</a>");
   String []type2=match(m[3], "<br><a href.*?>(.*?)</a>");
   
   
   if(type2 == null){
   lines=append(lines,m[1]+","+m[2]+","+type1[1]+","+null);
   }
   else if(type2 != null){
   lines=append(lines, m[1]+","+m[2]+","+type1[1]+","+type2[1]);
   }
   
   count++;
   }
   }
   saveStrings("data.csv", lines);
   String hoge[]=loadStrings("data.csv");
   if ( db.connect() ) {
   for (int i=0; i<hoge.length; i++) {
   String []hogehoge=split(hoge[i], ",");
   String id=hogehoge[0];
   String name=hogehoge[1];
   String type1=hogehoge[2];
   String type2=hogehoge[3];
   String sql="INSERT INTO pokemon_table VALUES("+id+",'"+name+"','"+type1+"','"+type2+"')";
   db.query(sql);
   }
   }
   
   */
   
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


boolean load=false;
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

  for (int i=0; i<b.length; i++) {
    b[i].draw();
    if (b[i].on) {

      //白rectで上書き
      fill(255);
      strokeWeight(1);
      rect(210, 1, 425, height-2);

      float red=red(b[i].c);
      float green=green(b[i].c);
      float blue=blue(b[i].c);
      b[i].c=color(red, green, blue, 255);
      select_type=b[i].text; 


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
        b[i].on=false;
      }
    } else if (!b[i].on) {
      float red=red(b[i].c);
      float green=green(b[i].c);
      float blue=blue(b[i].c);
      b[i].c=color(red, green, blue, 100);
    }
  }
}

