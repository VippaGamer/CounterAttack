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

void AlienEvent() {
    int index = AlienCreate();
    for (int i = AlienMin ; i < index ; i++) {
        if (!a[i].die()) {
            a[i].Move();
        } else {
            if (!a[i].life()) if (AlienMin < i) AlienMin = i;
        }
    }
}

int AlienCreate() {
    int index = Time / 25;
    a[index] = new Alien();
    return index;
}
