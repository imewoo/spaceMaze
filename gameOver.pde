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

   count = 0;
   a = 1;
   b = 1;
   c = 1;
   d = 1;
   e = 1;
   flag1_1 = true;
    flag1_2 = true;
    flag1_3 = true;
    flag1_4 = true;
    flag1_5 = true;
   camera.jump(25,CAMERA_Y*6,65);
   
    if(time_mode == 0){
       timer = 10800;  
    }
     else if(time_mode == 1){
       timer = 3600;
    }
     else if(time_mode == 2){
       timer = 1800;
    }
  
  
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
