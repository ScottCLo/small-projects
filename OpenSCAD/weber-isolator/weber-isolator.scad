function in_to_mm(in) = in * 25.4;

$fa = 1;
$fs = .5;
thickness = 10;

throat_d = 45;
throat_spacing = 90;

bolt_d = 8.5;
bolt_space = 72;

ear_r = 12;
o_d = 62;
angle = 16;

flange_r = bolt_space/2 + ear_r;


x_off = sin(angle) * ear_r;
y_off = cos(angle) * ear_r;
off_l = flange_r - y_off + ear_r;

port_cham = 0.5;
port_d = 2;
tube_d = 3;
tube_depth = 10;
port_h = off_l * cos(angle);
port_w = off_l * sin(angle) - x_off + thickness/2;


// oring dash code = -135
gland_h = in_to_mm(0.078);
gland_w = in_to_mm(0.121);
gland_id = in_to_mm(1.954);


module flange(){
	x_off = sin(angle) * ear_r;
	y_off = cos(angle) * ear_r;
	difference() {
		union(){
			hull(){
				translate([0,bolt_space/2,0]) circle(r = ear_r);
				circle(d = o_d);
				translate([0,-bolt_space/2,0]) circle(r = ear_r);
			}
			translate([x_off,bolt_space/2 + y_off,0])rotate(a = [0,0,-90-angle]) square([flange_r,port_w]); 
		}
		translate([0,bolt_space/2,0]) circle(d = bolt_d);
		translate([0,-bolt_space/2,0]) circle(d = bolt_d);
		circle(d = throat_d);
		}
}

module ring_groove(){
	linear_extrude(height = gland_h) difference() {
		circle(d = gland_id + gland_w * 2);
		circle(d = gland_id);
	}
}

module port() {
	translate([0,port_h,thickness/2]) rotate([90,0,0]){
		union(){
			cylinder(d = port_d, h = port_h);
			cylinder(d = tube_d, tube_depth);
			translate([0,0,-1]) cylinder(h = port_cham + 1, d1 = tube_d + port_cham + 1, d2 = tube_d);
		}
	}
}

module isolator(){
	difference() {
		difference(){
			linear_extrude(height = thickness) flange();
			ring_groove();
			translate([0,0,thickness])rotate([180,0,0]) ring_groove();
		}
		rotate([0,0,-angle])port();
		}
}

isolator();
