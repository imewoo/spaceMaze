// page = 1
int timeCount=0; //time count
int die_timeCount=0; //if game end, timecount remain

int frameConstant=300; //initialize fps
int game_end_confirm=1; //set end
float delta = 0.0f ;

float angle = 0;
float aVelocity = 0;
float aAcceleration = 0.001;

/*
void timedraw(){
    //////time//////
  if((frameCount%(frameConstant/3))==0 && game_end_confirm==0)
    timeCount++;
    
  fill(255,255,255);
  textSize(100);
  textAlign(CENTER);
  
  if(game_end_confirm==0) //show time count
    text(timeCount,450,130);
  else                 //show die time count
    text(die_timeCount,450,130);
}
*/

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
    }
    
    /* If we are in non allowed area (wall, tree or water) cancel the movement */
    if (!isAllowedCase(camera)) {
      camera.jump(position[0], CAMERA_Y, position[2]);  // reset previous position
    }
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
          case '#':
            drawWall();
            break;
          case '$':
            drawTree();
            break;
          case '~':
            drawWater();
            break;
          case '@':
            drawItem();
            break;
          case '%':
            drawEnemy();
            break;
          case '&':
            drawTime();
            break;
          default:
            drawGround();
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

  //pushMatrix();
  //  fill(0,0,255);
  //  translate(50, -70, 50);
  //  rotateX(PI/2);
  //  rotateY(0);
  //  rotateZ(0);
  //  rect(0,0,30,30);
  //popMatrix();
  //pushMatrix();
  //  fill(0,0,255);
  //  translate(50, -40, 50);
  //  rotateX(PI/2);
  //  rotateY(0);
  //  rotateZ(0);
  //  rect(0,0,30,30);
  //popMatrix();
  
  //pushMatrix();
  //  fill(0,255,0);
  //  translate(80, -70, 80);
  //  rotateY(PI/2);
  //  rect(0,0,30,30);
  //popMatrix();
  //pushMatrix();
  //  fill(0,255,0);
  //  translate(50, -70, 80);
  //  rotateY(PI/2);
  //  rect(0,0,30,30);
  //popMatrix();
  
  //pushMatrix();
  //  fill(255, 0, 0);
  //  translate(80, -70, 80);
  //  rotateZ(PI/2);
  //  rect(0,0,30,30);
  //popMatrix();  
  //pushMatrix();
  //  fill(255, 0, 0);
  //  translate(80, -70, 50);
  //  rotateZ(PI/2);
  //  rect(0,0,30,30);
  //popMatrix();  
  
  ////startAlarm
  //int m = minute();
  //int s = second();
  //int time = m+s;
  //if(time == countDown+timer){
  //  page = 0;
  //}

  
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
 * Draws tree in current case.c
 */
void drawTree() {
  //drawGround();
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

void drawTime() {
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

/**
 * Draws water in current case.
 */
void drawWater() {
  beginShape(QUADS);
  texture(WATER_TEXTURE);
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
  
  angle++;
  popMatrix();
  
  noFill();

}

void drawItem(){
  final Ellipsoid item = new Ellipsoid(this, 20, 30);
  item.setTexture(ITEM_TEXTURE);
  item.drawMode(Shape3D.TEXTURE);
  item.setRadius(CASE_SIZE / 4);

  pushMatrix();
  translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
  rotateY(angle);
  item.draw();
  
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
 * Checks if camera is in allowed map case.
 *
 * @param camera camera object
 *
 * @return true - camera is in allowed map case, false - not.
 */
boolean isAllowedCase(final Camera camera) {
  final char caseContent = caseContent(camera);
  return caseContent == ' '
    || caseContent == 'S'
    || caseContent == 'F';
}

/**
 * Returns the content of current case of the map.
 *
 * @param camera camera object
 *
 * @return character of content of the current case of the map
 */
char caseContent(final Camera camera) {
  final int[] caseIds = currentCase(camera);
  return map[caseIds[0]][caseIds[1]];
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
    (int) (position[2] / CASE_SIZE),
    (int) (position[0] / CASE_SIZE) };
}
