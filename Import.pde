
void importDB() {
  
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


      if (type2 == null) {
        lines=append(lines, m[1]+","+m[2]+","+type1[1]+","+null);
      } else if (type2 != null) {
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
}
