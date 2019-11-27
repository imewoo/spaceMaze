
/* spaceMaze */
import ddf.minim.*;    //audio
import damkjer.ocd.*;  //camera
import shapes3d.*;     //3d

// audio
Minim minim;
AudioPlayer bgm;
float volume = 0;

// camera1: gamePage, camera2: mainPage
Camera camera, camera2; 
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
  
  // setup camera // camera(eye, center, n)
  camera = new Camera(this, 30, 6*CAMERA_Y, 30); //30, -5, 30 //sub camera
  // coordinate for the camera position
  // coordinate for the center of interest
  // component of the "up" direction vector
  camera2 = new Camera(this, width/2,height/2,900,width/2,height/2,0,0,0,0); //main camera
    
    
    /* Load map from file */
  final String[] lines = loadStrings("default.map");
  
  map = new char[lines.length][lines[0].length()];
  
  for (int row = 0; row < lines.length; row++) {
    for (int col = 0; col < lines[row].length(); col++) {
      map[row][col] = lines[row].charAt(col);
    }
  }
  
 /* Load textures */
  WALL_TEXTURE = loadImage("wall.png");
  ENEMY_TEXTURE = loadImage("wall-texture.jpg");
  ITEM_TEXTURE = loadImage("astronaut.png");
  //GROUND_TEXTURE = loadImage("grass-texture.png");
  WATER_TEXTURE = loadImage("water-texture.jpg");
  TREE_TEXTURE = loadImage("tree-texture.jpg");
  textureMode(NORMAL);


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
    
  
}
