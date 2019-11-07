class Button {
  float x;
  float y;
  float w;
  float h;
  String message;
  int size;
  boolean click = false;
  Button(float xx, float yy, float ww, float hh, String m, int s){
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    message = m;
    size = s;
  }
  
  void draw(){
    click = false;
    
    if(mouseX > x-w && mouseX < x+w && mouseY > y-h && mouseY < y+h){
      click = true;
    }
    
    // Button Design
    fill(0);
    strokeWeight(6);
    rect(x-w, y-h+7, 2*w, 2*h, 10);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(size);
    text(message, x, y);
  }
}
