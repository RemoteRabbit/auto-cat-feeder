# Export every non-empty PartDesign body in models/*.FCStd to models/export/<file>-<body>.stl.
# Run from the repo root: freecadcmd -c "exec(open('tools/export_stl.py').read())"
import glob
import os

import FreeCAD
import MeshPart

os.makedirs("models/export", exist_ok=True)

for path in sorted(glob.glob("models/*.FCStd")):
    doc = FreeCAD.openDocument(os.path.abspath(path))
    stem = os.path.splitext(os.path.basename(path))[0]
    for obj in doc.Objects:
        if obj.TypeId != "PartDesign::Body" or obj.Shape.isNull() or not obj.Shape.Solids:
            continue
        out = f"models/export/{stem}-{obj.Label.lower().replace(' ', '-')}.stl"
        # 0.05 mm chord error and ~5° angular steps keep curves smooth when printed.
        mesh = MeshPart.meshFromShape(Shape=obj.Shape, LinearDeflection=0.05, AngularDeflection=0.0873, Relative=False)
        mesh.write(out)
        print(f"wrote {out}")
    # Close everything, including documents opened through assembly links.
    for name in list(FreeCAD.listDocuments()):
        FreeCAD.closeDocument(name)
