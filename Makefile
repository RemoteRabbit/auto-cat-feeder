# kicad-cli asserts on relative schematic paths, so pass absolute ones.
PCB   := $(CURDIR)/pcb/all
OUT   := pcb/production
KICAD := kicad-cli

.PHONY: all check erc drc fab docs stl fw flash monitor clean

all: check fab

# --- PCB ---
check: erc drc

erc:
	mkdir -p $(OUT)
	$(KICAD) sch erc --severity-error --exit-code-violations -o $(OUT)/erc.rpt $(PCB).kicad_sch

drc:
	mkdir -p $(OUT)
	$(KICAD) pcb drc --exit-code-violations --schematic-parity -o $(OUT)/drc.rpt $(PCB).kicad_pcb

fab: check
	mkdir -p $(OUT)/gerbers
	$(KICAD) pcb export gerbers -o $(OUT)/gerbers/ $(PCB).kicad_pcb
	$(KICAD) pcb export drill -o $(OUT)/gerbers/ $(PCB).kicad_pcb
	$(KICAD) pcb export pos --format csv --units mm -o $(OUT)/positions.csv $(PCB).kicad_pcb
	$(KICAD) sch export bom -o $(OUT)/bom.csv $(PCB).kicad_sch
	cd $(OUT) && rm -f gerbers.zip && zip -qr gerbers.zip gerbers

docs:
	mkdir -p models/export
	$(KICAD) sch export pdf -o docs/schematic.pdf $(PCB).kicad_sch
	$(KICAD) pcb export step -o models/export/control-board.step $(PCB).kicad_pcb

# --- Mechanical ---
stl:
	freecadcmd -c "exec(open('tools/export_stl.py').read())"

# --- Firmware (PlatformIO) ---
fw:
	cd firmware && pio run

flash:
	cd firmware && pio run -t upload

monitor:
	cd firmware && pio device monitor

clean:
	rm -rf $(OUT) models/export firmware/.pio
