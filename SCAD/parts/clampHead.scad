include<../modules/params.scad>;

// fits over the tip of the eyebolt to secure the clamp to the table; captive ball pivots inside the cone shape so do not print with supports!

module clampHead() {
	boltDiam = 7.8;
   
	// ball 
	difference() {
		sphere(d = boltDiam + 3);
		// subtract 
		cylinder(h = boltDiam, d = boltDiam, $fn=cylres50);
	}
   
	// socket
	difference() {
		translate([0,0,-(boltDiam) - tolerance *2]) 
			cylinder(h = boltDiam + 4, d1 = boltDiam * 4, d2 = boltDiam * 2, $fn=cylres50);
		// subtract
		sphere(d = boltDiam + 3 + tolerance * 3, $fn=cylres50);
	}
}

clampHead();