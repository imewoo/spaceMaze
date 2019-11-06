class Button {
  float x;
  float y;
  float w;
  float h;
  float ox;
  float oy;
  String message;
  boolean touch = false;
  Button(float xx, float yy, float ww, float hh, String m){
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    ox = xx-width/2;
    oy = yy-height/2;
    message = m;
  }
  
  void draw(){
    x = ox+width/2;
    y = oy+height/2;
    touch = false;
    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h){
      touch = true;
    }
    textSize(100);
    fill(255,0,0);
    textAlign(CENTER, CENTER);
    text(message, x+w/2, y+h/2-5);
  }
}
