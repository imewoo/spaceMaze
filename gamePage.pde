// page = 1
int timeCount=0; //time count
int die_timeCount=0; //if game end, timecount remain

int frameConstant=300; //initialize fps
int game_end_confirm=1; //set end
float delta = 0.0f ;

float angle = 0;
float aVelocity = 0;
float aAcceleration = 0.001;

void gamePage() {
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
    final float[] position = camera.position();
    
    switch (keyCode) {
      case UP:
        onStepForward(camera);
        break;
      case DOWN:
        onStepBackward(camera);
        break;
      case LEFT:
        onStepLeft(camera);
        break;
      case RIGHT:
        onStepRight(camera);
        break;
    }
    
    /* If we are in non allowed area (wall, tree or water) cancel the movement */
    if (!isAllowedCase(camera)) { // if not allowed to move 
      camera.jump(position[0], CAMERA_Y, position[2]);  // reset previous position
    }
    
    /*
    if(isItem(camera)){ //eat item = count--;
      drawItemCheck();
      count--; //initialized count = 5
    }*/
    
    //This code will be completed after ending ItemCheck function.
    //count == 0 & approach to 'S'
    //In this case, 'S' is the end point.
    if(count==0 && isEnd(camera)){ 
      selectflag=true;
     page = 5; // selectGamePage
     bgm.loop();
    }
    
    println(count);
  }
  
  
  /* Pose camera */ 
  camera.feed();
    
    
  /* Draw map */
    for (int row = 0; row < map.length; row++) {
      pushMatrix();
      translate(0, 0, row * CASE_SIZE);
      
      for (int col = 0; col < map[row].length; col++) {
        pushMatrix();
        translate(col * CASE_SIZE, 0, 0);
        
        switch (map[row][col]) {
          case '#': drawWall(); break; //wall 
          case '@': drawItem(); break; //item 1
          case '^': drawItem2(); break;  //item 2
          case '%': //drawEnemy();
            break; //enemy
          case 'S': drawEndPoint(); break; //end point
          case 'G': drawGround(); break; //ground
          default: break;
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
void drawWall() {
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
 * Draws ground in current case.
 */
void drawGround() {
  beginShape(QUADS); //rectangle
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


void drawEndPoint() {
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
void drawSphere() {
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
  rotateY(angle/8);
  
  translate(CASE_SIZE, -CASE_SIZE / 2, CASE_SIZE);
  enemy.draw();
  
   //for game optimization -ing

  if(angle<50){
    angle++;
  }else{
    angle=0;
  }
  
  angle++;
  popMatrix();
  
  noFill();
}
*/

void drawItem(){
  if(isItem(camera) && flag && mousePressed){ //eat item = count--;
      drawItemCheck();
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
      rotateY(angle);
      
    boolean flag2=true;
    item.draw();
      //for game optimization
      if(angle < 6){
        angle++;
      }else{
        angle=0;
      }
      
      angle++;
      //aVelocity = aVelocity + aAcceleration;
      //angle = angle + aVelocity;
      
      /*
      if(angle>50){
        aVelocity *= -1;
      }*/
      popMatrix();
      
      noFill();
    }
}

void drawItem2(){

    if(isItem2(camera) && flag2 && mousePressed){ //eat item = count--;
      drawItemCheck();
      b=b/2;
      count--; //initialized count = 5
      flag2 = false;
    }
    
    else{
      final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      //final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item2.setTexture(ITEM_TEXTURE);
      item2.drawMode(Shape3D.TEXTURE);
      item2.setRadius(b*CASE_SIZE / 4);
    
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
      rotateY(angle);
      item2.draw();
      
      //for game optimization
      if(angle < 6){
        angle++;
      }else{
        angle=0;
      }
      
      angle++;
    
      popMatrix();
    
      noFill();
    }
}


void drawItemCheck(){
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
void mouseMoved() {
  camera.look(radians(mouseX - pmouseX) / 6.0, radians(mouseY - pmouseY) / 6.0);
}

/**
 * Handler of command to move camera forward.
 *
 * @param camera camera object
 */
void onStepForward(final Camera camera) {
  camera.dolly(-0.5);
  final float[] position = camera.position();
  camera.jump(position[0], CAMERA_Y, position[2]);  // force attitude
}

/**
 * Handler of command to move camera backward.
 *
 * @param camera camera object
 */
void onStepBackward(final Camera camera) {
  camera.dolly(0.5); //camera.dolly(distance)
  final float[] position = camera.position();
  camera.jump(position[0], CAMERA_Y, position[2]);  // force attitude    //jump(locationX, locationY, locationZ)
}

/**
 * Handler of command to move camera left.
 *
 * @param camera camera object
 */
void onStepLeft(final Camera camera) {
  camera.truck(-0.5);
}

/**
 * Handler of command to move camera right.
 *
 * @param camera camera object
 */
void onStepRight(final Camera camera) {
  camera.truck(0.5);
}

/**
 * Checks if camera is in allowed map case.
 *
 * @param camera camera object
 *
 * @return true - camera is in allowed map case, false - not.
 */
boolean isAllowedCase(final Camera camera) { //if blank, 'S', 'F', '@', '^' allowed to go!
  final char caseContent = caseContent(camera);
  //if user does not eat the item, end gate does not open
  if(count==0){
  return caseContent == 'G'
         || caseContent == 'S'
         || caseContent == 'F'  
         || caseContent == '@'
         || caseContent == '^';
  }
  else{
  return caseContent == 'G'
         || caseContent == 'F'  
         || caseContent == '@'
         || caseContent == '^';
  }
}

boolean isItem(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == '@';
}

boolean isItem2(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == '^';
}

boolean isEnd(final Camera camera){ //when camera approach to end point(S).
  final char caseContent = caseContent(camera);
  return caseContent == 'S';
 }
/**
 * Returns the content of current case of the map.
 *
 * @param camera camera object
 *
 * @return character of content of the current case of the map
 */
char caseContent(final Camera camera) {
  final int[] caseId= currentCase(camera);
  return map[caseId[0]][caseId[1]];
}

/**
 * Returns the case (row & col) in which camera is currently situated.
 *
 * @param camera camera object
 *
 * @return array with row & col in which camera currently situated
 */
int[] currentCase(final Camera camera) {
  final float[] position = camera.position();
  
  return new int[]{
    (int) ( position[2] / CASE_SIZE),
    (int) ( position[0] / CASE_SIZE) };
}
