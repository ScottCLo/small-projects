function in_to_mm(in) = in * 25.4;

lamp_od = in_to_mm(7);

cover_thickness = 3;
cover_rim = 20;

cover_height = cover_rim + cover_thickness;
cover_od = lamp_od + cover_thickness * 2;
cover_id = lamp_od;

difference(){
	cylinder(d = cover_od, h = cover_height);
	translate([0,0,cover_thickness])cylinder(d = cover_id, h = cover_height);
}
