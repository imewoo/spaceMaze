// page = 4
void gameOverPage() { 
  background(0);
  
  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  
  noStroke();
  fill(255,255,255,150);
  rect(200, 250, width-400, height-300, 40);

  
  // button
  stroke(255);
  gameOverBtnIcon.draw();
  homeBtn.draw();
  startGameBtn.draw();
  
  // button click
  if (mousePressed) {
    if (homeBtn.click) {
    page = 0;
    }
    else if (startGameBtn.click) {
      page = 1;
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
