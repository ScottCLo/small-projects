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

light_d = 5#in_to_mm(3)
light_r = 2.5
light_face_w = light_d

d = 2

light_profile = (
        cq.Sketch()
        .segment((0,-1),(0,1),"s1")
        .constrain("s1", "Length", 6)
        .constrain("s1", "Fixed", None)
        .arc((0,0),3,0,359, "a1")
        #.constrain("a1","s1", "Coincident", None)
        #.constrain("s1","a1", "Coincident", None)
        #.constrain("a1", "Radius", light_r)
        .solve()
        )

cover = (
        cq.Workplane("XY")
        .box(cover_l,light_r,36.5)
        )

assy = cq.Assembly()
assy.add(cover, color=cq.Color(0.1,0.1,0.1), name="body")
assy.save("out.step", "STEP", mode="fused")

show_object(light_profile)
