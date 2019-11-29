// page = 0
void mainPage() {
  background(0);
  
  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  image(astronautImg, width/2-700, 300, 300, 620);
  
  // button
  startBtn.draw();
  settingBtn.draw();
  guideBtn.draw();
  
  // button click
  if (mousePressed) {
    if (startBtn.click) {
      page = 1;
    }
    else if (settingBtn.click) {
      page = 2;
    }
    else if (guideBtn.click) {
      page = 3;
    }
  }
  
  // star
  speed = 5;
  translate(mouseX, mouseY);
  //translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }  
  
}
