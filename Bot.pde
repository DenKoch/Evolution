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
    direction = 0;


    mind = new int[MIND_SIZE];
    for (int i = 0; i < MIND_SIZE; i++) {
      mind[i] = floor(random(64));
    }
    
  }

  public void setCoords(int x, int y) {
    this.x = x;
    this.y = y;
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
    if (new_adr >= MIND_SIZE)
      new_adr -= MIND_SIZE;

    adr = new_adr;
  }


  // =================================== одна итерация

  public void step() {
    if (this.health == 0) return;

    int cycles_count = 0;
    while (cycles_count < 10) {
      cycles_count++;

      int command = this.mind[adr];
      //println("command:" + str(command));

      if (command < 8)  // 0..7 сделать шаг
      {
        move(command);
        return;
      }
      if (command < 16) // 8..15 схватить/преобразовать
      {         
        fire(command);
        return;
      }
      if (command < 24) // 16..23 посмотреть
      {
        int xxx = x_from_pvector(command);
        int yyy = y_from_pvector(command);
        IncCommandAddress(matrix[x][y] + 1);
        continue;
      }
      if (command < 32) // 24..31 повернуть
      {
        command %= 8;
        //println("direction:" + str(direction));
        direction += command;
        if (direction > 7 )
        {  
          direction -= 8;
        }
        IncCommandAddress(1);
        continue;
      }
      IncCommandAddress(command); // 32..63 безусловный переход
    }
    
    if (decHealth(1) <= 0) {
      matrix[this.x][this.y] = 0;
      bots_alive--;
    }
  }



  // ===================================== движение

  public void move(int direction) {
    int x = x_from_pvector(direction);
    int y = y_from_pvector(direction);
    int h = matrix[x][y];

    if (h == 0) {
      matrix[this.x][this.y] = 0;
      matrix[x][y] = 2;
      this.x = x;
      this.y = y;
    } else if (h == 3) {
      incHealth(HEALTH_ADD);
      matrix[this.x][this.y] = 0;
      matrix[x][y] = 2;
      this.x = x;
      this.y = y;

      // todo: add new food/poison item
    } else if (h == 4) {
      decHealth(9999);
      matrix[this.x][this.y] = 0;
      bots_alive--;
      return;
    }

    if (decHealth(1) > 0) {
      IncCommandAddress(h + 1);
    } else {
      matrix[this.x][this.y] = 0;
      bots_alive--;
    }
  }

  // ============================================ схватить

  public void fire(int direction) {
    int x = x_from_pvector(direction);
    int y = y_from_pvector(direction);
    int h = matrix[x][y];

    if (h == 3) {
      matrix[x][y] = 0;
      incHealth(HEALTH_ADD);

      // todo: add new food/poison item
    } else if (h == 4) {
      matrix[x][y] = 3;
    }

    if (decHealth(1) > 0) {
      IncCommandAddress(h + 1);
    } else {
      matrix[this.x][this.y] = 0;
      bots_alive--;
    }
  }

  // -- получение Х-координаты рядом     ---------
  //  с ботом по направлению           -----------

  public int x_from_pvector(int direction) {
    int res = this.x;
    direction += this.direction;
    direction %= 8;

    if (direction == 0 ||direction == 6 || direction == 7) { 
      res--;
    } else  if (direction == 2 || direction == 3 || direction == 4) { 
      res++;
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
      res--;
    } else  if (direction == 4 || direction == 5 || direction == 6) { 
      res++;
    } 
    return res;
  }
}
