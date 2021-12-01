import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CounterAttack extends PApplet {

int Time = 0;
int AlienMin = 1;
int PlayerBulletMin = 0, PlayerBulletIndex = -1;

World w;
Player p;
Alien[] a = new Alien[1000];
PlayerBullet[] b = new PlayerBullet[1000];
Hit h = new Hit();

public void setup() {
	
	w = new World();
	p = new Player(266, 700);
	h = new Hit();
}

public void draw() {
	Time += 1;
	background(255);
	p.Move();
	AlienEvent();
	PlayerBulletEvent();
	h.PlayerBulletToAlien();
}
  
class Alien {

    private float x;
    private float y;
    private float vy;
    private boolean life;
    private boolean die;
    private PImage img;

    private Alien() {
        this.x = floor(random(100, 650));
        this.y = 0;
        this.vy = floor(random(5, 10));
        this.life = true;
        this.die = false;
        this.img = loadImage("./img/PM.png");
    }

    private void Move() {
        this.y += this.vy;
        if (this.y >= 950) {
            this.y = 950;
            this.life = false;
            this.die = true;
        }
        image(this.img, this.x, this.y);
    }

    private void x(float x) {
        this.x = x;
    }

    private float x() {
        return this.x;
    }

    private void y(float y) {
        this.y = y;
    }

    private float y() {
        return this.y;
    }

    private boolean life() {
        return this.life;
    }

    private void die(boolean die) {
        this.die = die;
    }

    private boolean die() {
        return this.die;
    }

}

public void AlienEvent() {
    int index = AlienCreate();
    for (int i = AlienMin ; i < index ; i++) {
        if (!a[i].die()) {
            a[i].Move();
        } else {
            if (!a[i].life()) if (AlienMin < i) AlienMin = i;
        }
    }
}

public int AlienCreate() {
    int index = Time / 25;
    a[index] = new Alien();
    return index;
}
class Hit {

    private Hit() {

    }

    private void PlayerBulletToAlien() {
        Hit:
        for (int i = AlienMin ; i < Time / 25 ; i++) {
            for (int j = PlayerBulletMin ; j <= PlayerBulletIndex ; j++) {
                boolean hit = this.impact(a[i].x(), a[i].y(), b[j].x(), b[j].y());
                if (hit) {
                    a[i].y(950);
                    b[j].y(-50);
                    a[i].die(true);
                    b[j].die(true);
                    break Hit;
                }
            }
        }
    }

    private boolean impact(float x1, float y1, float x2, float y2) {
        boolean hit = false;
        float Distance = pow(pow(abs(x1 - x2), 2) + pow(abs(y1 - y2), 2), 0.5f);
        if (Distance <= 25) hit = true;
        return hit;
    }
}
public void keyPressed() {
    if (key == 'A' || key == 'a') {
        p.Left = true;
    }
    else if (key == 'D' || key == 'd') {
        p.Right = true;
    }
    if (key == 'W' || key == 'w') {
        p.Up = true;
    }
    else if (key == 'S' || key == 's') {
        p.Down = true;
    }
}

public void keyReleased() {
    if (key == 'A' || key == 'a') {
        p.Left = false;
    }
    else if (key == 'D' || key == 'd') {
        p.Right = false;
    }
    if (key == 'W' || key == 'w') {
        p.Up = false;
    }
    else if (key == 'S' || key == 's') {
        p.Down = false;
    }
    if (key == ' ') {
        p.Space = true;
    } 
}
class Player {

    private float x;
    private float y;
    private boolean Up, Down, Left, Right, Space;
    private PImage img;
    
    private Player(float x, float y) {
        this.x = x;
        this.y = y;
        this.img = loadImage("./img/CP02.png");
    }

    private void Move() {
        
        if (this.Left) {
            this.x -= 10;
        }
        else if (this.Right) {
            this.x += 10;
        }
        if (this.Up) {
            this.y -= 7;
        }
        else if (this.Down) {
            this.y += 7;
        }

        if (this.x < -40) {
            this.x = -40;
        } else if (this.x > 570) { 
            this.x = 570;
        }
        if (this.y < -20) {
            this.y = -20;
        } else if (this.y > 730) { 
            this.y = 730;
        }

        if (this.Space) {
            PlayerBulletCreate();
            this.Space = false;
        }

        image(this.img, this.x, this.y);
    }

    private float x() {
        return this.x; 
    }

    private float y() {
        return this.y; 
    }


}
class PlayerBullet {

    private float x;
    private float y;
    private float vy;
    private boolean life;
    private boolean die;
    private PImage img;

    private PlayerBullet() {
        this.x = p.x() + 109 - 25;
        this.y = p.y();
        this.vy = 15;
        this.life = true;
        this.die = false;
        this.img = loadImage("./img/BL.png");
    }

    private void Move() {
        this.y -= this.vy;
        if (this.y < -50) {
            this.y = -50;
            this.life = false;
            this.die = true;
        }
        image(this.img, this.x, this.y);
    }

    private void x(float x) {
        this.x = x;
    }

    private float x() {
        return this.x;
    }

    private void y(float y) {
        this.y = y;
    }

    private float y() {
        return this.y;
    }

    private boolean life() {
        return this.life;
    }

    private void die(boolean die) {
        this.die = die;
    }

    private boolean die() {
        return this.die;
    }
    
}

public void PlayerBulletEvent() {
    for (int i = PlayerBulletMin ; i <= PlayerBulletIndex ; i++) {
        if (!b[i].die()) {
            b[i].Move();
        } else {
            if (!b[i].life()) if (PlayerBulletMin < i) PlayerBulletMin = i;
        }
    }
}

public void PlayerBulletCreate() {
    PlayerBulletIndex += 1;
    b[PlayerBulletIndex] = new PlayerBullet();
}
class World {

    private PImage bg;

    private World() {
        bg = loadImage("./img/bg04.jpg");
    }

    private void draw() {
        image(bg, 0, 0, 750, 1000);
    }

}
  public void settings() { 	size(750, 900); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CounterAttack" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
