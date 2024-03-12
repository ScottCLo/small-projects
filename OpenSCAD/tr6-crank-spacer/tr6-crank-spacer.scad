function in_to_mm(in) = in * 25.4;
$fa = 1;
$fs = 0.5;

od = in_to_mm(3);
id = in_to_mm(21/32);
thickness = in_to_mm(1);

difference(){
	cylinder(h = thickness, d = od);
	cylinder(h = thickness, d = id);
}
