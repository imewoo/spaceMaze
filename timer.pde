class timer {
  int x, y, z;
  float rotateX, rotateY, rotateZ;
  
  timer(int xx, int yy, int zz, float rX, float rY, float rZ) {
      x = xx;
      y = yy;
      z = zz;
      rotateX = rX;
      rotateY = rY;
      rotateZ = rZ;

  }
  
  void draw() { 
    int showMin = floor(timer/3600);
    int showSec = floor(timer/60)%60;
    
    // countdown
    timer -= 1;
    if (timer <= 0) {
      page = 0; // main page
      bgm.loop();
      timer = 36000;
    }
    // draw timer
    translate(x, y, z);
    rotateX(rotateX);
    rotateY(rotateY);
    rotateZ(rotateZ);
    textAlign(CENTER, CENTER);
    textSize(10);
    fill(255,0,0);
    text(showMin + ":" + ((showSec < 10)?"0":"") + showSec, 15,15);
  }

}
