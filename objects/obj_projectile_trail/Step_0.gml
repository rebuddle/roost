// decrease alpha
image_alpha -= 0.08;

// destroy object
if (image_alpha <= 0) {
	instance_destroy();
}