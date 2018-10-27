class Player {
  
  PVector pos, vel, acc;
  float r = 2.5;
  boolean dead = false;
  boolean reachedFinish = false;
  boolean isBest = false;
  
  float score;
  float fitness;
  
  Wall wall;
  Finish finish;
  Brain brain;
  
  Player() {
    pos = new PVector(100,height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    wall = new Wall(100, 400, 300, 300);  
    finish = new Finish();
    brain = new Brain(500);
  }
  
  boolean checkCollisions() {
     if(wall.checkCollision(pos.x+r,pos.y+r) || wall.checkCollision(pos.x-r,pos.y+r) || wall.checkCollision(pos.x+r,pos.y-r) || wall.checkCollision(pos.x-r,pos.y-r))
        return true;
     if(pos.x-r <= 0 || pos.x+r >= width || pos.y+r >= height || pos.y-r <= 0)
        return true;
     return false;
  }
  
  boolean checkReachedFinish() {
     if(finish.checkCollision(pos.x+r,pos.y+r) || finish.checkCollision(pos.x-r,pos.y+r) || finish.checkCollision(pos.x+r,pos.y-r) || finish.checkCollision(pos.x-r,pos.y-r))
        return true;
     return false;
  }
  
  void move() { 
    if(brain.steps < brain.directions.length) {
      acc = brain.directions[brain.steps];
      brain.steps++;
    } else {
      dead = true; 
    }
    vel.add(acc);
    vel.limit(4);
    pos.add(vel);
  }
  
  void show() {
     rectMode(CENTER);
     if(isBest)
       fill(0,0,255);
     else
       fill(255,0,0);
     rect(pos.x,pos.y,5,5); 
     //Draw Wall
     fill(0,0,0);
     rect(wall.X, wall.Y, wall.W, wall.H);
     //Draw Finish
     fill(0,255,0);
     rect(finish.X,finish.Y,20,20);
  }
  
  void update() {
    if(!dead && !reachedFinish) {
      move();
      if(checkCollisions()) {
         dead = true; 
      } else if(checkReachedFinish()) {
         reachedFinish = true; 
      }
    }
  }
  
  Player clone() {
      Player clone = new Player();
      clone.brain = brain.clone();
      return clone;
  }
  
  void calculateFitness() {
    if(reachedFinish) {
       fitness = 1.0/16.0 + 10000.0/(float)(brain.steps*brain.steps); 
    } else {
      float dist = dist(pos.x,pos.y,finish.X,finish.Y);
      fitness = 1.0/(dist*dist); 
      //fitness *= steps;
    }
  }
}
