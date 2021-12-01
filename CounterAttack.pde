int Time = 0;
int AlienMin = 1;
int PlayerBulletMin = 0, PlayerBulletIndex = -1;

World w;
Player p;
Alien[] a = new Alien[1000];
PlayerBullet[] b = new PlayerBullet[1000];
Hit h = new Hit();

void setup() {
	size(750, 900);
	w = new World();
	p = new Player(266, 700);
	h = new Hit();
}

void draw() {
	background(255);
	Time += 1;
	p.Move();
	AlienEvent();
	PlayerBulletEvent();
	h.PlayerBulletToAlien();
}
  
