class Finish {
   float X, Y, W, H;
   
   Finish() {
      X = width - 50;
      Y = height / 2;
      W = 50;
      H = 50;
   }
   
   boolean checkCollision(float x, float y) {
     if(x >= X-W/2 && x <= X+W/2 && y >= Y-H/2 && y <= Y+H/2)
       return true;
     return false;
   }
}
