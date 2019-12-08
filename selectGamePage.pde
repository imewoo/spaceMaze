// page = 5
void selectGamePage() {
   background(0);

  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  
  noStroke();
  //show the outer grey box
  //fill(255,255,255,150);
  //rect(200, 250, width-400, height-300, 40);

  image(fireworkImg, width/2-380, height/2-300, 700, 200);
  
   int current_timer = 10800;
  if(time_mode == 0){ //easy
     current_timer = 18000;
  }
  else if(time_mode == 1){ //normal
     current_timer = 10800;
  }
  else if(time_mode == 2){ //hard
     current_timer = 3600;
  }
  int showMin = floor((current_timer-timer)/3600);
  int showSec = floor((current_timer-timer)/60)%60;
  textSize(120);
  fill(255);
  text("You did it in " + showMin + ":" + ((showSec < 10)?"0":"") + showSec + "!", width/2, height/2);
  
  // button
  stroke(255);
  selectGameBtnIcon.draw();
  homeBtn.draw();
  exitBtn.draw();
  nextStageIcon.draw();
  
  // button click
  if (mousePressed) {
    if (exitBtn.click) {
      exit();
    }
    else if (nextStageIcon.click) {

    gameBGM.loop();

      page = 6;
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
