// page = 2
void settingPage() { 
  background(0);
  
  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  
  noStroke();
  fill(255,255,255,150);
  rect(200, 250, width-400, height-300, 40);

  
  // button
  stroke(255);
  settingBtnIcon.draw();
  homeBtn.draw();
  startGameBtn.draw();
  
  boolean flag200 = true;
  boolean flag201 = true;
  // button click
  if (mousePressed) {
    if (homeBtn.click && flag200) {
    page = 0;
    flag200 = false;
    }
    else if (startGameBtn.click && flag201) {
      page = 1;
      flag201 = false;
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
