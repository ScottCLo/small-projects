import cadquery as cq
from cadquery.cq import Workplane

if 'show_object' not in globals():
    def show_object(*args, **kwargs):
        pass

def in_to_mm(inch):
    return inch * 25.4

cover_l = in_to_mm(9+7/8)
cover_lip = 6
cover_tab_w = 15

light_d = in_to_mm(3)
light_r = light_d/2

profile = (
        cq.Sketch()
        )

cover = (
        cq.Workplane("XY")
        .box(cover_l,light_r,36.5)
        )

assy = cq.Assembly()
assy.add(cover, color=cq.Color(0.1,0.1,0.1), name="body")
assy.save("out.step", "STEP", mode="fused")

show_object(profile)
