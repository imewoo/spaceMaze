// page = 5
void selectGamePage() { 
   background(0);

  // title
  image(titleImg, width/2-500, -50, 1000, 400);
  
  noStroke();
  //show the outer grey box
  //fill(255,255,255,150);
  //rect(200, 250, width-400, height-300, 40);

  // setup camera // camera(eye, center, n)
  final float CAMERA_Y = -5;   // camera permanent attitude
  camera3 = new Camera(this, 30, 6*CAMERA_Y, 30); //30, -5, 30 //sub camera
  // coordinate for the camera position
  // coordinate for the center of interest
  // component of the "up" direction vector
  camera4 = new Camera(this, width/2,height/2,900  ,width/2,height/2,0    ,0,0,0); //main camera //(eye, center, upVector)
  
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
      page = 6;
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
