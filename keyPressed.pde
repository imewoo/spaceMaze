void keyPressed() {
  // game over
  // go to mainPage
  if (key == 'q' || key == 'Q') {
    page = 0; //mainPage
    bgm.loop();
    gameBGM.pause();

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
    
  if(time_mode == 0){
     timer = 18000;
  }
   else if(time_mode == 1){
     timer = 10800;
  }
   else if(time_mode == 2){
     timer = 3600;
  }
    camera.jump(25,CAMERA_Y*6,65);

    if(mapflag==1){
      mapflag=2;
    }
    else if(mapflag==2){
      mapflag=3;
    }
    else if(mapflag==3){
      mapflag=1;
    }
  }
}

// TODO: remake it
//6.0 -> 1 circle moved.
void mouseMoved() {

  if(cameraflag==0){
    //if (height/2 < mouseY){
    //  camera.look(radians(mouseX - pmouseX) / 6.0, 0);
    //}
    //else{
    camera.look(radians(mouseX - pmouseX) / 6.0, radians(mouseY - pmouseY) / 6.0);
    //}
  }
  else if(cameraflag==1){
    camera.look(radians(mouseX - pmouseX) / 6.0, radians(mouseY - pmouseY) / 6.0);
  }
}
