void gamePage() {
  
  // star
  background(0);
  speed = 10;
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
    if (!isAllowedCase(camera)) {
      camera.jump(position[0], CAMERA_Y, position[2]);  // reset previous position
    }
  }
  
  
  /* Pose camera */ 
  camera.feed();
    
    

  

  
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





// TODO: remake it
void mouseMoved() {
  camera.look(radians(mouseX - pmouseX) / 2.0, radians(mouseY - pmouseY) / 2.0);
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
  camera.dolly(0.5);
  final float[] position = camera.position();
  camera.jump(position[0], CAMERA_Y, position[2]);  // force attitude
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
  return 0;//map[caseIds[0]][caseIds[1]];
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
