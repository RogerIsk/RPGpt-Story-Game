from kivy.uix.screenmanager import Screen
from kivy.uix.image import Image
import os

class MenuScreen(Screen):
    def __init__(self, **kwargs):
        super(MenuScreen, self).__init__(**kwargs)
        self.preload_images()

    def preload_images(self):
        """Preload all button images into memory to avoid white flashes."""
        button_images = [
            'Program_Files/1_main_menu_images/original_button_image.png',
            'Program_Files/1_main_menu_images/new_game_button.png',
            'Program_Files/1_main_menu_images/load_game_button.png',
            'Program_Files/1_main_menu_images/exit_game_button.png',
        ]
        for image_path in button_images:
            if os.path.exists(image_path):
                Image(source=image_path).texture  # Load the image into memory

    def change_to_chat(self):
        self.manager.current = 'character_creation'