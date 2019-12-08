// page = 5
void selectGamePage() {
   background(0);

  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  
  noStroke();
  //show the outer grey box
  //fill(255,255,255,150);
  //rect(200, 250, width-400, height-300, 40);

  
  // button
  stroke(255);
  selectGameBtnIcon.draw();
  exitBtn.draw();
  nextStageIcon.draw();
  
  // button click
  if (mousePressed) {
    if (exitBtn.click) {
      exit();
    }
    else if (nextStageIcon.click) {
      gameBGM.loop();
      if(mapflag==1){
        mapflag=2;
      }
      else if(mapflag==2){
        mapflag=3;
      }
      else if(mapflag==3){
        mapflag=1;
      }
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
