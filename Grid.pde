int[][] matrix = new int[grid_width][grid_height];

public class Grid {
  int min_x = width/2 - grid_width * cell_size / 2;
  int min_y = height/2 - grid_height * cell_size / 2;
  int max_x = width/2 + grid_width * cell_size / 2;
  int max_y = height/2 + grid_height * cell_size / 2;


  public Grid() {
    for (int i = 0; i < grid_width; i++) {
      for (int j = 0; j < grid_height; j++) {
        matrix[i][j] = 0;
      }
    }

    placeWalls();
  }

  //       0 если пусто
  //       1 если стена
  //       2 если бот
  //       3 если еда
  //       4 если яд


  // --------------------------------------- Рендер сетки и всего на ней

  public void renderGrid() {
    for (int i = 0; i < grid_width; i++) {
      for (int j = 0; j < grid_height; j++) {
        if (matrix[i][j] == 0) fill(empty);
        else if (matrix[i][j] == 1) fill(wall);
        else if (matrix[i][j] == 3) fill(food);
        else fill(poison);
        square(GetX(i), GetY(j), cell_size);
      }
    }
  }

  // --------------------------------------- Рендер ботов

  public void renderBots() {
    for (Bot b : bots) {
      if (b.health == 0) continue;
      fill(bot);
      square(GetX(b.x), GetY(b.y), cell_size);
      fill(255);
      textAlign(CENTER, CENTER);
      text(str(b.health), GetX(b.x), GetY(b.y), cell_size, cell_size);
    }
  }

  // --------------------------------------- Добавить стены

  public void placeWalls() {
    for (int i = 0; i < grid_height; i++) {
      SetWall(0, i);
      SetWall(grid_width - 1, i);
    }
    for (int i = 0; i < grid_width; i++) {
      SetWall(i, 0);
      SetWall(i, grid_height - 1);
    }    
    for (int i = 5; i < 14; i++) {
      SetWall(7, i);
    }    
    for (int i = 7; i < 18; i++) {
      SetWall(32, i);
    }    
    for (int i = 12; i < 22; i++) {
      SetWall(20, i);
    }
  }

  // --------------------------------------- Добавить еду

  public void placeFood(int count) {
    int i = 0;
    while (i < count) {
      int x = generateX();
      int y = generateY();
      if (matrix[x][y] == 0) {
        SetFood(x, y);
        i++;
      }
    }
  }

  // --------------------------------------- Добавить яд

  public void placePoison(int count) {
    int i = 0;
    while (i < count) {
      int x = generateX();
      int y = generateY();
      if (matrix[x][y] == 0) {
        SetPoison(x, y);
        i++;
      }
    }
  }

  public void placeBots(int count) {
    int i = 0;
    while (i < count) {
      int x = generateX();
      int y = generateY();
      if (matrix[x][y] == 0) {
        matrix[x][y] = 2;
        bots.get(i).init(x, y);
        i++;
      }
    }
  }

  public void deleteBotsFoodPoison() {
    for (int i = 0; i < grid_width; i++) {
      for (int j = 0; j < grid_height; j++) {
        matrix[i][j] = 0;
      }
    }

    placeWalls();
  }





  public void SetWall(int index_x, int index_y) {
    matrix[index_x][index_y] = 1;
  }

  public void SetFood(int index_x, int index_y) {
    matrix[index_x][index_y] = 3;
  }

  public void SetPoison(int index_x, int index_y) {
    matrix[index_x][index_y] = 4;
  }

  public void SetBot(int index_x, int index_y) {
    matrix[index_x][index_y] = 2;
  }




  public int GetX(int index_x) {
    return (min_x + index_x * cell_size);
  }

  public int GetY(int index_y) {
    return (min_y + index_y * cell_size);
  }

  public int generateX() {
    return floor(random(grid_width));
  }

  public int generateY() {
    return floor(random(grid_height));
  }
}
