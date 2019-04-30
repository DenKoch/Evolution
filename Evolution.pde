Grid grid;
ArrayList<Bot> bots;

boolean finished = true;
int bots_alive;

void setup() {
  grid = new Grid();
  bots = new ArrayList<Bot>(BOTS_COUNT);
  bots_alive = BOTS_COUNT;
  
  for(int i = 0; i < BOTS_COUNT; i++) {
    bots.add(new Bot());
  }
  
  size(1280, 720);
  background(0);
  noLoop();
}





void draw() {
  if (finished) {
    grid.deleteBotsFoodPoison();
    
    grid.placeFood(FOOD_COUNT);
    grid.placePoison(POISON_COUNT);
    
    grid.placeBots(BOTS_COUNT);

    finished = false;
  }

  grid.renderGrid();
  grid.renderBots(); 
}



void keyPressed() {
  if (keyCode == ENTER) {
    finished = true;
    redraw();
  }
  
  if(key == 'r') {
    redraw();
  }
  
  if(key >= '0' && key <= '9') {
    for (Bot cur_bot : bots) {
      cur_bot.step(int(key));
    }
    redraw();
  }
}
