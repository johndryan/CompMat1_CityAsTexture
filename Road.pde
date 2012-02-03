class Road {
  int x, y, drawX, drawY, distance, direction, progress, state, buildDiffX, buildDiffY;
  Road(int x, int y, int direction, int distance) {
    this.x = x;
    this.y = y;
    this.drawX = x;
    this.drawY = y;
    this.direction = direction;
    this.distance = distance;
    this.state = 0;
    this.progress = 0;
    this.buildDiffX = 0;
    this.buildDiffY = 0;
    switch(direction) {
      case 0: //UP
        this.buildDiffX = roadWidth/2+1; 
        break;
      case 1: //RIGHT
        this.buildDiffY = roadWidth/2+1;
        break;
      case 2: //DOWN
        this.buildDiffX = -(roadWidth/2+1); 
        break;
      case 3: //LEFT
        this.buildDiffY = -(roadWidth/2+1);
        break;
    }
  }

  void update() {
    switch(state) {
      case 0:
        //--- GROW if distance not yet completed
        if (progress < distance) {
          advance(1);
          progress++;
          // Are we still on stage?
          if (drawX <= 0 || drawX >= width || drawY <= 0 || drawY >= height) {
            restart();
          } else {
            //Is the pixel we want to draw in blank?
            if (pixels[drawY*width+drawX] != color(0)) restart();
          }
        } else {
          state++;
        }
        break;
      case 1:
        //--- SPAWN
        break;
      case 2:
        //--- BUILD
        if (progress < distance) {
          advance(roadWidth/2);
          progress++;
          // Are we still on stage?
          if (drawX <= 0 || drawX >= width || drawY <= 0 || drawY >= height) {
            restart();
          }
        } else {
          state++;
        }
        break;
    }
  }
  void display() {
    switch(state) {
    case 0:
      //--- GROW
      strokeWeight(1);
      stroke(255);
      point(drawX, drawY);
      break;
    case 1:
      //--- SPAWN
      spawnNewRoads();
//      state++;
//      drawX = x;
//      drawY = y;
//      progress = 0;
      break;
    case 2:
      //--- BUILD
      //noStroke();
      //fill(255,0,0);
      strokeWeight(roadWidth);
      stroke(255,100);
       boolean cantDraw = false;
      if ((drawX+buildDiffX) <= 0 || (drawX+buildDiffX) >= width || (drawY+buildDiffY) <= 0 || (drawY+buildDiffY) >= height) {
        restart();
      } else {
        if (pixels[(drawY+buildDiffY)*width+(drawX+buildDiffX)] == color(0)) {
          point(drawX+buildDiffX, drawY+buildDiffY);
        } else {
          cantDraw = true;
        }
      }
      if ((drawX-buildDiffX) <= 0 || (drawX-buildDiffX) >= width || (drawY-buildDiffY) <= 0 || (drawY-buildDiffY) >= height) {
        restart();
      } else {
        if (pixels[(drawY-buildDiffY)*width+(drawX-buildDiffX)] == color(0)) {
          point(drawX-buildDiffX, drawY-buildDiffY);
        }
        else {
          cantDraw = true;
        }
      }
      if (cantDraw) state++;
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
    state++;
    drawX = x;
    drawY = y;
    progress = 0;
  }

  void advance(int amount) {
    switch(direction) {
      case 0: //UP
        drawY-=amount; 
        break;
      case 1: //RIGHT
        drawX+=amount; 
        break;
      case 2: //DOWN
        drawY+=amount; 
        break;
      case 3: //LEFT
        drawX-=amount; 
        break;
    }
  }
  void restart() {
    state+=2;
    drawX = x;
    drawY = y;  
    progress = 0;  
  }
}

