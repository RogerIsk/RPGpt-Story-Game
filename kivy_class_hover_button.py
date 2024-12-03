from kivy.uix.button import Button
from kivy.core.window import Window
from kivy.graphics import Rectangle
from kivy.uix.image import Image
import os


class HoverButton(Button):
    def __init__(self, **kwargs):
        super(HoverButton, self).__init__(**kwargs)
        Window.bind(mouse_pos=self.on_mouse_pos)

        # Store the default and hover image paths
        self.default_image = kwargs.get('default_image', 'Program_Files/original_button_image.png')
        self.hover_image = kwargs.get('hover_image', 'Program_Files/hover_button_image.png')

        # Preload images to ensure they are ready to be displayed
        self.preload_images()

        # Bind to changes in the button's position or size
        self.bind(pos=self.update_button_graphics, size=self.update_button_graphics)

        # Draw the default image on initialization
        self.update_button_graphics()

    def preload_images(self):
        """Preload button images to avoid white squares."""
        if os.path.exists(self.default_image):
            Image(source=self.default_image).texture  # Preload default image
        if os.path.exists(self.hover_image):
            Image(source=self.hover_image).texture  # Preload hover image

    def on_mouse_pos(self, *args):
        if not self.get_root_window():
            return
        pos = args[1]
        if self.collide_point(*pos):
            self.on_enter()
        else:
            self.on_leave()

    def on_enter(self):
        """Update the button graphics to display the hover image."""
        self.canvas.before.clear()
        with self.canvas.before:
            Rectangle(source=self.hover_image, pos=self.pos, size=self.size)

    def on_leave(self):
        """Update the button graphics to display the default image."""
        self.canvas.before.clear()
        with self.canvas.before:
            Rectangle(source=self.default_image, pos=self.pos, size=self.size)

    def update_button_graphics(self, *args):
        """Update button graphics when the button's position or size changes."""
        self.canvas.before.clear()
        with self.canvas.before:
            Rectangle(source=self.default_image, pos=self.pos, size=self.size)
