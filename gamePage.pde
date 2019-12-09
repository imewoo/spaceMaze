// page = 1
float angle = 0;
float scale=1;

int abc=1;
boolean abc_flag=true;


void gamePage() {
 
   x++;
 
  if(abc_flag){
    abc++;
    if(abc==30){
      abc_flag=false;
    }
  }
  else if(!abc_flag){
    abc--;
    if(abc==1){
      abc_flag=true;
    }
  }
  
  //println(abc);
  
  cameraflag=0;
  
  
  // star
  camera2.feed();
  background(0);
  speed = 2;
  translate(width/2, height/2, 0);
  for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }
   
  float[] position = camera.position();
      
  /* Navigate camera */
  if (keyPressed && key == CODED) {
    
    switch (keyCode) {
      case UP:        onStepForward(camera);        break;
      case DOWN:        onStepBackward(camera);        break;
      case LEFT:        onStepLeft(camera);        break;
      case RIGHT:        onStepRight(camera);        break;
    }
    
    /* If we are in non allowed area (wall, tree or water) cancel the movement */
    if (!isAllowedCase(camera)) { // if not allowed to move 
      camera.jump(position[0], CAMERA_Y, position[2]);  // reset previous position
    }
    
    /*
    if(isItem(camera)){ //eat item = count++;
      drawItemCheck();
      count++; //initialized count = 5
    }*/
    
    //This code will be completed after ending ItemCheck function.
    //count == 0 & approach to 'S'
    //In this case, 'S' is the end point.
    if(count==5 && isEnd(camera)){ 
      selectflag=true;
      
      camX = position[0];
      camZ = position[2];
      CAMERA_Y = -5;
     
     page = 5; // selectGamePage
     bgm.loop();
    }
    
    //println(count);
  }
  
  
    /* Pose camera */ 
  camera.feed();
  
  
  
  
  if(mapflag==1){
  /* Draw map */
    for (int row = 0; row < map.length; row++) {
      pushMatrix();
      translate(0, 0, row * CASE_SIZE);
      
      for (int col = 0; col < map[row].length; col++) {
        pushMatrix();
        translate(col * CASE_SIZE, 0, 0);
        
        switch (map[row][col]) {
          case '#': drawWall(); break; //wall 
          case 'A': drawItem(); break; //item 1
          case 'B': drawItem2(); break;  //item 2
          case 'C': drawItem3(); break;  //item 3
          case 'D': drawItem4(); break;  //item 4
          case 'E': drawItem5(); break;  //item 5
          //case '%': drawEnemy();  break; //enemy
          case 'S': drawEndPoint(); break; //end point
          case 'G': drawGround(); break; //ground
          
          case '@': drawEnemyPoint(); break;
          default: break;
        }
  
        popMatrix();
      }
      
      popMatrix();
    }
   }
   
   else if(mapflag==2){
     /* Draw map */
    for (int row = 0; row < map2.length; row++) {
      pushMatrix();
      translate(0, 0, row * CASE_SIZE);
      
      for (int col = 0; col < map2[row].length; col++) {
        pushMatrix();
        translate(col * CASE_SIZE, 0, 0);
        
        switch (map2[row][col]) {
          case '#': drawWall(); break; //wall 
          case 'A': drawItem(); break; //item 1
          case 'B': drawItem2(); break;  //item 2
          case 'C': drawItem3(); break;  //item 3
          case 'D': drawItem4(); break;  //item 4
          case 'E': drawItem5(); break;  //item 5
          //case '%': drawEnemy();  break; //enemy
          case 'S': drawEndPoint(); break; //end point
          case 'G': drawGround(); break; //ground
          
          case '@': drawEnemyPoint(); break;
          default: break;
        }
  
        popMatrix();
      }
      
      popMatrix();
    }
   }
   
    else if(mapflag==3){
     /* Draw map */
    for (int row = 0; row < map3.length; row++) {
      pushMatrix();
      translate(0, 0, row * CASE_SIZE);
      
      for (int col = 0; col < map3[row].length; col++) {
        pushMatrix();
        translate(col * CASE_SIZE, 0, 0);
        
        switch (map3[row][col]) {
          case '#': drawWall(); break; //wall 
          case 'A': drawItem(); break; //item 1
          case 'B': drawItem2(); break;  //item 2
          case 'C': drawItem3(); break;  //item 3
          case 'D': drawItem4(); break;  //item 4
          case 'E': drawItem5(); break;  //item 5
          //case '%': drawEnemy();  break; //enemy
          case 'S': drawEndPoint(); break; //end point
          case 'G': drawGround(); break; //ground
          
          case '@': drawEnemyPoint(); break;
          default: break;
        }
  
        popMatrix();
      }
      
      popMatrix();
    }
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
  stroke(255); //line color = white
  strokeWeight(5); // line size = 10
  
  vertex(0, 0, 0, 0, 0);
  vertex(CASE_SIZE, 0, 0, 1, 0);
  vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
  vertex(0, 0, CASE_SIZE, 0, 1);
  
  endShape();
  noFill();
}

void drawEndPoint() {
  if(count==5){
    beginShape(QUADS);  
    texture(GROUND_TEXTURE);
    stroke(255); //line color = white
    strokeWeight(5); // line size = 10
    vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
    vertex(CASE_SIZE, 0, 0, 1, 0);
    vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
    vertex(0, 0, CASE_SIZE, 0, 1);
    endShape();
    noFill();
    
  }else{
    beginShape(QUADS);  
    vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
    vertex(CASE_SIZE, 0, 0, 1, 0);
    vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
    vertex(0, 0, CASE_SIZE, 0, 1);
    endShape();
    noFill();
  }
  
}

void drawEnemyPoint() {
 
  if(abc>=15){
    if(abc>15 && abc<25 && !abc_flag){
      beginShape(QUADS);  
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      fill(255,255,0);
      //texture(GROUND_TEXTURE);
      vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();
    }
    else{
      beginShape(QUADS); //rectangle
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      vertex(0, 0, 0, 0, 0);
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();
     }
   }
   
   else if(abc<20){
      beginShape(QUADS); //rectangle
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      fill(255,0,0);
      vertex(0, 0, 0, 0, 0);
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();
      
      
      
      float y=cos(x+0.1);  
      pushMatrix();
      translate((-CASE_SIZE / 2) +10, -CASE_SIZE / 2, (y*CASE_SIZE / 6)+5); //center of block
      
      //translate(CASE_SIZE/2, -CASE_SIZE/2, CASE_SIZE/2); // 20, -5, 5

      scale(0.05);
      translate(0,25,0);
      rotateX(PI);
      rotateZ(PI/6);
      rotateY(PI/2);
      //rotateZ(PI/2*3);
      //lights();
      shape(Spider, 0, 0); 
      popMatrix();
    
      noFill();
    
   }
}


void drawItem(){
  if(isItem(camera) && flag1_1 && mousePressed){ //eat item = count++;
      drawItemCheck();
      a=0;
      count++; //initialized count = 5
      flag1_1 =false;
    }
  else{
     beginShape(QUADS); //rectangle
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      vertex(0, 0, 0, 0, 0);
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();

 final Ellipsoid item = new Ellipsoid(this, 20, 30);
      item.setTexture(ITEM_TEXTURE);
      item.drawMode(Shape3D.TEXTURE);
      item.setRadius(a*CASE_SIZE / 4);
      
      
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
      rotateY(angle*4);
      translate(2,3,0);
      translate(CASE_SIZE / 12, 0, CASE_SIZE / 12); //center of block
       item.draw();
    boolean flag2=true;
   
      
      
      //for game optimization
      if(angle < 7){
        angle ++;
      }else{
        angle=0;
      }
      angle++;
      popMatrix();
      noFill();
    }
}

void drawItem2(){

    if(isItem2(camera) && flag1_2 && mousePressed){ //eat item = count++;
      drawItemCheck();
      b=0;
      count++; //initialized count = 5
      flag1_2 = false;
    }
    
    else{
      beginShape(QUADS); //rectangle
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      vertex(0, 0, 0, 0, 0);
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();
      
      float y=cos(x+0.1);  
      final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      //final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item2.setTexture(ITEM_TEXTURE);
      item2.drawMode(Shape3D.TEXTURE);
      item2.setRadius(b*CASE_SIZE / 4);
      
      pushMatrix();
      translate((y*CASE_SIZE / 6)+5, -CASE_SIZE / 2, (y*CASE_SIZE / 6)+5); //center of block
      rotateY(angle);
      item2.draw();
      //scale(b*0.2);
      rotateX(PI/2);
      //shape(Heart,0,0);
      
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

void drawItem3(){

    if(isItem3(camera) && flag1_3 && mousePressed){ //eat item = count++;
      drawItemCheck();
      c=0;
      count++; //initialized count = 5
      flag1_3 = false;
    }
    
    else{
      beginShape(QUADS); //rectangle
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      vertex(0, 0, 0, 0, 0);
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();
      
       final Ellipsoid item3 = new Ellipsoid(this, 20, 30);
      //final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item3.setTexture(ITEM_TEXTURE);
      item3.drawMode(Shape3D.TEXTURE);
      item3.setRadius(c*CASE_SIZE / 4);
      
      float y=cos(x+0.1);
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
      scale(cos(y)/2);
      rotateX(PI/2);
      rotateY(angle);
      item3.draw();
      //scale(0.2*c);
      //shape(Heart, 0, 0);
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
void drawItem4(){

    if(isItem4(camera) && flag1_4 && mousePressed){ //eat item = count++;
      drawItemCheck();
      d=0;
      count++; //initialized count = 5
      flag1_4 = false;
    }
    
    else{
      beginShape(QUADS); //rectangle
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      vertex(0, 0, 0, 0, 0);
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();
      
      final Ellipsoid item4 = new Ellipsoid(this, 20, 30);
      //final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item4.setTexture(ITEM_TEXTURE);
      item4.drawMode(Shape3D.TEXTURE);
      item4.setRadius(d*CASE_SIZE / 4);
      
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
      rotateY(angle);
      item4.draw();
      rotateX(PI/2);
      //scale(0.2*d);
      //shape(Heart,0,0);
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
void drawItem5(){

    if(isItem5(camera) && flag1_5 && mousePressed){ //eat item = count++;
      drawItemCheck();
      e=0;
      count++; //initialized count = 5
      flag1_5 = false;
    }
    
    else{
      beginShape(QUADS); //rectangle
      stroke(255); //line color = white
      strokeWeight(5); // line size = 10
      vertex(0, 0, 0, 0, 0);
      vertex(CASE_SIZE, 0, 0, 1, 0);
      vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
      vertex(0, 0, CASE_SIZE, 0, 1);
      endShape();
      noFill();
      
      final Ellipsoid item5 = new Ellipsoid(this, 20, 30);
      //final Ellipsoid item2 = new Ellipsoid(this, 20, 30);
      item5.setTexture(ITEM_TEXTURE);
      item5.drawMode(Shape3D.TEXTURE);
      item5.setRadius(e*CASE_SIZE / 4);
      
      pushMatrix();
      translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2); //center of block
      rotateY(angle);
      rotateX(PI/3);
      item5.draw();
      
      //scale(0.2*e);
      //shape(Heart,0,0);
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
  //texture(GROUND_TEXTURE);
    fill(240,70,180);
  vertex(0, 0, 0, 0, 0); //vertex(x, y, z, horizontal, vertical)
  vertex(CASE_SIZE, 0, 0, 1, 0);
  vertex(CASE_SIZE, 0, CASE_SIZE, 1, 1);
  vertex(0, 0, CASE_SIZE, 0, 1);
  endShape();
  noFill();
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
boolean isAllowedCase(final Camera camera) { //if blank, 'S', 'F', '@', 'A' allowed to go!
  final char caseContent = caseContent(camera);
  //if user does not eat the item, end gate does not open
  if(count==5){
      return caseContent == 'G'
             || caseContent == 'S'
             || caseContent == 'A'
             || caseContent == 'B'
             || caseContent == 'C'
             || caseContent == 'D'
             || caseContent == 'E'
             || caseContent == '%'; //'%' is enemy
  }
  else{

    if(abc>15){

      return caseContent == 'G'
             || caseContent == 'S'
             || caseContent == 'A'
             || caseContent == 'B'
             || caseContent == 'C'
             || caseContent == 'D'
             || caseContent == 'E'
             || caseContent == '%'
             || caseContent == '@'; //'%' is enemy
    }else{
      return caseContent == 'G'  
             || caseContent == 'A'
             || caseContent == 'B'
             || caseContent == 'C'
             || caseContent == 'D'
             || caseContent == 'E'
             || caseContent == '%'; //'%' is enemy
    }
  }
}

boolean isItem(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == 'A';
}

boolean isItem2(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == 'B';
}
boolean isItem3(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == 'C';
}
boolean isItem4(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == 'D';
}
boolean isItem5(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == 'E';
}

boolean isEnemy(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == '%';
}

boolean isEnemy_Ground(final Camera camera){ //when camera catch the item.
  final char caseContent = caseContent(camera);
  return caseContent == '@';
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
    if(mapflag==1){
      return map[caseId[0]][caseId[1]];
    }
    else if(mapflag==2){
       return map2[caseId[0]][caseId[1]];
    }
    else {
       return map3[caseId[0]][caseId[1]];
    }
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
