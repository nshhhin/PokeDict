class Button {
  int x;
  int y;
  int w;
  int h;
  color c;
  int style; //0は四角型　1は円型
  String text;
  boolean on;

  Button(int _x, int _y, int _w, int _h, int _c, int _style, String _text) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    c=color(255, 0, 0);
    c=_c;
    style=_style;
    text=_text;
    on=false;
  }

  void draw() {
    textAlign(CENTER, CENTER);

    fill(c);
    if (style==0) {
      rect(x, y, w, h);
      fill(0);
      
      text(text, x+w/2, y+h/2);
    } else if (style==1) {
      ellipse(x, y, w, h);
      fill(0);
      text(text, x, y);
    }

    if (isInside() && mousePressed) {
      on=true;
    } else if (mousePressed) {
      on=false;
    }
    textAlign(BASELINE);
  }

  boolean isInside() {
    if (style==0) {
      if (mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h) {
        return true;
      } else {
        return false;
      }
    } else if (style==1) {
      if (dist(mouseX, mouseY, x, y)<=w/2) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }


  void window() {
    fill(255);
    rect(x, y+h, 130, 200);
  }
}

