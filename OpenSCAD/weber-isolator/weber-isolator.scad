function in_to_mm(in) = in * 25.4;

$fn = 32;

isolator_thickness = 8;

throat_d = 40;

bolt_hole_d = 8.5;
bolt_spacing = 72;
bolt_spacing_center = bolt_spacing/2;

flange_ear_r = 12;
flange_w = 62;
flange_h = bolt_spacing_center + flange_ear_r;
flange_angle = 16;

port_extention_x_offset = cos(flange_angle) * flange_ear_r;
port_extention_y = sin(flange_angle) * flange_ear_r;
port_extention_x = bolt_spacing_center + port_extention_x_offset;
port_extention_tan_hyp = flange_ear_r / cos(flange_angle);
port_extention_tan_opp = flange_ear_r * sin(flange_angle);
port_extention_hyp = bolt_spacing_center + port_extention_tan_hyp;
port_extention_opp = port_extention_hyp * sin(flange_angle);
port_extention_w = port_extention_opp - port_extention_tan_opp + isolator_thickness/2;

port_d = 2;
port_l = port_extention_hyp * cos(flange_angle);

tube_od = 3;
tube_depth = 10;

// o-ring dash code -135
oring_groove_h = in_to_mm(0.078);
oring_groove_w = in_to_mm(0.121);
oring_groove_id = in_to_mm(1.954);
oring_groove_od = oring_groove_id + oring_groove_w*2;

module radial_tile(r, n){
	for (i = [0:n-1]) {
		rotate([0,0,360 / n * i])translate([r,0,0]) 
			children();
	}
}

module flange(){
	hull(){
		cylinder(d = flange_w,h =isolator_thickness);
		radial_tile(bolt_spacing_center, 2) cylinder(r = flange_ear_r, h = isolator_thickness);
	}
}

module port_extention(){
	hull(){
		translate([port_extention_x, port_extention_y,0])
			rotate(a = [0,0,90 + flange_angle]) 
			cube([port_extention_w,flange_w/2,isolator_thickness]);
		translate([bolt_spacing_center,0,0])cylinder(r=flange_ear_r, h = isolator_thickness);
	}
}

module port(){
	rotate([0,0,flange_angle])translate([port_l,0,isolator_thickness/2]){
		rotate([0,-90,0])union(){
			cylinder(h = port_l, d = port_d);
			cylinder(h = tube_depth, d = tube_od);
		}
	}
}

module throat(){
	cylinder(d = throat_d, h = isolator_thickness);
}

module bolt_holes(){
	radial_tile(bolt_spacing_center, 2)cylinder(d=bolt_hole_d,h=isolator_thickness);
}

module oring_grooves(){
	translate([0,0,isolator_thickness/2])rotate([0,90,0])radial_tile(isolator_thickness/2, 2)rotate([0,-90,0])difference(){
		cylinder(d=oring_groove_od,h=oring_groove_h);
		cylinder(d=oring_groove_id,h=oring_groove_h);
	}
}

module isolator(){
	difference(){
		union(){
			flange();
			port_extention();
		}
		union(){
			port();
			throat();
			bolt_holes();
			oring_grooves();
		}
	}
}

isolator();
