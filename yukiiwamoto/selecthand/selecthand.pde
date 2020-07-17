class myHand {
  int[] type = new int [5];
  int[][] hand = new int [5][2];
  int temp = 0;
  
  void decideType() {
    for(int i = 0; i < 5; i++) {
      type[i] = int(random(2));
    }
  }
  
  void handOut() {
    for(int i = 0; i < 5; i ++) {
      if(type[i] == 0) {
        hand[i][0] = int(random(1,7));
      }else {
        hand[i][0] = int(random(1,7));
        hand[i][1] = int(random(1,7));
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
    for(int i = 0;  i < 5; i++) {
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
    textSize(50);
    text("ユーザー",10,740);
    text("Com",10,200);
    textSize(30);
    for(int i = 0; i < 5; i ++) {
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
    textSize(50);
    fill(0);
    text(str(nowTurn)+" / "+str(Maxturn)+"ターン目", 875,450);
    text(str(comWinCount)+"勝",  1000,90);
    text(str(myWinCount)+"勝",  1000,820);
  }
}

class selectHand {
  boolean IsClicked(int i, int x, int y, int[] type) {
    return 10+(i*100) <= x && x <= 110+(i*100) && 750 <= y && y <= 900;
  }
}

myHand a;
comHand b;
printHand c;
selectHand d;

int stop = 0;

void setup() {
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  size(1200,900);
  a = new myHand();
  b = new comHand();
  c = new printHand();
  d = new selectHand();
}

void draw() {
  background(255);
  textSize(30);
  
  if(stop == 0) {
    a.decideType();
    a.handOut();
    b.decideType();
    b.handOut();
    for(int i = 0; i < 5; i++) {
      if(a.type[i] == 0 || a.type[i] == 1 && a.hand[i][0] == a.hand[i][1]) {
        println(str(a.hand[i][0]));
      }else {
        println(str(a.hand[i][0]) + "~" + str(a.hand[i][1]));
      }
    }
    
    println();
    
    for(int i = 0; i < 5; i++) {
      if(b.type[i] == 0 || b.type[i] == 1 && b.hand[i][0] == b.hand[i][1]) {
        println(str(b.hand[i][0]));
      }else {
        println(str(b.hand[i][0]) + "~" + str(b.hand[i][1]));
      }
    }
    
    
    stop ++;
  }
  c.printMyhand(a.type,a.hand);
  c.printComhand(b.type,b.hand);
  c.printInformation(1,2,3,4);
  
}

void mouseClicked() {
  for(int i = 0; i < 5; i++) {
    if(d.IsClicked(i,mouseX,mouseY,a.type)) {
      println(i);
    }
  }
}
