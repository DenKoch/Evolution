Grid grid;
ArrayList<Bot> bots;

boolean finished = true;

void setup() {
  grid = new Grid();
  bots = new ArrayList<Bot>(BOTS_COUNT);
  
  for(int i = 0; i < BOTS_COUNT; i++) {
    bots.add(new Bot());
  }
  
  size(1280, 720);
  background(0);
  //frameRate(10);
  noLoop();
}





void draw() {
  //background(0);
  if (finished) {
    grid.deleteBotsFoodPoison();
    
    grid.placeFood(FOOD_COUNT);
    grid.placePoison(POISON_COUNT);
    
    grid.placeBots(BOTS_COUNT);

    finished = false;
  }

  grid.renderGrid();
  grid.renderBots();


/*
  if (!finished) {
    for (Bot cur_bot : bots) {
      cur_bot.step();
    }
  }*/
  
}



void keyPressed() {
  if (keyCode == ENTER) {
    finished = true;
    redraw();
  }
  if(key == 'r') {
    redraw();
  }
}
