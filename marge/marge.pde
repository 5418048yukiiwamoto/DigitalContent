int scene;

int hund;
int low;
int high;

int turn;
int tLow;
int tHigh;

int rLow;
int rHigh;
int rMax;

int winCount;
int loseCount;

class Config{
  void setting(){
    line(width/2,0,width/2,height);
    drawConfig();
  }
}

class judgeHand{
  
  void judge(int player,int cpu){
    if(player > cpu)
      winCount += 1;
    if(player < cpu)
      loseCount += 1;
  }
  
  int win(){
    return winCount;
  }
  int lose(){
    return loseCount;
  }
}

Config play;
judgeHand jH;

void setup(){
  background(255);
  size(800,600);
  play = new Config();
  jH = new judgeHand();
  scene = 0;

  hund = 5;
  low = 5;
  high = 11;

  turn = 3;
  tLow = 1;
  tHigh = 10;

  rLow = 1;
  rHigh = 1;
  rMax = 10;
  
  winCount = 0;
  loseCount = 0;
}

void drawTitle(){
  background(255);
  fill(0);
  textSize(20);
  text("game name",width/3,height/3);
  text("Press Enter to start game",width/3,height/2);
  text("Press Q to switch game",width/3,2*height/3);
}

void drawConfig(){
  background(255);
  text("Hund",width/2-24,height/5-40);
  drawFigure(width/4,height/5);
  text(hund,width/2-6,height/5);
  
  text("Number of turns",width/3+55,2*height/5-40);
  drawFigure(width/4,2*height/5);
  text(turn,width/2-6,2*height/5);
  
  text("Lower limit of random number",width/3,3*height/5-40);
  drawFigure(width/4,3*height/5);
  text(rLow,width/2-6,3*height/5);
  
  text("Upper limit of random number",width/3,4*height/5-40);
  drawFigure(width/4,4*height/5);
  text(rHigh,width/2-6,4*height/5);
  
  text("Press B to back title",width/3+36,5*height/5-20);
  
}
void drawFigure(int x,int y){
  fill(255);
  rect(x+20,y-25,25,50);
  rect(3*x-40,y-25,25,50);
  fill(0);
  triangle(x+20,y,x+45,y-25,x+45,y+25);
  triangle(3*x-15,y,3*x-40,y-25,3*x-40,y+25);
  stroke(0);
}

void mousePressed(){
  if(scene == 1){
    if(mouseX >= width/4+20 && mouseX <= width/4+45 && mouseY >= height/5-25 && mouseY <= height/5+25 && hund != low){
      hund -= 2;
      drawConfig();
    }else if(mouseX >= 3*width/4-40 && mouseX <= 3*width/4-15 && mouseY >= height/5-25 && mouseY <= height/5+25 && hund != high){
      hund += 2;
      drawConfig();
    }else if(mouseX >= width/4+20 && mouseX <= width/4+45 && mouseY >= 2*height/5-25 && mouseY <= 2*height/5+25 && turn != tLow){
      turn--;
      drawConfig();
    }else if(mouseX >= 3*width/4-40 && mouseX <= 3*width/4-15 && mouseY >= 2*height/5-25 && mouseY <= 2*height/5+25 && turn != tHigh){
      turn++;
      drawConfig();
    }else if(mouseX >= width/4+20 && mouseX <= width/4+45 && mouseY >= 3*height/5-25 && mouseY <= 3*height/5+25 && rLow != 1){
      rLow--;
      drawConfig();
    }else if(mouseX >= 3*width/4-40 && mouseX <= 3*width/4-15 && mouseY >= 3*height/5-25 && mouseY <= 3*height/5+25 && rLow != rHigh){
      rLow++;
      drawConfig();
    }else if(mouseX >= width/4+20 && mouseX <= width/4+45 && mouseY >= 4*height/5-25 && mouseY <= 4*height/5+25 && rHigh != rLow){
      rHigh--;
      drawConfig();
    }else if(mouseX >= 3*width/4-40 && mouseX <= 3*width/4-15 && mouseY >= 4*height/5-25 && mouseY <= 4*height/5+25 && rHigh != rMax){
      rHigh++;
      drawConfig();
    }
  }
}

void keyPressed(){
  if(scene == 0){
    if(keyPressed == true && key == 'Q' || key == 'q'){
      scene = 1;
    }
    if(keyPressed == true && key == ENTER){
      scene = 2;  
    }
  }else if(scene == 1){
    if(keyPressed == true && key == 'B' || key == 'b'){
      scene = 0;
    }
  }else if(scene == 2){
    if(keyPressed == true && key == ENTER){
      scene = 3;
    }
  }else if(scene == 3){
    if(keyPressed == true && key == ENTER){
      loop();
      scene = 0;
      hund = 5;

      turn = 3;

      rLow = 1;
      rHigh = 1;
      rMax = 10;
  
      winCount = 0;
      loseCount = 0;
    }
  }
}

void drawResult(int win,int lose,String result){
  redraw();
  background(255);
  fill(0);
  textSize(30);
  text("player   -     COM",width/2-125,height/4);
  text(win,width/2-85,height/4+35);
  text(lose,width/2+85,height/4+35);
  textSize(60);
  text(result,width/2-(result.length()*33)/2,height/2);
  textSize(30);
  text("Press Enter to back to the title",width/4,3*height/4);
}

void draw(){
  if(scene == 0){
    drawTitle();
  }else if(scene == 1){
    play.setting();
  }else if(scene == 2){
    background(255);
    fill(0);
    text("play game now Press Enter",width/3,2*height/3);
  }else if(scene == 3){
    noLoop();
    int[] a = {1,2,3,3,2,4};
    for(int i = 0;i < 6;i+=2){
      jH.judge(a[i],a[i+1]);
    }
    
    winCount = jH.win();
    loseCount = jH.lose();
    if(winCount > loseCount){
      drawResult(winCount,loseCount,"Player Win");
    }else if(winCount < loseCount){
      drawResult(winCount,loseCount,"COM Win");
    }else{
      drawResult(winCount,loseCount,"Even");
    }
    
  }
  
}
