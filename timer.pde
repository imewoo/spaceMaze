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
      page = 4; // Game over page
      gameBGM.pause();
      bgm.loop();
      if(time_mode == 0){ //easy
         timer = 18000;
      }
      else if(time_mode == 1){ //normal
         timer = 10800;
      }
      else if(time_mode == 2){ //hard
         timer = 3600;
      }
    }
    // draw timer
    translate(x, y, z);
    rotateX(rotateX);
    rotateY(rotateY);
    rotateZ(rotateZ);
    textAlign(CENTER, CENTER);
    textSize(10);
    fill(255,0,0);
    text("♥ " + count + "/5\n" + showMin + ":" + ((showSec < 10)?"0":"") + showSec, 15,15);
  }

}
