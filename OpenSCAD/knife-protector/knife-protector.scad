$fa = 1;
$fs = 0.5;

knife_t = 3.25;
knife_cord = 154.25;
knife_arc_h = 2;
knife_r = (pow(knife_cord, 2) / (8 * knife_arc_h)) + knife_arc_h / 2;
knife_a = (knife_cord/knife_r) * 180 / PI;
knife_bevel_l = 6.5;
echo(knife_r);
protector_wall_t = 1;
protector_h = 12;
protector_t = protector_wall_t * 2 + knife_t;
protector_flat_h = protector_h - protector_t/2;

rotate([90,0,0]) translate([-knife_r,0,0]) rotate_extrude(angle = knife_a, convexity = 2) translate([knife_r,0,0])rotate([0,0,90])difference() {
	union() {
		circle(d = protector_t);
		translate([0,protector_flat_h/2,0]) square([protector_t, protector_flat_h], center= true);
	}
	union() {
		projection() rotate([-90,0,0]) cylinder(r2=knife_t/2, r1=knife_t/2 - 1, h = knife_bevel_l);
		circle(r = knife_t/2);
		translate([0, knife_bevel_l + knife_t / 2,0]) square(size = knife_t, center = true);
	}
}
