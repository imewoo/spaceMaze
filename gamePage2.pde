// page = 6
//int timeCount2=0; //time count
//int die_timeCount2=0; //if game end, timeCount2 remain

//int frameConstant2=300; //initialize fps
//int game_end_confirm2=1; //set end
//float delta2 = 0.0f ;

float angle2 = 0;
//float aVelocity2 = 0;
//float aAcceleration2 = 0.001;

void gamePage2() {
   
  cameraflag=1; // for mouseMoved
    
  // star
  background(0);
  speed = 2;
  translate(width/2, height/2, 0);
  //translate(mouseX, mouseY,0);
  for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }
  
  /* Pose camera3 */ 
  camera3.feed();
  
  /* Navigate camera3 */
  if (keyPressed && key == CODED) {
    final float[] position2 = camera3.position();
    
    switch (keyCode) {
      case UP:
        onStepForward2(camera3);
        break;
      case DOWN:
        onStepBackward2(camera3);
        break;
       case LEFT:
        onStepLeft2(camera3);
        break;
      case RIGHT:
        onStepRight2(camera3);
        break;
    }
    
    /* If we are in non allowed area (wall, tree or water) cancel the movement */
    if (!isAllowedCase2(camera3)) { // if not allowed to move 
      camera3.jump(position2[0], CAMERA_YY, position2[2]);  // reset previous position2
    }
    
    /*
    if(isItem2_1(camera3)){ //eat item = count--;
      drawItem2_1Check();
      count--; //initialized count = 5
    }*/
    
    //This code will be completed after ending ItemCheck function.
    //count == 0 & approach to 'S'
    //In this case, 'S' is the end point.
    if(count2==0 && isEnd2(camera3)){ 
      selectflag=true;
     page = 5;
     bgm.loop();
    }
    
    println("2 = " +count2);
  }
  
  
    
    
  /* Draw map */
    for (int row = 0; row < map2.length; row++) {
      pushMatrix();
      translate(0, 0, row * CASE_SIZE);
      
      for (int col = 0; col < map2[row].length; col++) {
        pushMatrix();
        translate(col * CASE_SIZE, 0, 0);
        
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
  
  if(isItem2_1(camera3) && flag3 && mousePressed){ //eat item = count--;
      drawItem2_1Check();
      aa=aa/2;
      count2--; //initialized count = 5
      flag3 =false;
    }
    
    else{
      final Ellipsoid item = new Ellipsoid(this, 20, 30);
      item.setTexture(ITEM_TEXTURE);
      item.drawMode(Shape3D.TEXTURE);
      item.setRadius(aa*CASE_SIZE / 4);
    
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
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

    if(isItem2_2(camera3) && flag4 && mousePressed){ //eat item = count--;
      drawItem2_1Check();
      bb=bb/2;
      count2--; //initialized count = 5
      flag4 = false;
    }
    
    else{
      final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item2.setTexture(ITEM_TEXTURE);
      item2.drawMode(Shape3D.TEXTURE);
      item2.setRadius(bb*CASE_SIZE / 4);
    
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



/**
 * Handler of command to move camera3 forward.
 *
 * @param camera3 camera3 object
 */
void onStepForward2(final Camera camera3) {
  camera3.dolly(-0.5);
  final float[] position2 = camera3.position();
  camera3.jump(position2[0], CAMERA_YY, position2[2]);  // force attitude
}

/**
 * Handler of command to move camera3 backward.
 *
 * @param camera3 camera3 object
 */
void onStepBackward2(final Camera camera3) {
  camera3.dolly(0.5); //camera3.dolly(distance)
  final float[] position2 = camera3.position();
  camera3.jump(position2[0], CAMERA_YY, position2[2]);  // force attitude    //jump(locationX, locationY, locationZ)
}

/**
 * Handler of command to move camera3 left.
 *
 * @param camera3 camera3 object
 */
void onStepLeft2(final Camera camera3) {
  camera3.truck(-0.5);
}

/**
 * Handler of command to move camera3 right.
 *
 * @param camera3 camera3 object
 */
void onStepRight2(final Camera camera3) {
  camera3.truck(0.5);
}

/**
 * Checks if camera3 is in allowed map case.
 *
 * @param camera3 camera3 object
 *
 * @return true - camera3 is in allowed map case, false - not.
 */
boolean isAllowedCase2(final Camera camera3) { //if blank, 'S', 'F', '@', '^' allowed to go!
  final char caseContent2 = caseContent2(camera3);
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

boolean isItem2_1(final Camera camera3){ //when camera3 catch the item.
  final char caseContent2 = caseContent2(camera3);
  return caseContent2 == 'A';
}

boolean isItem2_2(final Camera camera3){ //when camera3 catch the item.
  final char caseContent2 = caseContent2(camera3);
  return caseContent2 == 'B';
}

boolean isEnd2(final Camera camera3){ //when camera3 approach to end point(S).
  final char caseContent2 = caseContent2(camera3);
  return caseContent2 == 'S';
 }
/**
 * Returns the content of current case of the map.
 *
 * @param camera3 camera3 object
 *
 * @return character of content of the current case of the map
 */
char caseContent2(final Camera camera3) {
  final int[] caseId2= currentCase2(camera3);
  return map2[caseId2[0]][caseId2[1]];
}

/**
 * Returns the case (row & col) in which camera3 is currently situated.
 *
 * @param camera3 camera3 object
 *
 * @return array with row & col in which camera3 currently situated
 */
int[] currentCase2(final Camera camera3) {
  final float[] position2 = camera3.position();
  
  return new int[]{
    (int) (position2[2] / CASE_SIZE),
    (int) (position2[0] / CASE_SIZE) };
}
