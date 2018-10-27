class Finish {
   float X, Y, W, H;
   
   Finish() {
      X = width - 10;
      Y = height / 2;
      W = 20;
      H = 20;
   }
   
   boolean checkCollision(float x, float y) {
     if(x >= X-W/2 && x <= X+W/2 && y >= Y-H/2 && y <= Y+H/2)
       return true;
     return false;
   }
}
