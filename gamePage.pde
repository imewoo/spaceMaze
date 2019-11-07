void gamePage() {
  
  // star
  background(0);
  speed = 10;
  translate(mouseX, mouseY);
  for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }
}
