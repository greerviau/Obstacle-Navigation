class Wall {
   float W, H, X, Y;
  
   Wall(float w, float h, float x, float y) {
     W = w;
     H = h;
     X = x;
     Y = y;
   }
   
   boolean checkCollision(float x, float y) {
     if(x >= X-W/2 && x <= X+W/2 && y >= Y-H/2 && y <= Y+H/2)
       return true;
     return false;
   }
}
