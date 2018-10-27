class Player {

  float x, y, r;
  float xSpd, ySpd, spd;
  boolean dead = false;
  int startingMoves = 0;
  int moves = 0;
  boolean reachedFinish = false;
  boolean isBest = false;
  
  float score;
  float fitness;
  
  int steps = 0;
  
  float[] vision = new float[8];
  float[] decision = new float[8];
  
  Wall wall;
  Finish finish;
  NeuralNet brain;
  
  Player() {
    x = 50;
    y = height/2;
    r = 10;
    spd = 2;
    xSpd = spd;
    wall = new Wall(100, 300, 300, 300);  
    finish = new Finish();
    brain = new NeuralNet(8, 16, 8);
  }
  
  Player(int m) {
    x = 50;
    y = height/2;
    r = 10;
    spd = 2;
    xSpd = spd;
    startingMoves = m;
    moves = startingMoves;
    wall = new Wall(100, 300, 300, 300);  
    finish = new Finish();
    brain = new NeuralNet(8, 16, 8);
  }
  
  boolean checkCollisions() {
     if(wall.checkCollision(x+r,y+r) || wall.checkCollision(x-r,y+r) || wall.checkCollision(x+r,y-r) || wall.checkCollision(x-r,y-r))
        return true;
     if(x-r <= 0 || x+r >= width || y+r >= height || y-r <= 0)
        return true;
     return false;
  }
  
  boolean checkReachedFinish() {
     if(finish.checkCollision(x+r,y+r) || finish.checkCollision(x-r,y+r) || finish.checkCollision(x+r,y-r) || finish.checkCollision(x-r,y-r))
        return true;
     return false;
  }
  
  void move() { 
    if(!dead && moves > 0 && !reachedFinish) {
      x+=xSpd;
      y+=ySpd;
      moves--;
      steps++;
    } else {
       die(); 
    }
  }
  
  void show() {
     if(isBest)
       fill(0,0,255);
     else
       fill(255,0,0);
     rect(x,y,20,20); 
     //Draw Wall
     fill(0,0,0);
     rect(wall.X, wall.Y, wall.W, wall.H);
     //Draw Finish
     fill(0,255,0);
     rect(finish.X,finish.Y,50,50);
  }
  
  void update() {
    move();
    checkPositions();
  }
  
  void checkPositions() {
      if(checkCollisions()) {
         die(); 
      }
      if(checkReachedFinish()) {
         reachedFinish = true; 
      }
  }
  
  void calculateFitness() {
    if(reachedFinish) {
       fitness = 10000000.0/(float)(steps*steps); 
    } else {
      float dist = dist(x,y,finish.X,finish.Y);
      fitness = 1.0/(dist*dist); 
      //fitness *= steps;
    }
  }  
  
  void mutate() {
     brain.mutate(globalMutationRate); 
  }
  
  Player clone() {
     Player clone = new Player(startingMoves);
     clone.brain = brain.clone();
     return clone;
  }
  
  Player crossover(Player parent2) {
    Player child = new Player(startingMoves);
    child.brain = brain.crossover(parent2.brain);
    return child;
  }
  
  void look() {
     vision = new float[8];
     PVector direction;
     for(int i = 0; i < vision.length; i++) {
        direction = PVector.fromAngle(i*(PI/4));
        direction.mult(10);
        vision[i] = lookInDirection(direction);
     }
  }
  
  float lookInDirection(PVector direction) {
     PVector position = new PVector(x,y);
     float distance = 0;
     position.add(direction);
     distance+=1;
     
     while(distance < 60) {
         if(wall.checkCollision(position.x,position.y)) {
            return 1/distance; 
         }
         if(position.x >= width || position.x <= 0 || position.y >= height || position.y <= 0) {
            return 1/distance; 
         }
         
         position.add(direction);
         
         distance += 1;
     }
     return 0;
  }
  
  void think() {
     decision = brain.output(vision);
     int max = 0;
     for(int i = 1; i < decision.length; i++) {
         if(decision[i] > decision[max]) {
            max = i; 
         }
     }
     switch(max) {
        case 0:
          moveUp();
          break;
        case 1: 
          moveDown();
          break;
        case 2: 
          moveLeft();
          break;
        case 3:
          moveRight();
          break;
        case 4: 
          moveUpLeft();
          break;
        case 5: 
          moveDownLeft();
          break;
        case 6: 
          moveUpRight();
          break;
        case 7: 
          moveDownRight();
          break;
     }
  }  

  
  void die() { dead = true; }
  
  void addMoves(int newMoves) { startingMoves += newMoves; }
  
  void moveUp() { xSpd = 0; ySpd = -spd; }
  void moveDown() { xSpd = 0; ySpd = spd; }
  void moveLeft() { xSpd = -spd; ySpd = 0; }
  void moveRight() { xSpd = spd; ySpd = 0; }
  void moveUpLeft() { xSpd = -spd; ySpd = -spd; }
  void moveUpRight() { xSpd = spd; ySpd = -spd; }
  void moveDownLeft() { xSpd = -spd; ySpd = spd; }
  void moveDownRight() { xSpd = spd; ySpd = spd; }
}
