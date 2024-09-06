import json
import os
from functools import partial
import colorama
colorama.init()
class String:
    """A regular string"""
    def __init__(self, string):
        self.string = string

    def render(self):
        return self.string

    def bold(self):
        """Make string bold."""
        return Bold(str(self))

    def cs(self, color, bkg=None):
        """Color a string"""
        return Color(str(self), color, bkg)

    def underline(self):
        """Underline a string"""
        return Underline(str(self))

    def __str__(self):
        return self.render()

    def concatenate(self, other, order=None):
        """Shared logic for __add__() and __radd__()"""
        types = [int, float, type(open)]
        if type(other) in types:
            raise TypeError('Cannot concat ' + ', '.join([str(t) for t in types]))
        try:
            other = str(other)
            if order == "reverse":
                return other + self.render()
            else:
                return self.render() + other
        except Exception:
            raise TypeError(f"Cannot concat {type(other)}")

    def __add__(self, other):
        return self.concatenate(other)

    def __radd__(self, other):
        return self.concatenate(other, "reverse")

    def __format__(self, format_spec):
        return f'{self.render():{format_spec}}'

class Bold(String):
    "Make string bold"
    def render(self):
        return f"\033[1m{self.string}\033[0m"


def _load_colors():
    colors_path = os.path.join(
        os.path.abspath(os.path.dirname(__file__)),
        'colors.json'
    )
    with open(colors_path) as f:
        colors = json.loads(f.read())
    return colors


class Color(String):
    "Color a string"
    colors = _load_colors()

    def __init__(self, string, color, bkg=None):
        self.string = string
        self.color = color
        self.bkg = bkg

    @staticmethod
    def hextorgb(hex_value):
        "convert hex values to rgb tuple"
        return tuple(int(hex_value[i:i+2], 16) for i in (0, 2, 4)) 

    @staticmethod
    def rgbtolist(rgb):
        "clean up rgb(255, 255, 255), and convert to list"
        rgb_tup = rgb.replace("rgb(", "") 
        rgb_tup = rgb_tup.replace(")", "") 
        rgb_tup = rgb_tup.split(",")
        rgb_tup = [int(x.strip()) for x in rgb_tup]
        return rgb_tup

    @staticmethod
    def color_difference(testColor, otherColor):
        "test diff between two rgbs"
        difference = 0 
        difference += abs(testColor[0]-otherColor[0])
        difference += abs(testColor[1]-otherColor[1])
        difference += abs(testColor[2]-otherColor[2])
        return difference

    def find_color(self):
        """find a color"""
        ret = False
        bkg_term = None
        if self.bkg is not None:
            for key, value in self.colors.items():
                if (self.bkg.lower() == value["name"].lower() or
                        self.bkg == value["hex"] or
                        self.bkg == value["term"]):
                    bkg_term = value["term"]
                    break
        for key, value in self.colors.items():
            if (self.color.lower() == value["name"].lower() or
                    self.color == value["hex"] or
                    self.color == value["term"]):
                if bkg_term:
                    return f"\033[38;5;{value['term']};48;5;{bkg_term}m{self.string}\033[0m"
                else:
                    return f"\033[38;5;{value['term']}m{self.string}\033[0m"
                break
        if not ret:
            return self.string

    def render(self):
        """color a string"""
        try_one = self.find_color()
        if try_one != self.string:
            return try_one
        else:
            all_rgbs = [tuple(self.rgbtolist(value["rgb"])) for key, value in self.colors.items()]
            try_two = self.string
            if "#" in self.color:
                rgb_tup = self.hextorgb(self.color.lstrip('#'))
                closest_color = min(all_rgbs, key=partial(self.color_difference, rgb_tup))
                self.color = '#%02x%02x%02x' % closest_color
                try_two = self.find_color()
            elif "rgb" in self.color:
                rgb_tup = self.rgbtolist(self.color)
                closest_color = min(all_rgbs, key=partial(self.color_difference, tuple(rgb_tup)))
                self.color = '#%02x%02x%02x' % closest_color
                try_two = self.find_color()
            if try_two != self.string:
                return try_two
            else:
                return self.string

class Underline(String):
    "Underline a string"
    def render(self):
        return f"\033[4m{self.string}\033[0m"
