Grid grid;
ArrayList<Bot> bots;

boolean finished = true;
int bots_alive;
int generation_count;
int[] lastGenLiveSpan;
int current_lifespan = 0;

void setup() {
  grid = new Grid();
  bots = new ArrayList<Bot>(BOTS_COUNT);
  lastGenLiveSpan = new int[LAST_GEN_COUNT];
  for(int i = 0; i < LAST_GEN_COUNT; i++) {
    lastGenLiveSpan[i] = 0;
  }
  
  bots_alive = BOTS_COUNT;
  generation_count = 0;

  for (int i = 0; i < BOTS_COUNT; i++) {
    bots.add(new Bot());
  }
  size(1280, 720);
  textSize(12);
}


void draw() {
  background(0);
  
  //fill(255);
  //text("(" + mouseX + "," + mouseY + ")", mouseX, mouseY);
  
  if (finished) {
    generation_count++;
    
    updateInfo();
    current_lifespan = 0;
    
    grid.deleteBotsFoodPoison();
    grid.placeFood(FOOD_COUNT);
    grid.placePoison(POISON_COUNT);
    grid.placeBots(BOTS_COUNT);

    bots_alive = BOTS_COUNT;
    
    finished = false;
  }

  showInfo();

  grid.renderGridWalls();
  grid.renderFoodPoison();
  grid.renderBots();

  for (Bot cur_bot : bots) {
    cur_bot.step();
    grid.renderFoodPoison();
    grid.renderBots();

    if (bots_alive <= END_LIVE_COUNT) {
      finished = true;
      break;
    }
  }
  
  current_lifespan++;
}


void showInfo() {
  //textSize(20);
  fill(255);
  text(str(generation_count), 120, 160);
  
  for(int i = LAST_GEN_COUNT - 1; i >= 0; i--) {
    text(lastGenLiveSpan[i], 1150, 160 + (9 - i) * 22);
  }
  
  //textSize(12);
}

void updateInfo() {
  for(int i = 0; i < LAST_GEN_COUNT - 1; i++) {
    lastGenLiveSpan[i] = lastGenLiveSpan[i+1];
  }
  lastGenLiveSpan[LAST_GEN_COUNT - 1] = current_lifespan;
}
