
class Road {
  int x, y, drawX, drawY, distance, direction, progress, state;
  Road(int x, int y, int direction, int distance) {
    this.x = x;
    this.y = y;
    this.drawX = x;
    this.drawY = y;
    this.direction = direction;
    this.distance = distance;
    this.state = 0;
    this.progress = 0;
  }

  void update() {
    //check if empty
    //add pixel in direction
    switch(state) {
    case 0:
      //--- GROW if distance not yet completed
      if (progress < distance) {
        switch(direction) {
        case 0: //UP
          drawY--; 
          break;
        case 1: //RIGHT
          drawX++; 
          break;
        case 2: //DOWN
          drawY++; 
          break;
        case 3: //LEFT
          drawX--; 
          break;
        }
        progress++;
      } 
      else {
        state++;
      }
      break;
    case 1:
      //--- SPAWN
      break;
    }
  }
  void display() {
    switch(state) {
    case 0:
      //--- GROW
      stroke(255);
      point(drawX, drawY);
      break;
    case 1:
      //--- SPAWN
      spawnNewRoads(); //Do I need to check if on stage?
      break;
    }
  }

  void spawnNewRoads() {
    int oppDirection = direction - 2;
    if (oppDirection < 0) oppDirection += 4;
    println("== Spawn new roads at" + drawX + "," + drawY + " everyway but " + oppDirection);
    for (int i=0; i<4; i++) {
      if (i != oppDirection) {
        r = new Road(drawX, drawY, i, int(random(minLength, maxLength)));
        roads.add(r);
      }
    }
  }
}

