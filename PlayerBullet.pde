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

void PlayerBulletEvent() {
    for (int i = PlayerBulletMin ; i <= PlayerBulletIndex ; i++) {
        if (!b[i].die()) {
            b[i].Move();
        } else {
            if (!b[i].life()) if (PlayerBulletMin < i) PlayerBulletMin = i;
        }
    }
}

void PlayerBulletCreate() {
    PlayerBulletIndex += 1;
    b[PlayerBulletIndex] = new PlayerBullet();
}