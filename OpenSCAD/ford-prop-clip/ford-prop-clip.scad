$fn = 32;

rod_d = 7;

wall_t = 1.75;
base_h = 4;
base_w = 10.75;
base_add_w = base_w - (rod_d + wall_t * 2);
echo(base_add_w);
clip_h = 14.25;
base_to_clip_r = 1;

recution_w = 5.75;

cord_l = (clip_h - base_h - rod_d - wall_t/2) * 2;
echo(cord_l);
clip_flat_l = rod_d - cord_l/2;

reduction_w = 5.75;
reduction_cord_l = (clip_h - base_h - rod_d - wall_t/2) * 2;
reduction_cord_h = (rod_d - reduction_w) / 2;

function cord_angle_cr(c,r) = 2 * asin(c/(2*r));
function cord_angle_hr(h,r) = 2 * acos((r-h)/r);
function cord_radius_hc(h,c) = pow(c,2)/(8*h) + h/2;

module cord_shape(cord_h, cord_l, diamiter){
	cord_r = cord_radius_hc(cord_h, cord_l);
	echo(cord_r);
	cord_angle = cord_angle_hr(cord_h, cord_r);
	centerline_angle = acos((cord_r - (cord_h)) / cord_r)/2;
	//steps = round($fn / 360 * cord_angle);
	steps = 10;
	angle_step = cord_angle/steps;
	rotate([0,0,180-cord_angle/2]) translate([0,-cord_r,0]) 
		for (i = [1:steps]){
			hull(){
				rotate([0,0,angle_step*(i-1)]) translate([0,cord_r,0])circle(d = diamiter);
				rotate([0,0,angle_step*i]) translate([0,cord_r,0])circle(d = diamiter);
			}
		}
}

module clip_arm(){
	union() {
		hull(){
			translate([0,base_add_w/2,0])circle(d = wall_t);
			translate([clip_flat_l,0,0]) circle(d = wall_t);
		}

		translate([clip_flat_l,0,0]) cord_shape(reduction_cord_h, reduction_cord_l, wall_t);
	}

}
module clip() {
	union(){
		difference() {
			union() {
				translate([base_h/2,0,0])square([base_h, base_w], true);
				translate([base_h+base_to_clip_r/2,0,0]) square([base_to_clip_r, base_w - wall_t], true);
			}
			translate([base_h+base_to_clip_r,0,0]){
				hull() {
					translate([0, rod_d/2 - base_to_clip_r, 0]) circle(base_to_clip_r);
					translate([0, -(rod_d/2 - base_to_clip_r), 0]) circle(base_to_clip_r);
				}
			}
		}
	}
	translate([base_h,0]) {
		translate([0,(rod_d+wall_t)/2,0]) clip_arm();
		translate([0,-(rod_d+wall_t)/2,0]) mirror([0,1,0])  clip_arm();
	}
}

clip();
