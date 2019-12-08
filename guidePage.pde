// page = 3
void guidePage() {
  background(0);
  
  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  
  noStroke();
  fill(255,255,255,150);
  rect(200, 250, width-400, height-300, 40);
  
  
  image(moveBtnImg, width/2-600, height/2-220, 750, 130);
  image(mouseMoveImg, width/2-600, height/2-80, 400, 120);
  image(mouseClickImg, width/2-600, height/2+60, 400, 120);
  image(qBtnImg, width/2-600, height/2+200, 150, 120);

  
  textSize(60);
  fill(0);
  text(":  Move", width/2+340, height/2-170);
  text(":  Camera Viewpoint", width/2+140, height/2-40);
  text(":  Eat Item", width/2, height/2+100);
  text(":  Game Over(Go to Start Page)", width/2, height/2+240);



  // button
  stroke(255);
  guideBtnIcon.draw();
  homeBtn.draw();
  startGameBtn.draw();
  
  boolean flag300 = true;
  boolean flag301 = true;
  // button click
  if (mousePressed) {
    if (homeBtn.click && flag300) {
    page = 0;
    flag300 = false;
    }
    else if (startGameBtn.click && flag301) {
      page = 1;
      flag301 = true;
    }
  }
  
  // star
  speed = 0.1;
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }
}
