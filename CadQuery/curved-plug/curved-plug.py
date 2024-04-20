import cadquery as cq

if 'show_object' not in globals():
    def show_object(*args, **kwargs):
        pass

def in_to_mm(inch):
    return inch * 25.4

pipe_d = in_to_mm(2)
pipe_r = pipe_d/2
pipe_t = 1

hole_d = in_to_mm(3/4)
hole_r = hole_d/2
lip = 2

head_r = pipe_r + lip
head_t = 2

plug = (
        cq.Workplane("ZX")
        .cylinder(head_r,pipe_d)
        .cut(
            cq.Workplane("ZX")
            .cylinder(head_r,pipe_d-pipe_t)
            )
        )

assy = cq.Assembly()
assy.add(plug, color=cq.Color(0.1,0.1,0.1), name="body")
assy.save("out.step", "STEP", mode="fused")

show_object(assy)
