class timerBox {
  int x, y, z;
  float rotateX, rotateY, rotateZ;
  
  timerBox(int xx, int yy, int zz, float rX, float rY, float rZ) {
      x = xx;
      y = yy;
      z = zz;
      rotateX = rX;
      rotateY = rY;
      rotateZ = rZ;

  }
  
  void draw() { 
    
    // draw rect
    fill(255,255,128);
    stroke(0);
    strokeWeight(20);
    translate(x, y, z);
    rotateX(rotateX);
    rotateY(rotateY);
    rotateZ(rotateZ);
    rect(0,0,30,30);
    
  }

}
