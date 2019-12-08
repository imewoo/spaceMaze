// page = 4
void gameOverPage() { 
 background(0);

  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  
  noStroke();
  
  textSize(120);
  fill(255);
  text("Time Over!", width/2, height/2);
  
  stroke(255);
  homeBtn.draw();
  exitBtn.draw();
  
    // button click
  if (mousePressed) {
    if (exitBtn.click) {
      exit();
    }
    else if(homeBtn.click) {
      page = 0;
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
