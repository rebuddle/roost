// decrease alpha
image_alpha -= 0.14;

// destroy object
if (image_alpha <= 0) {
	instance_destroy();
}