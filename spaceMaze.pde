//SpaceMaze

Star[] stars = new Star[800];
float speed; //star speed

int page = 0; //0 = main page
              //1 = game page
              //2 = setting page
              //3 = how to use page

Button startBtn;


void setup() {
  fullScreen(P3D);
  
  for (int i = 0; i < stars.length; i++) {
        stars[i] = new Star();
    }
    //speed = 0.1;
    //fill(255);

  startBtn = new Button(width/2-50, height/2, 100,50, "START");
  
}


void draw() {
  if (page == 0) {
    background(0);
    speed = 0.1;
    startBtn.draw();
    translate(width/2, height/2);
    for (int i = 0; i < stars.length; i++) {
        stars[i].update();
        stars[i].show();
    }
  }
  
  else if (page == 1) {
    background(0);
    speed = 10;
    translate(mouseX, mouseY);
    for (int i = 0; i < stars.length; i++) {
        stars[i].update();
        stars[i].show();
    }
  }

}


void mouseClicked() {
  if (startBtn.touch) {
    page = 1;
  }
  
}  
