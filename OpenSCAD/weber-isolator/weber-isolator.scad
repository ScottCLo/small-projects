function in_to_mm(in) = in * 25.4;

$fn = 64;

throat_d = 45;
throat_spacing = 90;

bolt_d = 8.5;
bolt_space = 72;

ear_r = 12;
o_d = 62;
angle = 16;

// oring dash code = -135
gland_h = in_to_mm(0.078);
gland_w = in_to_mm(0.121);
gland_id = in_to_mm(1.954);

module flange(){
	difference() {
		hull(){
			translate([0,bolt_space/2,0]) circle(r = ear_r);
			circle(d = o_d);
			translate([0,-bolt_space/2,0]) circle(r = ear_r);
		}
		circle(d = throat_d);
		translate([0,bolt_space/2,0]) circle(d = bolt_d);
		translate([0,-bolt_space/2,0]) circle(d = bolt_d);
	}
}

module ring_groove(){
	difference() {
		circle(d = gland_id + gland_w*2);
		circle(d = gland_id);
	}
}

spacer
difference(){
flange();
ring_groove();
}
