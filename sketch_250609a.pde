PFont font;
Balls[] pool;
int InGame = 0;
float ball_speed = 0.5;
int difficulty = 2;
int diameter = 10;
int poop_count = 250;
float player_x = 680;
int start_time;
int execution_time;

void setup(){
  fullScreen();
  noStroke();
  background(0);
  font = createFont("NotoSerifKR-ExtraLight.ttf", 32);
  textFont(font);
  pool = new Balls[poop_count];
  for(int i = 0; i < poop_count; i++){
    pool[i] = new Balls();
  }
}

void draw(){
  if(InGame == 0){
    background(0);
    
    textSize(100);
    fill(255, 255, 255);
    text("공 피하기", 75, 150); //title
    
    textSize(50);
    text("Game Start", 75, 400);                  //Enter Start
    if(mouseX > 75 && mouseY > 360 && mouseX < 345 && mouseY < 405){
      fill(0, 0, 255);
      text("Game Start", 75, 400);
      if(mousePressed == true){
        InGame = 1;
        start_time = millis();
      }
    } else {
      fill(255, 255, 255);
      text("Game Start", 75, 400);
    } //detect end
    
    textSize(50);
    text("Setting", 75, 475);                       //Enter Setting
    if(mouseX > 75 && mouseY > 435 && mouseX < 245 && mouseY < 480){
      fill(0, 0, 255);
      text("Setting", 75, 475);
      if(mousePressed == true){
        InGame = 2;
      }
    } else {
      fill(255, 255, 255);
      text("Setting", 75, 475);
    } //detect end
    
  }else if(InGame == 1){                     //Ingame
    background(0);
    fill(255);
    if(mousePressed && mouseButton == LEFT){
      player_x -= difficulty*2 + 1;
    } else if(mousePressed && mouseButton == RIGHT){
      player_x += difficulty*2 + 1;
    }
    ellipse(player_x, 870, 20, 20);
    for(int i = 0; i < poop_count; i++){
      pool[i].coordination();
      pool[i].display();
      pool[i].detect_fail(player_x);
    }
    
  } else if(InGame == 2){                    //Setting
    background(0);
    textSize(75);
    fill(255);
    text("Setting", 75, 100); //title
    textSize(35);
    text("Ball's Speed", 75, 300);
    textSize(40);
    text(nf(ball_speed, 1, 1), 480, 300); //ball's speed
    
    if(mouseX > 440 && mouseY > 270 && mouseX < 475 && mouseY < 310){ //- color about ball speed
      fill(0, 0, 255);
    } else{
      fill(255);
    } text("-", 450, 300);
    
    if(mouseX > 545 && mouseY > 270 && mouseX < 570 && mouseY < 310){ //+ color about too
      fill(0, 0, 255);
    } else{
      fill(255, 255, 255);
    } text("+", 545, 300);
      
    fill(255);
    textSize(35);
    text("Difficulty", 75, 400);
    textSize(40);
    if(mouseX > 480 && mouseY > 365 && mouseX < 620 && mouseY < 405){
      fill(0, 0, 255);
    }
    if(difficulty == -1){
      difficulty = 2;
    } else if(difficulty == 0){
      text("HARD", 480, 400);
    } else if(difficulty == 1){
      text("NORM", 480, 400);
    } else if(difficulty == 2){
      text("EASY", 480, 400);
    }
    
  } else if(InGame == 3){
    for(int i = 0; i < poop_count; i ++){
      pool[i].failure();
    }
    fill(255);
    textSize(175);
    text("FAIL!", 200, 200);
  }
}

void mouseReleased(){
  if(mouseX > 440 && mouseY > 270 && mouseX < 475 && mouseY < 310 && ball_speed > 0.5 && InGame == 2){ //Works Only in Setting & ball speed -
    ball_speed -= 0.5;
  } else if(mouseX > 545 && mouseY > 270 && mouseX < 570 && mouseY < 310 && ball_speed < 2.0 && InGame == 2){ //It's too, but ball speed +
    ball_speed += 0.5;
  } else if(mouseX > 480 && mouseY > 365 && mouseX < 620 && mouseY < 405 && difficulty < 3 && InGame == 2){ //Works Only in Setting & difficulty
    difficulty -= 1;
  } 
  //println(mouseX, mouseY);
}

void keyPressed(){
  if(key == ESC){
    key = 0;
  }
}

void keyReleased(){
  if(key == ESC){
    println("ESC detected!");
    if(InGame == 0){
      exit();
    } else {
      InGame = 0;
    }
  }
}

class Balls{
  float x;
  float y;
  
  Balls() {
    x = random(displayWidth);
    y = random(-1800, -10);
  }
  
  void coordination(){
    if(y > displayHeight){
      y = random(-1800, -10);
      x = random(displayWidth);
    }
    y += (ball_speed * 5);
  }
  
  void display(){
    fill(139, 69, 19);
    ellipse(x, y, diameter, diameter);
  }
  
  void detect_fail(float player_x){
    if(dist(x, y, player_x, 870) < 13){
      InGame = 3;
    }
  }
  
  void failure(){
    y = random(-1800, -10);
    x = random(displayWidth);
  }
  
}
