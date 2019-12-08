void keyPressed() {
  // game over
  // go to mainPage
  if (key == 'q' || key == 'Q') {
    page = 0; //mainPage
    bgm.loop();
    gameBGM.pause();
    count = 0;
    timer = 10800;
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
