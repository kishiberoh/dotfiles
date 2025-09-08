
import json
import sys

# Rosé Pine → Rosé Pine Dawn color mapping
COLOR_MAP = {
    # backgrounds / surfaces
    "#191724": "#faf4ed",  # base → dawn base
    "#1f1d2e": "#f2e9e1",  # overlay
    "#21202e": "#fffaf3",  # surface
    "#26233a": "#f4ede8",  # highlight low
    "#403d52": "#dfdad9",  # highlight med
    "#524f67": "#cecacd",  # highlight high

    # text
    "#e0def4": "#575279",  # main text
    "#c4a7e7": "#907aa9",  # iris
    "#9ccfd8": "#56949f",  # foam
    "#f6c177": "#ea9d34",  # gold
    "#eb6f92": "#b4637a",  # love
    "#31748f": "#286983",  # pine
    "#30738f": "#286983",  # pine (alt)
    "#89dbeb": "#56949f",  # foam (light alt)
    "#caa6f7": "#907aa9",  # iris (light alt)

    # secondary
    "#eb6f92": "#d7827e",  # rose (alt red)
    "#c678dd": "#907aa9"   # map lilac accents to iris
}

def convert_theme(input_file, output_file):
    with open(input_file, "r") as f:
        data = json.load(f)

    converted = {}
    for key, value in data.items():
        hex_lower = value.lower()
        if hex_lower in COLOR_MAP:
            converted[key] = COLOR_MAP[hex_lower]
        else:
            converted[key] = value  # leave unchanged

    with open(output_file, "w") as f:
        json.dump(converted, f, indent=2)

    print(f"Converted theme saved to {output_file}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python convert_rosepine_to_dawn.py input.json output.json")
        sys.exit(1)

    convert_theme(sys.argv[1], sys.argv[2])
