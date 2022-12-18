import processing.sound.*;
PVector playerLoc;
PImage grid;
Game game;
int score;
int lives = 50;

void setup() {
  size(600, 600);
  playerLoc = new PVector(width/2, height/2, 0);
  game = new Game(playerLoc.x, playerLoc.y, lives);
  score = 0;
  grid = loadImage("grid.png");
}

//Game's functions
void draw() {
  if (game.gameState() == true) {
    image(grid,0,0);
    game.update();
    game.player();
    game.projectile();
    game.displayLives();
    score++;
    text(score, 260, 580);
  }
  
  //Game Over screen
  if (game.gameState() == false) {
    background(0);
    fill(255);
    textSize(50);
    text("Press R to Restart", width/6, height/2);
    textSize(20);
    text("Score: " + score, 250, 350);
    
    //Restart game
    if (key == 'r') {
      game = new Game(playerLoc.x, playerLoc.y, lives);
      score = 0;
    }
  }
}
