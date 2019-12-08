// page = 2
void settingPage() { 
  background(0);
  
  // title
  image(titleImg, width/2-500, -50, 1000, 400);

  
  noStroke();
  fill(255,255,255,150);
  rect(200, 250, width-400, height-300, 40);
  
  image(soundSettingImg, width/2-550, height/2-180, 200, 200);
  image(timeSettingImg, width/2-550, height/2+100, 200, 200);
  
  
  // button
  stroke(255);
  settingBtnIcon.draw();
  homeBtn.draw();
  startGameBtn.draw();
  soundOnBtn.draw();
  soundOffBtn.draw();
  timeEasyBtn.draw();
  timeNormalBtn.draw();
  timeHardBtn.draw();

  
  // button click
  if (mousePressed) {
    if (homeBtn.click) {
    page = 0;
    }
    else if (startGameBtn.click) {
      page = 1;
    }
    else if(soundOnBtn.click){
       bgm.unmute();
       gameBGM.unmute();
    }
    else if(soundOffBtn.click){
       bgm.mute();
       gameBGM.mute();
    }
     else if(timeEasyBtn.click){
       timer = 54000;
    }
     else if(timeNormalBtn.click){
       timer = 36000;
    }
     else if(timeHardBtn.click){
       timer = 18000;
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
