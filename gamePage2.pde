// page = 1
int timeCount2=0; //time count
int die_timeCount2=0; //if game end, timeCount2 remain

int frameConstant2=300; //initialize fps
int game_end_confirm2=1; //set end
float delta2 = 0.0f ;

float angle2 = 0;
float aVelocity2 = 0;
float aAcceleration2 = 0.001;

void gamePage2() {
  // star
  background(0);
  speed = 2;
  translate(width/2, height/2, 0);
  //translate(mouseX, mouseY,0);
  for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }
  
  
  /* Navigate camera */
  if (keyPressed && key == CODED) {
    final float[] position = camera3.position();
    
    switch (keyCode) {
      case UP:
        onStepForward2(camera3);
        break;
      case DOWN:
        onStepBackward2(camera3);
        break;
    }
    
    /* If we are in non allowed area (wall, tree or water) cancel the movement */
    if (!isAllowedCase2(camera3)) { // if not allowed to move 
      camera3.jump(position[0], CAMERA_Y, position[2]);  // reset previous position
    }
    
    /*
    if(isItem2_1(camera)){ //eat item = count--;
      drawItem2_1Check();
      count--; //initialized count = 5
    }*/
    
    //This code will be completed after ending ItemCheck function.
    //count == 0 & approach to 'S'
    //In this case, 'S' is the end point.
    if(count==0 && isEnd2(camera3)){ 
      selectflag=true;
     page = 5;
     bgm.loop();
    }
    
    println(count);
  }
  
  
  /* Pose camera */ 
  camera3.feed();
    
    
  /* Draw map */
    for (int row = 0; row < map2.length; row++) {
      pushMatrix();
      translate(0, 0, row * CASE_SIZE);
      
      for (int col = 0; col < map2[row].length; col++) {
        pushMatrix();
        translate(col * CASE_SIZE, 0, 0);
        
        switch (map2[row][col]) {
          case '#':
            drawWall2();
            break;
          case '$':
            //drawTree2();
            break;
          case '~':
            //drawWater2();
            break;
          case '@':
            drawItem2_1();
            break;
          case '^':
            drawItem2_2();
            break;
          case '%':
            //drawEnemy();
            break;
          case '&':
            drawTime2();
            break;
          case 'S':
            drawEndPoint2();
          default:
            drawGround2();
        }
  
        popMatrix();
      }
      
      popMatrix();
    }
    
    
  // draw timerBox
  pushMatrix();
    timerBox1.draw();
  popMatrix();
  pushMatrix();
    timerBox2.draw();
  popMatrix();
  pushMatrix();
    timerBox3.draw();
  popMatrix();
  pushMatrix();
    timerBox4.draw();
  popMatrix();
  pushMatrix();
    timerBox5.draw();
  popMatrix();
  pushMatrix();
    timerBox6.draw();
  popMatrix();
  
  // draw timer
  pushMatrix();
    timer1.draw();
  popMatrix();
  pushMatrix();
    timer2.draw();
  popMatrix();
  pushMatrix();
    timer3.draw();
  popMatrix();
  pushMatrix();
    timer4.draw();
  popMatrix();
  pushMatrix();
    timer5.draw();
  popMatrix();
  pushMatrix();
    timer6.draw();
  popMatrix();
  
}

// draw wall
void drawWall2() {
  final Box box = new Box(this, CASE_SIZE);
  box.drawMode(S3D.TEXTURE);
  //box.setTexture(WALL_TEXTURE);
  box.setTexture(WALL_TEXTURE);
  
  pushMatrix();
  translate(CASE_SIZE/2, -CASE_SIZE/2, CASE_SIZE/2); // 20, -5, 5
  //translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2);
  //box(40);
  noStroke();
  //color(255,0,0);
  //stroke(40);
  box.draw();
  popMatrix();

  noFill();
}

/**
 * Draws tree in current case.c
 */
void drawTree2() {
  //drawGround2();
  final Ellipsoid tree = new Ellipsoid(this, 20, 30);
  tree.setTexture(TREE_TEXTURE);
  tree.drawMode(Shape3D.TEXTURE);
  tree.setRadius(CASE_SIZE / 4);

  pushMatrix();
  translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
  
  tree.draw();
  popMatrix();
  
  noFill();
}

void drawTime2() {
  final Box time = new Box(this, CASE_SIZE);
  time.drawMode(S3D.TEXTURE);
  time.setTexture(WALL_TEXTURE);
  
  translate(10*CASE_SIZE/2, -6*CASE_SIZE/2, 10*CASE_SIZE/2); //CASE_SIZE = 10
  pushMatrix();
  //scale(2);
  noStroke();
  time.draw();
  popMatrix();

  noFill();
}

/**
 * Draws ground in current case.
 */
void drawGround2() {
  beginShape(QUADS); //rectangle2
  //texture(WALL_TEXTURE);
  stroke(255); //line color = white
  strokeWeight(10); // line size = 10
  
  vertex(0, 0, 0, 0, 0);
  vertex(CASE_SIZE, 0, 0, 1, 0);
  vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
  vertex(0, 0, CASE_SIZE, 0, 1);
  
  endShape();
  noFill();
}

/**
 * Draws water in current case.
 */
void drawWater2() {
  beginShape(QUADS);
  texture(WATER_TEXTURE);
  vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
  vertex(CASE_SIZE, 0, 0, 1, 0);
  vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
  vertex(0, 0, CASE_SIZE, 0, 1);
  endShape();
  noFill();
}

void drawEndPoint2() {
  beginShape(QUADS);
  texture(GROUND_TEXTURE);
  vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
  vertex(CASE_SIZE, 0, 0, 1, 0);
  vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
  vertex(0, 0, CASE_SIZE, 0, 1);
  endShape();
  noFill();
}

/**
 * Draws sphere in current case.
 */
void drawSphere2() {
  pushMatrix();
  translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2);
  sphere(CASE_SIZE / 2);
  popMatrix();
}


/*
void drawEnemy(){
  final Ellipsoid enemy = new Ellipsoid(this, 20, 30);
  enemy.setTexture(ENEMY_TEXTURE);
  enemy.drawMode(Shape3D.TEXTURE);
  enemy.setRadius(CASE_SIZE);

  pushMatrix();
  
  translate(4*CASE_SIZE / 2, -CASE_SIZE / 3, 3*CASE_SIZE / 2);
  rotateY(angle2/8);
  
  translate(CASE_SIZE, -CASE_SIZE / 2, CASE_SIZE);
  enemy.draw();
  
   //for game optimization -ing

  if(angle2<50){
    angle2++;
  }else{
    angle2=0;
  }
  
  angle2++;
  popMatrix();
  
  noFill();
}
*/

void drawItem2_1(){
  
  if(isItem2_1(camera3) && flag && mousePressed){ //eat item = count--;
      drawItem2_1Check();
      a=a/2;
      count--; //initialized count = 5
      flag =false;
      println(flag);
    }
    
    else{
      final Ellipsoid item = new Ellipsoid(this, 20, 30);
      item.setTexture(ITEM_TEXTURE);
      item.drawMode(Shape3D.TEXTURE);
      item.setRadius(a*CASE_SIZE / 4);
    
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
      rotateY(angle2);
      
    boolean flag2=true;item.draw();
      //for game optimization
      if(angle2 < 6){
        angle2++;
      }else{
        angle2=0;
      }
      
      angle2++;
      //aVelocity2 = aVelocity2 + aAcceleration2;
      //angle2 = angle2 + aVelocity2;
      
      /*
      if(angle2>50){
        aVelocity2 *= -1;
      }*/
      popMatrix();
      
      noFill();
    }
}

void drawItem2_2(){

    if(isItem2_2(camera3) && flag2 && mousePressed){ //eat item = count--;
      drawItem2_1Check();
      b=b/2;
      count--; //initialized count = 5
      flag2 = false;
    }
    
    else{
      final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item2.setTexture(ITEM_TEXTURE);
      item2.drawMode(Shape3D.TEXTURE);
      item2.setRadius(b*CASE_SIZE / 4);
    
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
      rotateY(angle2);
      item2.draw();
      
      //for game optimization
      if(angle2 < 6){
        angle2++;
      }else{
        angle2=0;
      }
      
      angle2++;
    
      popMatrix();
    
      noFill();
    }
}


void drawItem2_1Check(){
  beginShape(QUADS);
  texture(GROUND_TEXTURE);
  vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
  vertex(CASE_SIZE, 0, 0, 1, 0);
  vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
  vertex(0, 0, CASE_SIZE, 0, 1);
  endShape();
  noFill();
}

// TODO: remake it
//6.0 -> 1 circle moved.
void mouseMoved2() {
  camera3.look(radians(mouseX - pmouseX) / 6.0, radians(mouseY - pmouseY) / 6.0);
}

/**
 * Handler of command to move camera forward.
 *
 * @param camera camera object
 */
void onStepForward2(final Camera camera3) {
  camera3.dolly(-0.5);
  final float[] position = camera.position();
  camera3.jump(position[0], CAMERA_Y, position[2]);  // force attitude
}

/**
 * Handler of command to move camera backward.
 *
 * @param camera camera object
 */
void onStepBackward2(final Camera camera3) {
  camera3.dolly(0.5); //camera.dolly(distance)
  final float[] position = camera.position();
  camera3.jump(position[0], CAMERA_Y, position[2]);  // force attitude    //jump(locationX, locationY, locationZ)
}


/**
 * Checks if camera is in allowed map case.
 *
 * @param camera camera object
 *
 * @return true - camera is in allowed map case, false - not.
 */
boolean isAllowedCase2(final Camera camera3) { //if blank, 'S', 'F', '@', '^' allowed to go!
  final char caseContent2 = caseContent2(camera3);
  //if user does not eat the item, end gate does not open
  if(count==0){
  return caseContent2 == ' '
         || caseContent2 == 'S'
         || caseContent2 == 'F'  
         || caseContent2 == '@'
         || caseContent2 == '^';
  }
  else{
  return caseContent2 == ' '
         || caseContent2 == 'F'  
         || caseContent2 == '@'
         || caseContent2 == '^';
  }
}

boolean isItem2_1(final Camera camera3){ //when camera catch the item.
  final char caseContent2 = caseContent2(camera3);
  return caseContent2 == '@';
}

boolean isItem2_2(final Camera camera3){ //when camera catch the item.
  final char caseContent2 = caseContent2(camera3);
  return caseContent2 == '^';
}

boolean isEnd2(final Camera camera3){ //when camera approach to end point(S).
  final char caseContent2 = caseContent2(camera3);
  return caseContent2 == 'S';
 }
/**
 * Returns the content of current case of the map.
 *
 * @param camera camera object
 *
 * @return character of content of the current case of the map
 */
char caseContent2(final Camera camera3) {
  final int[] caseId= currentCase2(camera3);
  return map[caseId[0]][caseId[1]];
}

/**
 * Returns the case (row & col) in which camera is currently situated.
 *
 * @param camera camera object
 *
 * @return array with row & col in which camera currently situated
 */
int[] currentCase2(final Camera camera3) {
  final float[] position = camera3.position();
  
  return new int[]{
    (int) (position[2] / CASE_SIZE),
    (int) (position[0] / CASE_SIZE) };
}

/*
void mousePressed() {
  noLoop();
  count--;
}

void mouseReleased() {
  loop();
}
*/
