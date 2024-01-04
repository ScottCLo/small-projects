$fn = 64;
pole_d = 12;
pole_r = pole_d/2;
pole_w = 22;
wall_t = 2;
standoff_h = 5;
standoff_p = 0.5;
standoff_od = 14;
standoff_or = standoff_od/2;
standoff_w = standoff_h + standoff_p + pole_d + wall_t*2;
standoff_round_r = 5.15;
standoff_hex_r = 8.75/2;
type = "round";
hole_d = 5;
hole_r = hole_d/2;
bracket_l = 70;
bracket_w = pole_w + wall_t;

profile_offset = pole_w/2 - pole_r;
module pole_profile(add = 0){
	hull(){
		translate([profile_offset,0,0]) circle(r = pole_d/2+add);
		translate([-profile_offset,0,0]) circle(r = pole_d/2+add);
	}
}
module pole_shape(add = 0){
	linear_extrude(height = bracket_l, center = false) pole_profile(add);
}
module standoff(type = "round") {
	difference() {
		cylinder(h = standoff_w, r = standoff_or, center = false);
		if (type == "round") {
			cylinder(h=standoff_h, r=standoff_round_r);
		}
		if (type == "hex") {
			cylinder(h=standoff_h, r=standoff_hex_r, $fn=6);
		}
	} 
}


module bracket(type = "round"){
	difference() {
		union() {
			translate([0,pole_r + wall_t + standoff_h,bracket_l/2]) rotate([90,0,0]) standoff(type);
			pole_shape(wall_t);
		}
		pole_shape();
		translate([0,0,bracket_l/2]) rotate([90,0,0]) cylinder(r=hole_r, center = true, h = bracket_w);
	}
}


bracket("hex");

