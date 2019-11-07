/* spaceMaze */
import ddf.minim.*;    //audio
import damkjer.ocd.*;  //camera
import shapes3d.*;     //3d

// audio
Minim minim;
AudioPlayer bgm;
float volume = 0;

// camera
Camera camera;

Star[] stars = new Star[800];
float speed; //star speed

PImage titleImg, astronautImg;

int page = 0; //0 = main page
              //1 = game page
              //2 = setting page
              //3 = how to use page(guide button)

Button startBtn;
Button settingBtn;
Button guideBtn;
Button homeBtn;
Button startGameBtn;
Button settingBtnIcon;
Button guideBtnIcon;


void setup() {
  fullScreen(P3D);
  
  // Star
  for (int i = 0; i < stars.length; i++) {
        stars[i] = new Star();
    }

  // load Image
  titleImg = loadImage("spaceMaze.png");
  astronautImg = loadImage("astronaut.png");
  
  // load Music
  minim = new Minim(this);
  bgm = minim.loadFile("Interstellar.mp3");
  bgm.loop();
  bgm.setGain(volume); 
  

  // Button
  startBtn = new Button(width/2+420, height/2+120, 160, 60, "START", 70);
  settingBtn = new Button(width/2+420, height/2+245, 160, 40, "Setting", 45);
  guideBtn = new Button(width/2+420, height/2+350, 160, 40, "How To Use", 40);
  homeBtn = new Button(width-380, height/2+300, 130, 40, "Home", 45);
  startGameBtn = new Button(width-380, height/2+400, 130, 40, "Game Start", 40);
  settingBtnIcon = new Button(300, 250, 130, 45, "Setting", 45);
  guideBtnIcon = new Button(300, 250, 130, 45, "How To Use", 40);  
}


void draw() {
  
  // mainPage
  if (page == 0) {
    mainPage();
  }
  
  // gamePage
  else if (page == 1) {
    bgm.pause();
    gamePage();
  }
  
  // settingPage
  else if (page == 2) {
    settingPage();
  }
  
  // guidePage(how to use page)
  else if (page == 3) {
    guidePage();
  }
    
  
}
