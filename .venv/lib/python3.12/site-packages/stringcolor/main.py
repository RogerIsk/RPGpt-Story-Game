#!/usr/bin/env python

"""just another mod for printing strings in color."""

import argparse
from argparse import RawTextHelpFormatter as rawtxt
import sys 
import signal
from functools import partial
from columnar import columnar
import pkg_resources
import colorama
colorama.init()
import stringcolor.ops as ops

COLORS = ops.Color.colors
cs = ops.Color
rgbtolist = ops.Color.rgbtolist
hextorgb = ops.Color.hextorgb
color_difference = ops.Color.color_difference

def sort_by_alpha():
    """sort dictionary by name alphabetically"""
    newobj = {}
    for key, value in COLORS.items():
        name = value["name"]
        newobj[name] = value
    return dict(sorted(newobj.items()))

def signal_handler(sig, frame):
    """handle control c"""
    print('\nuser cancelled')
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

def find_colors(color):
    """find colors matching args"""
    # sortedc is COLORS sorted by name
    sortedc = sort_by_alpha()
    colors_found = 0
    for key, value in sortedc.items():
        rgb_arr = rgbtolist(value["rgb"])
        if int(rgb_arr[0])*0.299 + int(rgb_arr[1])*0.587 + int(rgb_arr[2])*0.114 > 140:
            black = "black"
        else:
            black = "white"
        if "*" in color:
            if color.endswith("*") and color.startswith("*"):
                searchcolor = color.replace("*", "")
                if searchcolor.lower() in value["name"].lower():
                    print(cs(" "+value["name"]+" "+value["hex"]+" "+value["rgb"]+" "+value["hsl"]+" ", black, value["term"]))
                    colors_found += 1
            else:
                if color.endswith("*"):
                    searchcolor = color.replace("*", "")
                    if value["name"].lower().startswith(searchcolor.lower()):
                        print(cs(" "+value["name"]+" "+value["hex"]+" "+value["rgb"]+" "+value["hsl"]+" ", black, value["term"]))
                        colors_found += 1
                if color.startswith("*"):
                    searchcolor = color.replace("*", "")
                    if value["name"].lower().endswith(searchcolor.lower()):
                        print(cs(" "+value["name"]+" "+value["hex"]+" "+value["rgb"]+" "+value["hsl"]+" ", black, value["term"]))
                        colors_found += 1
        else:
            if color.lower() == value["name"].lower() or color == value["hex"] or color == value["term"]:
                print(cs(" "+value["name"]+" "+value["hex"]+" "+value["rgb"]+" "+value["hsl"]+" ", black, value["term"]))
                colors_found += 1
    return colors_found

def main():
    """just another mod for printing strings in color.
    
    CLI entry point."""
    version = pkg_resources.require("string-color")[0].version
    parser = argparse.ArgumentParser(
        description=f"just another mod for{cs(' printing ', 'Chartreuse2', 'DeepPink4')}strings in{cs(' color.', 'green', 'navyblue')}",
        prog='string-color',
        formatter_class=rawtxt
    )
    
    #
    # COMMAND LINE ARGUMENTS
    #parser.print_help()
    #
    parser.add_argument(
        "color",
        help=f"""show info for a specific color:
$ string-color {cs("red", "red")}
$ string-color {cs("'#ffff87'", "#ffff87")}
$ string-color {cs("*grey*", "grey")} # wildcards acceptable
$ string-color {cs("'#E16A7F'", "#E16A7F")} # any hex not found will return the closest match""",

        nargs='?',
        default='none'
    )
    parser.add_argument('-x', '--hex', action='store_true', help='show hex values')
    parser.add_argument('-r', '--rgb', action='store_true', help='show rgb values')
    parser.add_argument('-t', '--term', action='store_true', help='show term numbers')
    parser.add_argument('--hsl', action='store_true', help='show hsl values')
    parser.add_argument('-a', '--alpha', action='store_true', help='sort by name')
    parser.add_argument('-i', '--inverse', action='store_true', help='show inverse colors')
    parser.add_argument('-v', '--version', action='version', version='%(prog)s '+version)
    args = parser.parse_args()
    color = args.color
    show_hex = args.hex
    show_rgb = args.rgb
    show_hsl = args.hsl
    show_term = args.term
    sort_alpha = args.alpha
    show_inverse = args.inverse
    if color == "none":
        # no positional arguments show all colors
        if sort_alpha:
            sortedc = sort_by_alpha()
        else:
            sortedc = COLORS
        data = []
        subdata = []
        cols = 8
        x = 0
        for key, value in sortedc.items():
            display = " "+value["name"]+" "
            if show_hex:
                display = " "+value["hex"]+" "
            if show_rgb:
                display = " "+value["rgb"]+" "
            if show_hsl:
                display = " "+value["hsl"]+" "
            if show_term:
                display = " "+value["term"]+" "
            rgb_arr = rgbtolist(value["rgb"])
            if int(rgb_arr[0])*0.299 + int(rgb_arr[1])*0.587 + int(rgb_arr[2])*0.114 > 140:
                black = "black"
            else:
                black = "white"
            if x < cols:
                if show_inverse:
                    subdata.append(cs(display, value["term"]))
                else:
                    subdata.append(cs(display, black, value["term"]))
            else:
                x = 0
                data.append(subdata)
                subdata = []
                if show_inverse:
                    subdata.append(cs(display, value["term"]))
                else:
                    subdata.append(cs(display, black, value["term"]))
            x += 1
        data.append(subdata)
        table = columnar(data, no_borders=True, justify='c')
        print(table)
    else:
        # positional arg found, showing info for color
        # sortedc is COLORS sorted by name
        sortedc = sort_by_alpha()
        colors_found = find_colors(color)
        if colors_found == 0:
            print(cs("no matching colors found.", "grey2"))
            print(cs("attempting to find closest matching xterm color...", "grey2"))
            all_rgbs = [tuple(rgbtolist(value["rgb"])) for key, value in COLORS.items()]
            if "#" in color:
                rgb_tup = hextorgb(color.lstrip('#'))
                print(cs("finding closest color to:", "SteelBlue4"), f"rgb({cs(rgb_tup[0], 'red')}, {cs(rgb_tup[1], 'green')}, {cs(rgb_tup[2], 'dodgerblue')})")
                closest_color = min(all_rgbs, key=partial(color_difference, rgb_tup))
                closest_hex = '#%02x%02x%02x' % closest_color
                colors_found = find_colors(closest_hex)
            elif "rgb" in color:
                rgb_tup = rgbtolist(color)
                print(cs("finding closest color to:", "SteelBlue4"), f"rgb({cs(rgb_tup[0], 'red')}, {cs(rgb_tup[1], 'green')}, {cs(rgb_tup[2], 'dodgerblue')})")
                closest_color = min(all_rgbs, key=partial(color_difference, tuple(rgb_tup)))
                closest_hex = '#%02x%02x%02x' % closest_color
                colors_found = find_colors(closest_hex)
            if colors_found == 0:
                print()
                print(cs("sorry, no matching colors found", "gold"))

    exit()

if __name__ == "__main__":
    main()
