class Population {
   Player[] players;
   int bestPlayerNo;
   int gen = 0;
   int minSteps = 100;
   Player bestPlayer;
   
   Population(int size) {
      players = new Player[size];
      for(int i = 0; i < players.length; i++) {
         players[i] = new Player(100); 
      }
   }
   
   void updateAlive() {
      for(int i = 0; i < players.length; i++) {
          if(!players[i].dead) {
             if(players[i].steps > minSteps) {
                players[i].dead = true;
             } else {
               players[i].look();
               players[i].think();
               players[i].update();
             }
          }
          players[i].show(); 
      }
   }
   
   void setBestPlayer() {
      float max = 0;
      int maxIndex = 0;
      for(int i = 0; i < players.length; i++) {
         if(players[i].fitness > max) {
            max = players[i].fitness;
            maxIndex = i;
         }
      }
      
      bestPlayerNo = maxIndex;
      
      if(players[bestPlayerNo].reachedFinish) {
          minSteps = players[bestPlayerNo].steps;
      }
   }
   
   boolean done() {
      for(int i = 0; i < players.length; i++) {
         if(!players[i].dead)
           return false;
      }
      return true;
   }
   
   void naturalSelection() {
      Player[] newPlayers = new Player[players.length];
      
      setBestPlayer();
      
      newPlayers[0] = players[bestPlayerNo].clone();
      newPlayers[0].isBest = true;
      for(int i = 1; i < players.length; i++) {
         if(i < players.length/2) {
           newPlayers[i] = selectPlayer().clone();
         } else {
           newPlayers[i] = selectPlayer().crossover(selectPlayer());
         }
         if(gen%5==0 && !players[bestPlayerNo].reachedFinish) {
           newPlayers[i].addMoves(50);
           minSteps += 50;
         }
         newPlayers[i].mutate();
      }
      players = newPlayers.clone();
      gen+=1;
   }
   
   Player selectPlayer() {
      long fitnessSum = 0;
      for(int i = 0; i < players.length; i++) {
         fitnessSum += players[i].fitness;
      }
      int rand = floor(random(fitnessSum));
      int runningSum = 0;
      for(int i = 0; i < players.length; i++) {
         runningSum += players[i].fitness;
         if(runningSum > rand)
           return players[i];
      }
      return players[0];
   }
   
   void mutate() {
      for(int i = 1; i < players.length; i++) {
         players[i].mutate(); 
      }
   }
   
   void calculateFitness() {
      for(int i = 1; i < players.length; i++) {
         players[i].calculateFitness(); 
      }
   }
}
