function in_to_mm(in) = in * 25.4;

tube_od = in_to_mm(2);
tube_or = tube_od/2;
tube_t = 1.5;
tube_ir = tube_or - tube_t;
tube_id = tube_ir * 2;


hole_d = in_to_mm(3/4);
hole_r = hole_d/2;

clip_head_t = 2;
clip_head_overlap = 2;
clip_head_r = hole_r + clip_head_overlap;
clip_head_d = clip_head_r * 2;

render()rotate([90,0,0]){
	difference(){
		cylinder(d = tube_od, h = clip_head_r, center = true);
		cylinder(d = tube_id, h = clip_head_r, center = true);
	}
}
