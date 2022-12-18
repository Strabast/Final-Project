import processing.sound.*;
class Game {
  PVector playerPos;
  PVector[] projPos;
  PVector[] acc;
  int life;
  SoundFile hit;
  boolean isHit;

  int num = 20;
  int speed = 5;

  //Setup
  Game(float x, float y, int l) {
    playerPos = new PVector(x, y, 0);
    projPos = new PVector[num];
    life = l;
    acc = new PVector[num];
    isHit = false;
    hit = new SoundFile(FinalProject.this, "hurt.mp3");
    hit.amp(0.1);

    for (int i = 0; i < num; i++) {
      projPos[i] = new PVector(random(width), random(height), 50);
      acc[i] = new PVector(random(-speed, speed), random(-speed, speed), 0);
    }
  }
  
  //Player Movement and Screenwrapping
  void update() {
    if (keyPressed == true) {
      if (key =='w') {
        playerPos.sub(0, 3, 0);
      }
      if (key =='s') {
        playerPos.add(0, 3, 0);
      }
      if (key =='d') {
        playerPos.add(3, 0, 0);
      }
      if (key =='a') {
        playerPos.sub(3, 0, 0);
      }
    }

    if (playerPos.x > width) {
      playerPos.x = 0;
    }
    if (playerPos.x < 0) {
      playerPos.x = width;
    }
    if (playerPos.y > height) {
      playerPos.y = 0;
    }
    if (playerPos.y < 0) {
      playerPos.y = height;
    }
  }
  
  //Creation of player character
  void player() {
    rectMode(CENTER);
    fill(0, 255, 0);
    rect(playerPos.x, playerPos.y, 40, 40);
  }
  
  //Projectile behavior
  void projectile() {
    fill(255, 0, 0);
    ellipseMode(CENTER);
    for (int j = 0; j < num; j++) {
      projPos[j].add(acc[j]);
      ellipse(projPos[j].x, projPos[j].y, projPos[j].z, projPos[j].z);

      if (projPos[j].x > width - (projPos[j].z/2)||projPos[j].x < (projPos[j].z/2)) {
        acc[j].x = acc[j].x * -1;
      }

      if (projPos[j].y > height - (projPos[j].z/2)||projPos[j].y < (projPos[j].z/2)) {
        acc[j].y = acc[j].y * -1;
      }
      if (dist(projPos[j].x, projPos[j].y, playerPos.x, playerPos.y) < 10) {
        life--;
        hit.play();
        println(life);
        if (life < 0) {
          life = 0;
        }
      }
    }
  }
  
  //Shows how much life you have left
  void displayLives(){
    fill(0,255,0);
    textSize(50);
    text("Life: " + life,width/2 - 90,50);
  }
  
  //Checks to see if you still have lives, ends game if you don't
  boolean gameState() {
    boolean state = true;
    if (life <= 0 || key == '/') {
      state = false;
    }
    return state;
  }
}
