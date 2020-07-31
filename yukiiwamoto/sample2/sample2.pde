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

int winCount = 0;
int loseCount = 0;

int win = 0;
int lose = 0;

int winGameCount = 0;
int loseGameCount = 0;

int stop = 0;
int nowturn = 1;

class Config{
  void setting(){
    line(width/2,0,width/2,height);
    drawConfig();
  }
}

class judgeHand{
  
  void judge(int player,int cpu,int i){
    if(player > cpu) {
      text("〇",45+(100*i),520);
      text("×",45+(100*i),420);
      winCount += 1;
    }
    if(player < cpu) {
      text("×",45+(100*i),520);
      text("〇",45+(100*i),420);
      loseCount += 1;
    }else if(player == cpu) {
      text("△",45+(100*i),520);
      text("△",45+(100*i),420);
    }
  }
  
  int win(){
    return winCount;
  }
  int lose(){
    return loseCount;
  }
}

class myHand {
  int[] type = new int [hund];
  int[][] hand = new int [hund][2];
  int temp = 0;
  
  void decideType() {
    for(int i = 0; i < hund; i++) {
      type[i] = int(random(2));
    }
  }
  
  void handOut() {
    for(int i = 0; i < hund; i ++) {
      if(type[i] == 0) {
        hand[i][0] = int(random(rLow,rHigh+1));
      }else {
        hand[i][0] = int(random(rLow,rHigh+1));
        hand[i][1] = int(random(rLow,rHigh+1));
        if(hand[i][0] > hand[i][1]) {
          temp = hand[i][0];
          hand[i][0] = hand[i][1];
          hand[i][1] = temp;
        }
      }
    }
  }
}

class comHand extends myHand {
  
}

class printHand {
  
  void printMyhand(int[] type, int[][] hand) {
    for(int i = 0;  i < hund; i++) {
      if(type[i] == 0) {
        fill(255);
        rect(10+(100*i),750,100,150);
        fill(0);
        text(str(hand[i][0]),50+(100*i),835);
      }else {
        fill(255);
        line(10+(100*i),825,60+(100*i),750);
        line(10+(100*i),825,60+(100*i),900);
        line(60+(100*i),750,110+(100*i),825);
        line(60+(100*i),900,110+(100*i),825);
        fill(0);
        text(str(hand[i][0])+"~"+str(hand[i][1]),30+(100*i),835);
      }
    }
  }
  void printComhand(int[] type, int[][] hand)  {
    textSize(30);
    
    
    for(int i = 0; i < hund; i ++) {
      if(type[i] == 0) {
        fill(255);
        rect(10+(100*i),0,100,150);
        fill(0);
        text(str(hand[i][0]),50+(100*i),85);
      }else {
        fill(255);
        line(10+(100*i),75,60+(100*i),0);
        line(10+(100*i),75,60+(100*i),150);
        line(60+(100*i),0,110+(100*i),75);
        line(60+(100*i),150,110+(100*i),75);
        fill(0);
        text(str(hand[i][0])+"~"+str(hand[i][1]),30+(100*i),85);
      }

    }
  }
  
  void printInformation(int nowTurn, int Maxturn, int myWinCount, int comWinCount) {
    textSize(30);
    text("ユーザー",10,740);
    text("Com",10,200);
    textSize(50);
    fill(0);
    text(str(nowTurn)+" / "+str(Maxturn)+"ターン目", 875,450);
    text(str(comWinCount)+"勝",  1000,90);
    text(str(myWinCount)+"勝",  1000,820);
  }
}

class selectHand {
  int[] myUsed = new int [hund/2+1];
  int[] comUsed = new int [hund/2+1];
  int n = 0;
  int[][] myHand = new int[hund/2+1][2];
  int[][] comHand = new int[hund/2+1][2];
  int judge = 0;
  
  void resetUsed(int[] used) {
    for(int i = 0; i < used.length; i++) {
      used[i] = 99;
    }
  }
  
  void printPlayButton(int n) {
    if(IsFull(n)) {
      fill(255);
      rect(800, 650, 380,100);
      textSize(70);
      fill(0);
      text(" P  L  A  Y", 810,730);
    }else {
      fill(255);
      rect(800, 650, 380,100);
      textSize(70);
      fill(128);
      text(" P  L  A  Y", 810,730);
    }
  }
  
  void setMyHand(int[][] set, int[][] hand, int i) {
    if(n != hund/2+1) {
      for(int j = 0; j < d.n; j++) {
        if(myUsed[j] == i) {
          judge ++;
          println("NG");
        }
      }
      if(judge == 0) {
        if(a.type[i] == 0) {
          set[n][0] = hand[i][0];
          myUsed[n] = i;
          println(set[n][0]);
        }else {
          set[n][0] = int(random(hand[i][0],hand[i][1]+1));
          myUsed[n] = i;
          println(set[n][0]);
        }
        n ++;
      }
    }
  }
  
  void setComHand(int[][] hand) {
    int cn = 0;
    while(cn < hund/2+1) {
      int judge = 0;
      int pos = int(random(0,hund));
      for(int i = 0; i < cn; i++) {
        if(comUsed[i] == pos) {
          judge ++;
        }
      }
      if(judge == 0) {
        if(a.type[pos] == 0) {
          comHand[cn][0] = hand[pos][0];
          comUsed[cn] = pos;
        }else {
          comHand[cn][0] = int(random(hand[pos][0],hand[pos][1]+1));
          comUsed[cn] = pos;
        }
        cn ++;
        
      }
    }
  }
      
  
  void printSelect(int[] used, int n) {
    for(int i = 0; i < n; i++) {
      fill(0);
      textSize(25);
      text(str(i+1),53+(100*used[i]), 870);
    }
  }
  
  
  boolean IsClickedHand(int i, int x, int y) {
    return 10+(i*100) <= x && x <= 110+(i*100) && 750 <= y && y <= 900;
  }
  
  boolean IsFull(int n) {
    return n == hund/2+1;
  }
      
  //boolean    
  
}

Config play;
judgeHand jH;

myHand a;
comHand b;
printHand c;
selectHand d;



void setup(){
  background(255);
  size(1200,900);
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
  rHigh = 10;
  rMax = 10;
  
  winCount = 0;
  loseCount = 0;
  
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  a = new myHand();
  b = new comHand();
  c = new printHand();
  d = new selectHand();
  
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
  }else if(scene == 2) {
    for(int i = 0; i < hund; i++) {
      if(d.IsClickedHand(i,mouseX,mouseY)) {
        d.setMyHand(d.myHand,a.hand,i);
      }
    }
    if(800 <= mouseX && mouseX <= 1180 && 650 <= mouseY && mouseY <= 750 && d.n == hund/2+1) {
      stop = 0;
      scene = 3;
    }
  }else if(scene == 3) {
    if(nowturn == turn) {
      if(800 <= mouseX && mouseX <= 1180 && 650 <= mouseY && mouseY <= 750) {
        scene = 4;
        stop = 0;
      }
    }else {
      if(800 <= mouseX && mouseX <= 1180 && 650 <= mouseY && mouseY <= 750) {
        nowturn ++;
        scene = 2;
        stop = 0;
        winCount = 0;
        loseCount = 0;
        win = 0;
        lose = 0;
      }
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
  }else if(scene == 4){
    if(keyPressed == true && key == ENTER){
      loop();
      scene = 0;
      hund = 5;

      turn = 3;

      rLow = 1;
      rHigh = 10;
      rMax = 10;
  
      winCount = 0;
      loseCount = 0;
      
      winGameCount = 0;
      loseGameCount = 0;
      
      nowturn = 1;
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
    textSize(30);
    d.judge = 0;
  
    if(stop == 0) {
      d.n = 0;
      a.decideType();
      a.handOut();
      b.decideType();
      b.handOut();
      d.setComHand(b.hand);
      for(int i = 0; i <= hund/2; i++) {
        println(d.comHand[i][0]);
      }
    
      stop ++;
    }
    c.printMyhand(a.type,a.hand);
    c.printComhand(b.type,b.hand);
    c.printInformation(nowturn,turn,winGameCount,loseGameCount);
    d.printSelect(d.myUsed, d.n);
    d.printPlayButton(d.n);
    
  
  }else if(scene == 3) {
    fill(255);
    rect(800, 650, 380,100);
    textSize(70);
    fill(0);
    text(" N  E  X  T", 810,730);
    if(stop == 0) {
      background(255);
      for(int i = 0;i < hund/2+1;i+=1){
        fill(255);
        rect(10+(100*i),550,100,150);
        rect(10+(100*i),210,100,150);
        fill(0);
        textSize(30);
        text(str(d.myHand[i][0]),50+(100*i),635);
        text(str(d.comHand[i][0]),50+(100*i),295);
        jH.judge(d.myHand[i][0],d.comHand[i][0],i);
        c.printInformation(nowturn,turn,winGameCount,loseGameCount);
      }
      win = jH.win();
      lose = jH.lose();
      println(win);
      println(lose);
      if(win > lose){
        text("  You   Win", 830,620);
        winGameCount ++;
      }else if(win < lose){
        text("  Com   Win", 830,620);
        loseGameCount ++; 
      }else {
        text("      Even ", 830,620);
      }
      stop++;
    }
    
      
    
  }else if(scene == 4){
    noLoop();
    
    if(winGameCount > loseGameCount){
      drawResult(winGameCount,loseGameCount,"Player Win");
    }else if(winGameCount < loseGameCount){
      drawResult(winGameCount,loseGameCount,"COM Win");
    }else{
      drawResult(winGameCount,loseGameCount,"Even");
    }
    
  }
  
}
