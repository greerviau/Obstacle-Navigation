Population pop;

float globalMutationRate = 0.01;

void setup() {
   size(600,600);
   pop = new Population(300);
}

void draw() {
  background(255);
  if(!pop.done()) {
      pop.update();
      pop.show();
  } else {
      pop.calculateFitness();
      pop.naturalSelection();
      pop.mutate();
  }
  showData();
}

void showData() {
   textSize(14);
   fill(0);
   textAlign(LEFT);
   text("Press 'd' to Double Mutation Rate", width-250, height-40);
   text("Press 'h' to Half Mutation Rate", width-250, height-20);
   textSize(20);
   textAlign(RIGHT);
   text("Generation: "+pop.gen, width-50,20);
   text("Population Size: "+pop.players.length, width-50,40);
   textAlign(LEFT);
   text("Mutation Rate: "+globalMutationRate, 50,20);
   text("Max Steps: "+pop.minSteps, 50,40);
}

void keyPressed() {
   if(key == 'd')
     globalMutationRate *= 2;
   if(key == 'h')
     globalMutationRate = globalMutationRate / 2;
}
