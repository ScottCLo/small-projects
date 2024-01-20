$fn = 64;

prop_d = 7.5;
wall_t = 2.4;
clip_w = prop_d + wall_t;
clip_base_w = 11.5;
clip_base_h = 3.5;
clip_guide_diagnal = 11.5;
clip_guide_w = clip_guide_diagnal / sqrt(2);
clip_opening_w = 6;
echo(clip_guide_w);
clip_guide_x = 11.5;
clip_hole_x = prop_d/2 + clip_base_h;
clip_opening_h = clip_guide_x - clip_hole_x;
difference() {
	union() {
	 	projection() rotate([0, 90, 0]) cylinder(h = clip_hole_x, d1 = clip_base_w, d2 = clip_w, center = false);
		translate([clip_hole_x,0,0])circle(d=clip_w);
		translate([clip_guide_x,0,0])rotate([0,0,45]) square(size = clip_guide_w, center = true);
		translate([clip_hole_x,-(clip_opening_w+wall_t)/2,0]) square(size = [clip_opening_h, clip_opening_w+wall_t], center = false);
	}
	union() {
		translate([clip_hole_x,0,0]) circle(d = prop_d);
		translate([clip_guide_x+wall_t/sqrt(2),0,0])rotate([0,0,45]) square(size = clip_guide_w, center = true);
		translate([clip_hole_x,-clip_opening_w/2,0]) square(size = [clip_opening_h, clip_opening_w], center = false);
	}
}
