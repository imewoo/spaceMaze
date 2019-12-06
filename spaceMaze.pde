/* spaceMaze */
import ddf.minim.*;    //audio
import damkjer.ocd.*;  //camera
import shapes3d.*;     //3d

// audio
Minim minim;
AudioPlayer bgm;
float volume = 0;

// camera: gamePage, camera2: mainPage
Camera camera, camera2;
Camera camera3, camera4;

final float CASE_SIZE = 10;  // size of one case 
final float CAMERA_Y = -5;   // camera permanent attitude
final float CAMERA_Z = 5;

Star[] stars = new Star[800];
float speed; //star speed

// image
PImage titleImg, astronautImg;
/* Textures */
PImage WALL_TEXTURE;
PImage ENEMY_TEXTURE;
PImage ITEM_TEXTURE;
PImage GROUND_TEXTURE;
PImage WATER_TEXTURE;
PImage TREE_TEXTURE;

char[][] map;  // loaded map /***** map = 150 x 140 *******/
char[][] map2;

int page = 0; //0 = main page
              //1 = game page
              //2 = setting page
              //3 = how to use page(guide button)
              //4 = gameOver page
              //5 = selectGame page
              
//int timer = 3600;
int timer = 36000;
//int timeron = 0;
//int maxtimer = 3600;
int min = minute();
int sec = second();
int mm = min*3600;
int ss = sec*60;
int countDown = mm+ss;

int count=2; //initialize count = 5;
int a=1; //initialize item size ratio
int b=1;


boolean flag = true;
boolean flag2 = true;

boolean selectflag=false;

Button startBtn;
Button settingBtn;
Button exitBtn;
Button guideBtn;
Button homeBtn;
Button startGameBtn;
Button settingBtnIcon;
Button guideBtnIcon;
Button gameOverBtnIcon;
Button selectGameBtnIcon;
Button nextStageIcon;

timerBox timerBox1;
timerBox timerBox2;
timerBox timerBox3;
timerBox timerBox4;
timerBox timerBox5;
timerBox timerBox6;

timer timer1;
timer timer2;
timer timer3;
timer timer4;
timer timer5;
timer timer6;

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
  
  // setup camera // camera(eye, center, n)
  camera = new Camera(this, 30, 6*CAMERA_Y, 30); //30, -5, 30 //sub camera
  // coordinate for the camera position
  // coordinate for the center of interest
  // component of the "up" direction vector
  camera2 = new Camera(this, width/2,height/2,900  ,width/2,height/2,0    ,0,0,0); //main camera //(eye, center, upVector)
    
    
  camera3 = new Camera(this, 30, 6*CAMERA_Y, 30); //30, -5, 30 //sub camera
  // coordinate for the camera position
  // coordinate for the center of interest
  // component of the "up" direction vector
  camera4 = new Camera(this, width/2,height/2,900  ,width/2,height/2,0    ,0,0,0); //main camera //(eye, center, upVector)  
    
 /************** Load map 1-stage from file *************/
  final String[] lines = loadStrings("default.map");
  
  map = new char[lines.length][lines[0].length()];
  
  for (int row = 0; row < lines.length; row++) {
    for (int col = 0; col < lines[row].length(); col++) {
      map[row][col] = lines[row].charAt(col);
    }
  }
 /*******************************************************/
 
 /************** Load map 2-stage from file *************/
  final String[] lines2 = loadStrings("default2.map");
  
  map2 = new char[lines2.length][lines2[0].length()];
  
  for (int row2 = 0; row2 < lines2.length; row2++) {
    for (int col2 = 0; col2 < lines2[row2].length(); col2++) {
      map2[row2][col2] = lines2[row2].charAt(col2);
    }
  }
 /*******************************************************/
 
 /* Load textures */
  WALL_TEXTURE = loadImage("wall.png");
  ENEMY_TEXTURE = loadImage("wall-texture.jpg");
  ITEM_TEXTURE = loadImage("water-texture.jpg");
  GROUND_TEXTURE = loadImage("grass-texture.png");
  WATER_TEXTURE = loadImage("water-texture.jpg");
  TREE_TEXTURE = loadImage("tree-texture.jpg");
  textureMode(NORMAL);

  // Button
  //startBtn = new Button(width/2+420, height/2+120, 160, 60, "START", 70); //original
  //settingBtn = new Button(width/2+420, height/2+245, 160, 40, "Setting", 45); //original
  //guideBtn = new Button(width/2+420, height/2+350, 160, 40, "How To Use", 40); //original
  startBtn = new Button(width/2+400, height/2+120, 160, 60, "START", 70);
  settingBtn = new Button(width/2+400, height/2+245, 160, 40, "Setting", 45);
  guideBtn = new Button(width/2+400, height/2+350, 160, 40, "How To Use", 40);
  
  homeBtn = new Button(width-380, height/2+300, 130, 40, "Home", 45);
  exitBtn = new Button(width-380, height/2+300, 130, 40, "Exit", 45);
  startGameBtn = new Button(width-380, height/2+400, 130, 40, "Game Start", 40);
  settingBtnIcon = new Button(300, 250, 130, 45, "Setting", 45);
  guideBtnIcon = new Button(300, 250, 130, 45, "How To Use", 40);
  selectGameBtnIcon = new Button(300, 250, 130, 45, "Game Over", 40);
  selectGameBtnIcon = new Button(300, 250, 130, 45, "Select Game", 40);
  nextStageIcon = new Button(width-380, height/2+200, 130, 40, "Next Stage", 40);
  
  // timer
  timerBox1 = new timerBox(50,-70,50,PI/2,0,0);
  timerBox2 = new timerBox(50,-40,50,PI/2,0,0);
  timerBox3 = new timerBox(80,-70,80,0,PI/2,0);
  timerBox4 = new timerBox(50,-70,80,0,PI/2,0);
  timerBox5 = new timerBox(80,-70,80,0,0,PI/2);
  timerBox6 = new timerBox(80,-70,50,0,0,PI/2);
  
  timer1 = new timer(50,-70,50,PI/2,0,0);
  timer2 = new timer(50,-39,50,PI/2,0,0);
  timer3 = new timer(81,-70,80,0,PI/2,0);
  timer4 = new timer(49,-70,80,0,PI/2,0);
  timer5 = new timer(80,-70,81,0,0,PI/2);
  timer6 = new timer(80,-70,49,0,0,PI/2);
}


void draw() {
    //startAlarm
  int m = minute()*60;
  int s = second()*3600;
  int time = m + s;
  
  // mainPage
  if (page == 0) {
    camera2.feed();
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
  
  // selectGamePage (someone who win the game has the choice whether go on or not)
  else if (page == 5){
    camera2.feed();
    selectGamePage();
  }
  else if (page == 6){
    camera4.feed();
    bgm.pause();
    gamePage2();
  }
  
}
