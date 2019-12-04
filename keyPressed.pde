void keyPressed() {
  // game over
  // go to mainPage
  if (key == 'q' || key == 'Q') {
    page = 0; //mainPage
    bgm.loop();
  }
}

void gamePass(){
  // win the game
  // select page open (next stage  /  main page)
  if(selectflag){
    page = 3;
    bgm.loop();
  }
}
