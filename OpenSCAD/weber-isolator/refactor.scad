function in_to_mm(in) = in * 25.4;

$fn = 32;

isolator_thickness = 8;

throat_diamiter = 45;

bolt_d = 8.5;
bolt_spacing = 72;
bolt_spacing_center = bolt_spacing/2;

flange_ear_r = 12;
flange_w = 62;
flange_h = bolt_spacing_center + flange_ear_r;
flange_angle = 16;

port_extention_x_offset = cos(flange_angle) * flange_ear_r;
port_extention_y = sin(flange_angle) * flange_ear_r;
port_extention_x = bolt_spacing_center + port_extention_x_offset;
port_extention_offset_hyp = sqrt(pow(port_extention_x,2) + pow(port_extention_y,2));
port_extention_w = port_extention_offset_hyp * cos(flange_angle);
port_d = 2;
port_l = port_extention_offset_hyp * cos(flange_angle);
port_x = port_extention_offset_hyp; 

tube_od = 3;
tube_depth = 10;

// o-ring dash code -135
oring_groove_h = in_to_mm(0.078);
oring_groove_w = in_to_mm(0.121);
oring_groove_id = in_to_mm(1.954);

module radial_tile(r, n){
	for (i = [0:n]) {
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
	translate([port_extention_x, port_extention_y,0])
	rotate(a = [0,0,90 + flange_angle]) 
		cube([port_extention_w,flange_w/2,isolator_thickness]); 	
}

module port(){
	rotate([0,0,flange_angle])translate([port_x,0,isolator_thickness/2]){
		cylinder(h=20, r=1);
	}
}

union(){
flange();
port_extention();
}
port();
