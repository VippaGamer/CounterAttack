int Time = 0;
boolean Up, Down, Left, Right, Space;
float x = 500, y = 900;
float[] Ax = new float[1000];
float[] Ay = new float[1000];
float[] Avy = new float[1000];
boolean[] setAircraft = new boolean[1000];
boolean[] unsetAircraft = new boolean[1000];
float[] Bx = new float[1000];
float[] By = new float[1000];
int BulletIndex = 0;
boolean[] setBullet = new boolean[1000];
boolean[] unsetBullet = new boolean[1000];
boolean hit = false;
PImage[] pm = new PImage[4];
PImage photo, bg;

void CreatePlayer() {
  fill(255);
  photo = loadImage("./img/CP02.png");
  image(photo,x ,y);
}

void PlayerMove() {
  if (Left) {
    x -= 10;
  }
  else if (Right) {
    x += 10;
  }
  if (Up) {
    y -= 7;
  }
  else if (Down) {
    y += 7;
  }
  
  if (x < 50) {
    x = 50;
  } else if (x > 700) { 
    x = 700;
  }
  
  if (y < 50) {
    y = 50;
  } else if (y > 950) { 
    y = 950;
  }
}

void AircraftEvent() {
  for (int i = 0 ; i < floor(Time / 25) ;i++) {
    CreateAircraft(i);
    AircraftMove(i);
  }
}

void CreateAircraft(int i) {
  pm[0] = loadImage("./img/PM.png");
  if (setAircraft[i] == false) {
    Ax[i] = floor(random(100, 650));
    Avy[i] = floor(random(10, 15));
    setAircraft[i] = true;
    unsetAircraft[i] = false;
  }
  image(pm[0], Ax[i], Ay[i]);
}

void AircraftMove(int i) {
  if (unsetAircraft[i] == false) {
    Ay[i] += Avy[i];
    if (Ay[i] >= 1050) {
      Ay[i] = 1050;
      unsetAircraft[i] = true;
    }
  }
} 

void BulletEvent() {
  FireBullet();
  BulletMove();
}

void FireBullet() {
  if (Space) {
    BulletIndex += 1;
    for (int i =  0; i <= BulletIndex - 1 ; i++) {
      if (setBullet[i] == false) {
        Bx[i] = x;
        By[i] = y - 80;
        fill(0);
        rect(Bx[i], By[i], 3, 30);
        setBullet[i] = true;
        unsetBullet[i] = false;
      }
    }
  }
}

void BulletMove() {
  for (int i = 0 ; i <= BulletIndex - 1 ; i++) {
    if (unsetBullet[i] == false) {
      By[i] -= 10;
      fill(0);
      rect(Bx[i], By[i], 3, 50);
      if (By[i] < 0) {
        unsetBullet[i] = true;
        By[i] = 2000;
      }
    }
  }
}

void HitEvent() {
  for (int i = 0 ; i <= BulletIndex - 1 ; i++) {
    if (unsetBullet[i] == true) continue;
    for (int j = 0 ; j < floor(Time / 25) ; j++) {
      if (unsetAircraft[j] == true) continue;
      HIT(Bx[i], By[i], Ax[j], Ay[j]);
      if (hit) {
        hit = false;
        unsetBullet[i] = true;
        unsetAircraft[j] = true;
        Ay[j] = 1050;
        By[i] = 2000;
      }
    }
  }
}

boolean HIT(float x1, float y1, float x2, float y2) {
  float Distance = pow(pow(abs(x1 - x2), 2) + pow(abs(y1 - y2), 2), 0.5);
  //println("x1: " + x1 + " y1: " + y1 + " x2: " + x2 +  " y2: " + y2 + " Distance: " + Distance);
  if (Distance < 100) {
    hit = true;
  }
  return hit;
}
   
void setup() {
  size(750, 1000);
}

void draw() {
  background(255);
  bg = loadImage("./img/bg04.jpg");
  image(bg, 0, 0, 750, 1000);
  Time += 1;
  CreatePlayer();
  PlayerMove();
  AircraftEvent();
  BulletEvent();
  HitEvent();
  Space = false;
}
  
void keyPressed() {
  if (key == 'A' || key == 'a') {
    Left = true;
  }
  else if (key == 'D' || key == 'd') {
    Right = true;
  }
  if (key == 'W' || key == 'w') {
    Up = true;
  }
  else if (key == 'S' || key == 's') {
    Down = true;
  }
}

void keyReleased() {
  if (key == 'A' || key == 'a') {
    Left = false;
  }
  else if (key == 'D' || key == 'd') {
    Right = false;
  }
  if (key == 'W' || key == 'w') {
    Up = false;
  }
  else if (key == 'S' || key == 's') {
    Down = false;
  }
  if (key == ' ') {
    Space = true;
  } 
}
