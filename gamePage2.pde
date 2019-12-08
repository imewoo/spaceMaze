// page = 6
int timeCount2=0; //time count
int die_timeCount2=0; //if game end, timeCount2 remain

int frameConstant2=300; //initialize fps
int game_end_confirm2=1; //set end
float delta2 = 0.0f ;

float angle2 = 0;
float aVelocity2 = 0;
float aAcceleration2 = 0.001;

void gamePage2() {
   
  cameraflag=1;

 
  // star
  background(0);
  speed = 2;
  translate(width/2, height/2, 0);
  //translate(mouseX, mouseY,0);
  for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }
  
  /* Pose camera */ 
  camera.feed();
  
  
  
  /* Navigate camera */
  if (keyPressed && key == CODED) {
    final float[] position = camera.position();
    
    switch (keyCode) {
      case UP:        onStepForward2(camera);        break;
      case DOWN:      onStepBackward2(camera);        break;
      case LEFT:      onStepLeft2(camera);        break;
      case RIGHT:     onStepRight2(camera);        break;
    }
  
    
    /* If we are in non allowed area (wall, tree or water) cancel the movement */
    if (!isAllowedCase2(camera)) { // if not allowed to move 
      camera.jump(position[0], CAMERA_Y, position[2]);  // reset previous position
    }
    
    /*
    if(isItem2_1(camera)){ //eat item = count--;
      drawItem2_1Check();
      count--; //initialized count = 5
    }*/
    
    //This code will be completed after ending ItemCheck function.
    //count == 0 & approach to 'S'
    //In this case, 'S' is the end point.
    
    
    //println("2 = " +count2);
  }
  
  
    
    
  /* Draw map */
    for (int row = 0; row < map2.length; row++) {
      pushMatrix();
      translate(0, 0, row * CASE_SIZE2);
      
      for (int col = 0; col < map2[row].length; col++) {
        pushMatrix();
        translate(col * CASE_SIZE2, 0, 0);
        
        switch (map2[row][col]) {
          case '#': drawWall2();  break; // wall
          case 'A': drawItem2_1(); break; //item 1
          case 'B': drawItem2_2(); break; //item 2
          case '%'://drawEnemy();
            break; //enemy
          case 'S': drawEndPoint2(); //end point
          case 'G': drawGround2(); break; //ground
          default: break;
        }
  
        popMatrix();
      }
      
      popMatrix();
    }
    
    
  // draw timerBox
  pushMatrix();    timerBox1.draw();  popMatrix();
  pushMatrix();    timerBox2.draw();  popMatrix();
  pushMatrix();    timerBox3.draw();  popMatrix();
  pushMatrix();    timerBox4.draw();  popMatrix();
  pushMatrix();    timerBox5.draw();  popMatrix();
  pushMatrix();    timerBox6.draw();  popMatrix();
  
    // draw timer
  pushMatrix();    timer1.draw();  popMatrix();
  pushMatrix();    timer2.draw();  popMatrix();
  pushMatrix();    timer3.draw();  popMatrix();
  pushMatrix();    timer4.draw();  popMatrix();
  pushMatrix();    timer5.draw();  popMatrix();
  pushMatrix();    timer6.draw();  popMatrix();
  
}

// draw wall
void drawWall2() {
  final Box box = new Box(this, CASE_SIZE2);
  box.drawMode(S3D.TEXTURE);
  //box.setTexture(WALL_TEXTURE);
  box.setTexture(WALL_TEXTURE);
  
  pushMatrix();
  translate(CASE_SIZE2/2, -CASE_SIZE2/2, CASE_SIZE2/2); // 20, -5, 5
  //translate(CASE_SIZE2 / 2, -CASE_SIZE2 / 2, CASE_SIZE2 / 2);
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
void drawGround2() {
  beginShape(QUADS); //rectangle2
  //texture(WALL_TEXTURE);
  stroke(255); //line color = white
  strokeWeight(10); // line size = 10
  
  vertex(0, 0, 0, 0, 0);
  vertex(CASE_SIZE2, 0, 0, 1, 0);
  vertex(CASE_SIZE2, 0, CASE_SIZE2, 1, 1);
  vertex(0, 0, CASE_SIZE2, 0, 1);
  
  endShape();
  noFill();
}


void drawEndPoint2() {
  beginShape(QUADS);
  texture(GROUND_TEXTURE);
  vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
  vertex(CASE_SIZE2, 0, 0, 1, 0);
  vertex(CASE_SIZE2, 0, CASE_SIZE2, 1, 1);
  vertex(0, 0, CASE_SIZE2, 0, 1);
  endShape();
  noFill();
}

/**
 * Draws sphere in current case.
 */
void drawSphere2() {
  pushMatrix();
  translate(CASE_SIZE2 / 2, -CASE_SIZE2 / 2, CASE_SIZE2 / 2);
  sphere(CASE_SIZE2 / 2);
  popMatrix();
}


/*
void drawEnemy(){
  final Ellipsoid enemy = new Ellipsoid(this, 20, 30);
  enemy.setTexture(ENEMY_TEXTURE);
  enemy.drawMode(Shape3D.TEXTURE);
  enemy.setRadius(CASE_SIZE2);

  pushMatrix();
  
  translate(4*CASE_SIZE2 / 2, -CASE_SIZE2 / 3, 3*CASE_SIZE2 / 2);
  rotateY(angle2/8);
  
  translate(CASE_SIZE2, -CASE_SIZE2 / 2, CASE_SIZE2);
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
  
  if(isItem2_1(camera) && flag3 && mousePressed){ //eat item = count--;
      drawItem2_1Check();
      aa=aa/2;
      count2--; //initialized count = 5
      flag3 =false;
      //println(flag);
    }
    
    else{
      final Ellipsoid item = new Ellipsoid(this, 20, 30);
      item.setTexture(ITEM_TEXTURE);
      item.drawMode(Shape3D.TEXTURE);
      item.setRadius(aa*CASE_SIZE2 / 4);
    
      pushMatrix();
      translate(CASE_SIZE2 / 2, -CASE_SIZE2 / 2, CASE_SIZE2 / 2); //center of block
      rotateY(angle2);
      
      item.draw();
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

    if(isItem2_2(camera) && flag4 && mousePressed){ //eat item = count--;
      drawItem2_1Check();
      bb=bb/2;
      count2--; //initialized count = 5
      flag4 = false;
    }
    
    else{
      final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item2.setTexture(ITEM_TEXTURE);
      item2.drawMode(Shape3D.TEXTURE);
      item2.setRadius(bb*CASE_SIZE2 / 4);
    
      pushMatrix();
      translate(CASE_SIZE2 / 2, -CASE_SIZE2 / 2, CASE_SIZE2 / 2); //center of block
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
  vertex(CASE_SIZE2, 0, 0, 1, 0);
  vertex(CASE_SIZE2, 0, CASE_SIZE2, 1, 1);
  vertex(0, 0, CASE_SIZE2, 0, 1);
  endShape();
  noFill();
}



/**
 * Handler of command to move camera forward.
 *
 * @param camera camera object
 */
void onStepForward2(final Camera camera) {
 
  camera.dolly(-0.5);
  final float[] position = camera.position();
  camera.jump(position[0], CAMERA_Y, position[2]);  // force attitude
   
  println("step!!!!!!");
  println(position[0]);
  println(CAMERA_Y);
  println(position[2]);
  println("step@@@@@@@@@@@@@@@");
}

/**
 * Handler of command to move camera backward.
 *
 * @param camera camera object
 */
void onStepBackward2(final Camera camera) {
  camera.dolly(0.5); //camera.dolly(distance)
  final float[] position = camera.position();
  camera.jump(position[0], CAMERA_Y, position[2]);  // force attitude    //jump(locationX, locationY, locationZ)
}

/**
 * Handler of command to move camera left.
 *
 * @param camera camera object
 */
void onStepLeft2(final Camera camera) {
  camera.truck(-0.5);
}

/**
 * Handler of command to move camera right.
 *
 * @param camera camera object
 */
void onStepRight2(final Camera camera) {
  camera.truck(0.5);
}

/**
 * Checks if camera is in allowed map case.
 *
 * @param camera camera object
 *
 * @return true - camera is in allowed map case, false - not.
 */
boolean isAllowedCase2(final Camera camera) { //if blank, 'S', 'F', '@', '^' allowed to go!
  final char caseContent2 = caseContent2(camera);
  //if user does not eat the item, end gate does not open
  if(count2==0){
  return caseContent2 == ' '
         || caseContent2 == 'S'
         || caseContent2 == 'F'  
         || caseContent2 == 'B'
         || caseContent2 == 'A';
  }
  else{
  return caseContent2 == ' '
         || caseContent2 == 'F'  
         || caseContent2 == 'B'
         || caseContent2 == 'A';
  }
}

boolean isItem2_1(final Camera camera){ //when camera catch the item.
  final char caseContent2 = caseContent2(camera);
  return caseContent2 == 'A';
}

boolean isItem2_2(final Camera camera){ //when camera catch the item.
  final char caseContent2 = caseContent2(camera);
  return caseContent2 == 'B';
}

boolean isEnd2(final Camera camera){ //when camera approach to end point(S).
  final char caseContent2 = caseContent2(camera);
  return caseContent2 == 'S';
 }
/**
 * Returns the content of current case of the map.
 *
 * @param camera camera object
 *
 * @return character of content of the current case of the map
 */
char caseContent2(final Camera camera) {
  final int[] caseId2= currentCase2(camera);
  return map2[caseId2[0]][caseId2[1]];
}

/**
 * Returns the case (row & col) in which camera is currently situated.
 *
 * @param camera camera object
 *
 * @return array with row & col in which camera currently situated
 */
int[] currentCase2(final Camera camera) {
  final float[] position = camera.position();
  
  return new int[]{
    (int) (position[2] / CASE_SIZE2),
    (int) (position[0] / CASE_SIZE2) };
}
