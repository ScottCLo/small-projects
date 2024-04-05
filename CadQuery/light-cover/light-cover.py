import cadquery as cq

if 'show_object' not in globals():
    def show_object(*args, **kwargs):
        pass

def in_to_mm(inch):
    return inch * 25.4

lamp_od = 159.75

tolerance = -0.05

cover_thickness = 3
cover_rim_height = 9
cover_id = lamp_od + tolerance
cover_od = lamp_od + cover_thickness + cover_thickness * 2
cover_or = cover_od / 2
cover_height = cover_rim_height + cover_thickness



cover = (
    cq.Workplane("XY")
    .cylinder(height=cover_height, radius=cover_or)
    .faces(">Z")
    .hole(diameter=cover_id ,depth=cover_rim_height)
    .faces(">Z")
    .edges()
    .all()[1]
    .chamfer(1)
    .faces("<Z")
    .edges()
    .fillet(2)
    .faces("<Z")
    .workplane()
    .center(-5,-3)
    .text(
        "EXPLORER",
        36,
        -1,
        fontPath="./Fastup-Regular.ttf",
    )
)

assy = cq.Assembly()
assy.add(cover, color=cq.Color(0.1,0.1,0.1), name="body")
assy.save("out.step", "STEP", mode="fused")

show_object(assy)
