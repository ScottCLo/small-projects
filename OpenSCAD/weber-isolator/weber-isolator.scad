function in_to_mm(in) = in * 25.4;

$fn = 64;
thickness = 10;

throat_d = 45;
throat_spacing = 90;

bolt_d = 8.5;
bolt_space = 72;

ear_r = 12;
o_d = 62;
angle = 16;

flange_r = bolt_space/2 + ear_r;

port_d = 2;
tube_d = 3;
tube_depth = 10;
port_h = flange_r * cos(angle);
port_w = flange_r * sin(angle); 


// oring dash code = -135
gland_h = in_to_mm(0.078);
echo(gland_h);
gland_w = in_to_mm(0.121);
gland_id = in_to_mm(1.954);


module flange(){
	difference() {
		union(){
			hull(){
				translate([0,bolt_space/2,0]) circle(r = ear_r);
				circle(d = o_d);
				translate([0,-bolt_space/2,0]) circle(r = ear_r);
			}
			rotate([0,0,-angle])translate([-port_w,0,0]) square(size = [port_w + thickness/2 ,port_h], center = false);
		}
		translate([0,bolt_space/2,0]) circle(d = bolt_d);
		translate([0,-bolt_space/2,0]) circle(d = bolt_d);
		circle(d = throat_d);
		}
}
//flange();

module ring_groove(){
	linear_extrude(height = gland_h) difference() {
		circle(d = gland_id + gland_w * 2);
		circle(d = gland_id);
	}
}

//ring_groove();

module port() {
	translate([0,port_h,thickness/2]) rotate([90,0,0]){
		union(){
			cylinder(d = port_d, h = port_h);
			cylinder(d = tube_d, tube_depth);
		}
	}
}

module isolator(){
	difference() {
		rotate([0,0,angle]) difference(){
			linear_extrude(height = thickness) flange();
			ring_groove();
			translate([0,0,thickness])rotate([180,0,0]) ring_groove();
		}
		port();
		}
}


//port();
isolator();
