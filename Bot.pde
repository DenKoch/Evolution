class Bot {

  public int[] mind;

  public int adr;
  public int x;
  public int y;
  public int health;
  public int direction;

  public void init(int x, int y) {
    adr = 0;
    this.x = x;
    this.y = y;
    health = 35;

    mind = new int[MIND_SIZE];
    for (int i = 0; i < MIND_SIZE; i++) {
      mind[i] = floor(random(64));
    }
  }

  // ================================= увеличение здоровья

  public int incHealth(int h) {
    health += h;
    if (health > HEALTH_MAX)
      health = HEALTH_MAX;

    return health;
  }

  // ================================= уменьшение здоровья

  public int decHealth(int h) {
    health -= h;
    if (health < 0)
      health = 0;

    return health;
  }

  // ================================= увеличение адреса команды

  public void IncCommandAddress(int a) {
    int new_adr = adr + a;
    if (new_adr > MIND_SIZE)
      new_adr -= MIND_SIZE;

    adr = new_adr;
  }

  public void step() {
    int x = this.x;
    int y = this.y;
  }

  public void move(int direction) {
    int x = (this.x +
  }


  // -- получение Х-координаты рядом     ---------
  //  с ботом по направлению           -----------

  public int x_from_pvector(int direction) {
    int res = this.x;
    direction += this.direction;
    direction %= 8;

    if (direction == 0 ||direction == 6 || direction == 7) { 
      res -= 1;
    } else  if (direction == 2 || direction == 3 || direction == 4) { 
      res += 1;
    } 
    return res;
  }

  // -- получение Y-координаты рядом     ---------
  //  с ботом по направлению           -----------

  public int y_from_pvector(int direction) {
    int res = this.y;
    direction += this.direction;
    direction %= 8;

    if (direction < 3) { 
      res -= 1;
    } else  if (direction == 2 || direction == 3 || direction == 4) { 
      res += 1;
    } 
    return res;
  }
}
