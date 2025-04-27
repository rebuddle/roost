y += vspd;
vspd += 0.1; // slows down falling
x += hspd;
hspd -= 0.1;

lifespan -= 1;

if (lifespan <= 0) {
    instance_destroy();
}
