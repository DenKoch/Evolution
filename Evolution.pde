Grid grid;
ArrayList<Bot> bots;

boolean finished = true;
int bots_alive;
int generation_count;


void setup() {
  grid = new Grid();
  bots = new ArrayList<Bot>(BOTS_COUNT);
  bots_alive = BOTS_COUNT;

  for (int i = 0; i < BOTS_COUNT; i++) {
    bots.add(new Bot());
  }

  size(1280, 720);
  background(0);
  frameRate(60);
  //noLoop();
}





void draw() {
  if (finished) {
    generation_count++;
    updateInfo();

    grid.deleteBotsFoodPoison();
    grid.placeFood(FOOD_COUNT);
    grid.placePoison(POISON_COUNT);
    grid.placeBots(BOTS_COUNT);

    bots_alive = BOTS_COUNT;

    finished = false;
  }

  grid.renderGridWalls();
  grid.renderFoodPoison();
  grid.renderBots();

  for (Bot cur_bot : bots) {
    cur_bot.step();
    grid.renderFoodPoison();
    grid.renderBots();
    println(bots_alive);
    if (bots_alive <= END_LIVE_COUNT) {
      finished = true;
      break;
    }
  }
}

int checkLiveCount() {
  int result = 0;

  for (Bot bot : bots) {
    if (bot.health > 0)
      result++;
  }

  return result;
}

void updateInfo() {
  fill(255);
  textAlign(CENTER, CENTER);
  text(str(b.health), GetX(b.x), GetY(b.y), cell_size, cell_size);
}


void keyPressed() {
  if (keyCode == ENTER) {
    finished = true;
    //redraw();
  }

  if (key == 'r') {
    //redraw();
  }

  if (key >= '0' && key <= '9') {
    for (Bot cur_bot : bots) {
      //println(str(bots.indexOf(cur_bot)) + ' ' + str(cur_bot.health));
      //println(cur_bot.mind);
      cur_bot.move(key);
      //cur_bot.step();
    }
    //redraw();
  }
}
