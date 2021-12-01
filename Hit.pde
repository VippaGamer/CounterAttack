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
        float Distance = pow(pow(abs(x1 - x2), 2) + pow(abs(y1 - y2), 2), 0.5);
        if (Distance <= 25) hit = true;
        return hit;
    }
}