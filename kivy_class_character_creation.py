from kivy.properties import ObjectProperty, BooleanProperty, StringProperty, NumericProperty
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.graphics import Color, RoundedRectangle
from kivy.core.text import Label as CoreLabel
from kivy.uix.textinput import TextInput
from kivy.uix.boxlayout import BoxLayout
from kivy.animation import Animation
from kivy.core.window import Window
from kivy.graphics import Rectangle
from kivy.uix.button import Button
from kivy.uix.widget import Widget
from kivy.uix.popup import Popup
from kivy.uix.image import Image
from kivy.uix.label import Label
from kivy.lang import Builder
from random import randint
from time import sleep
import threading
import random
import os
import json
import sys
import re



class CharacterCreation(Screen):
    def __init__(self, **kwargs):

        super(CharacterCreation, self).__init__(**kwargs)
        self.selected_gender = None
        self.selected_species = None
        self.selected_class = None
        self.selected_world_type = ''  # Initialize selected_world_type
        self.char_name = ""
        self.names_data = self.load_random_names()

    def load_random_names(self):
        # Load the names from the JSON file
        try:
            with open('Program_Files/7_json_files/random_character_names.json', 'r') as file:
                return json.load(file)
        except FileNotFoundError:
            print("[CharacterCreation]   names.json file not found.")
            return {}

    def show_initial_character_image(self):
        # Set the character showcase image to 'character_0.png'
        self.ids.character_image.source = 'Program_Files/2_character_creation_images/character_0.png'
        self.ids.character_image.reload()

    def preload_character_image(self):
        # Set the initial character image source without making it visible yet
        self.ids.character_image.source = 'Program_Files/2_character_creation_images/character_0.png'
        self.ids.character_image.opacity = 0  # Hide it initially

    def on_enter(self):
        # When entering the screen, show the initial image and update stats immediately
        self.ids.character_image.opacity = 1
        self.update_stats_display()

    def select_gender(self, gender):
        male_button = self.ids.male_button
        female_button = self.ids.female_button
        male_gif = self.ids.male_gif
        female_gif = self.ids.female_gif

        if gender == 'male':
            if male_button.state == 'down':
                male_gif.source = 'Program_Files/2_character_creation_images/2_active_male.gif'
                male_gif.anim_delay = 0.1
                female_button.state = 'normal'
                female_gif.source = 'Program_Files/2_character_creation_images/1_inactive_female.gif'
                female_gif.anim_delay = 0.1
                female_gif.reload()
                self.selected_gender = 'male'
            else:
                male_gif.source = 'Program_Files/2_character_creation_images/2_inactive_male.gif'
                male_gif.anim_delay = 0.1
                male_gif.reload()
                self.selected_gender = None

        elif gender == 'female':
            if female_button.state == 'down':
                female_gif.source = 'Program_Files/2_character_creation_images/1_active_female.gif'
                female_gif.anim_delay = 0.1
                male_button.state = 'normal'
                male_gif.source = 'Program_Files/2_character_creation_images/2_inactive_male.gif'
                male_gif.anim_delay = 0.1
                male_gif.reload()
                self.selected_gender = 'female'
            else:
                female_gif.source = 'Program_Files/2_character_creation_images/1_inactive_female.gif'
                female_gif.anim_delay = 0.1
                female_gif.reload()
                self.selected_gender = None

        self.update_create_button_state()
        self.update_character_image()
        self.update_stats_display()  # Update stats whenever a selection is made

    def select_species(self, species):
        human_button = self.ids.human_button
        elf_button = self.ids.elf_button
        dwarf_button = self.ids.dwarf_button
        human_gif = self.ids.human_gif
        elf_gif = self.ids.elf_gif
        dwarf_gif = self.ids.dwarf_gif

        if species == 'human':
            if human_button.state == 'down':
                human_gif.source = 'Program_Files/2_character_creation_images/3_active_human.gif'
                human_gif.anim_delay = 0.1
                elf_button.state = 'normal'
                dwarf_button.state = 'normal'
                elf_gif.source = 'Program_Files/2_character_creation_images/4_inactive_elf.gif'
                dwarf_gif.source = 'Program_Files/2_character_creation_images/5_inactive_dwarf.gif'
                elf_gif.reload()
                dwarf_gif.reload()
                self.selected_species = 'human'
            else:
                human_gif.source = 'Program_Files/2_character_creation_images/3_inactive_human.gif'
                human_gif.anim_delay = 0.1
                human_gif.reload()
                self.selected_species = None

        elif species == 'elf':
            if elf_button.state == 'down':
                elf_gif.source = 'Program_Files/2_character_creation_images/4_active_elf.gif'
                elf_gif.anim_delay = 0.1
                human_button.state = 'normal'
                dwarf_button.state = 'normal'
                human_gif.source = 'Program_Files/2_character_creation_images/3_inactive_human.gif'
                dwarf_gif.source = 'Program_Files/2_character_creation_images/5_inactive_dwarf.gif'
                human_gif.reload()
                dwarf_gif.reload()
                self.selected_species = 'elf'
            else:
                elf_gif.source = 'Program_Files/2_character_creation_images/4_inactive_elf.gif'
                elf_gif.anim_delay = 0.1
                elf_gif.reload()
                self.selected_species = None

        elif species == 'dwarf':
            if dwarf_button.state == 'down':
                dwarf_gif.source = 'Program_Files/2_character_creation_images/5_active_dwarf.gif'
                dwarf_gif.anim_delay = 0.1
                human_button.state = 'normal'
                elf_button.state = 'normal'
                human_gif.source = 'Program_Files/2_character_creation_images/3_inactive_human.gif'
                elf_gif.source = 'Program_Files/2_character_creation_images/4_inactive_elf.gif'
                human_gif.reload()
                elf_gif.reload()
                self.selected_species = 'dwarf'
            else:
                dwarf_gif.source = 'Program_Files/2_character_creation_images/5_inactive_dwarf.gif'
                dwarf_gif.anim_delay = 0.1
                dwarf_gif.reload()
                self.selected_species = None

        self.update_create_button_state()
        self.update_character_image()
        self.update_stats_display()  # Update stats whenever a selection is made

    def select_class(self, char_class):
        warrior_button = self.ids.warrior_button
        ranger_button = self.ids.ranger_button
        mage_button = self.ids.mage_button
        warrior_gif = self.ids.warrior_gif
        ranger_gif = self.ids.ranger_gif
        mage_gif = self.ids.mage_gif

        if char_class == 'warrior':
            if warrior_button.state == 'down':
                warrior_gif.source = 'Program_Files/2_character_creation_images/6_active_warrior.gif'
                warrior_gif.anim_delay = 0.1
                ranger_button.state = 'normal'
                mage_button.state = 'normal'
                ranger_gif.source = 'Program_Files/2_character_creation_images/7_inactive_ranger.gif'
                mage_gif.source = 'Program_Files/2_character_creation_images/8_inactive_mage.gif'
                ranger_gif.reload()
                mage_gif.reload()
                self.selected_class = 'warrior'
            else:
                warrior_gif.source = 'Program_Files/2_character_creation_images/6_inactive_warrior.gif'
                warrior_gif.anim_delay = 0.1
                warrior_gif.reload()
                self.selected_class = None

        elif char_class == 'ranger':
            if ranger_button.state == 'down':
                ranger_gif.source = 'Program_Files/2_character_creation_images/7_active_ranger.gif'
                ranger_gif.anim_delay = 0.1
                warrior_button.state = 'normal'
                mage_button.state = 'normal'
                warrior_gif.source = 'Program_Files/2_character_creation_images/6_inactive_warrior.gif'
                mage_gif.source = 'Program_Files/2_character_creation_images/8_inactive_mage.gif'
                warrior_gif.reload()
                mage_gif.reload()
                self.selected_class = 'ranger'
            else:
                ranger_gif.source = 'Program_Files/2_character_creation_images/7_inactive_ranger.gif'
                ranger_gif.anim_delay = 0.1
                ranger_gif.reload()
                self.selected_class = None

        elif char_class == 'mage':
            if mage_button.state == 'down':
                mage_gif.source = 'Program_Files/2_character_creation_images/8_active_mage.gif'
                mage_gif.anim_delay = 0.1
                warrior_button.state = 'normal'
                ranger_button.state = 'normal'
                warrior_gif.source = 'Program_Files/2_character_creation_images/6_inactive_warrior.gif'
                ranger_gif.source = 'Program_Files/2_character_creation_images/7_inactive_ranger.gif'
                warrior_gif.reload()
                ranger_gif.reload()
                self.selected_class = 'mage'
            else:
                mage_gif.source = 'Program_Files/2_character_creation_images/8_inactive_mage.gif'
                mage_gif.anim_delay = 0.1
                mage_gif.reload()
                self.selected_class = None

        self.update_create_button_state()
        self.update_character_image()
        self.update_stats_display()  # Update stats whenever a selection is made

    def reset_selections(self):
        # Reset all button states and selection variables
        self.ids.male_button.state = 'normal'
        self.ids.female_button.state = 'normal'
        self.ids.human_button.state = 'normal'
        self.ids.elf_button.state = 'normal'
        self.ids.dwarf_button.state = 'normal'
        self.ids.warrior_button.state = 'normal'
        self.ids.ranger_button.state = 'normal'
        self.ids.mage_button.state = 'normal'

        # Reset GIFs to their inactive states
        self.ids.male_gif.source = 'Program_Files/2_character_creation_images/2_inactive_male.gif'
        self.ids.female_gif.source = 'Program_Files/2_character_creation_images/1_inactive_female.gif'
        self.ids.human_gif.source = 'Program_Files/2_character_creation_images/3_inactive_human.gif'
        self.ids.elf_gif.source = 'Program_Files/2_character_creation_images/4_inactive_elf.gif'
        self.ids.dwarf_gif.source = 'Program_Files/2_character_creation_images/5_inactive_dwarf.gif'
        self.ids.warrior_gif.source = 'Program_Files/2_character_creation_images/6_inactive_warrior.gif'
        self.ids.ranger_gif.source = 'Program_Files/2_character_creation_images/7_inactive_ranger.gif'
        self.ids.mage_gif.source = 'Program_Files/2_character_creation_images/8_inactive_mage.gif'

        # Reload GIFs to update their state
        self.ids.male_gif.reload()
        self.ids.female_gif.reload()
        self.ids.human_gif.reload()
        self.ids.elf_gif.reload()
        self.ids.dwarf_gif.reload()
        self.ids.warrior_gif.reload()
        self.ids.ranger_gif.reload()
        self.ids.mage_gif.reload()

        # Reset selected options
        self.selected_gender = None
        self.selected_species = None
        self.selected_class = None
        
        # Disable the create button
        self.ids.create_button.disabled = True
        self.update_stats_display()  # Reset stats display to base stats

    def update_create_button_state(self):
        # Enable the "Continue" button if all selections are made and the character name is not empty
        if self.selected_gender and self.selected_species and self.selected_class and len(self.char_name) > 0:
            self.ids.create_button.disabled = False
        else:
            self.ids.create_button.disabled = True

    def update_character_image(self):
        # Check if all selections (gender, species, and class) are made
        if self.selected_gender and self.selected_species and self.selected_class:
            # Show the actual character based on the selections
            image_name = f'{self.selected_gender}_{self.selected_species}_{self.selected_class}.png'
            self.ids.character_image.source = f'Program_Files/5_playable_characters/{image_name}'
        else:   
            # Show 'character_0.png' if not all selections are made
            self.ids.character_image.source = 'Program_Files/2_character_creation_images/character_0.png'
        self.ids.character_image.reload()
        
    def validate_selection(self):
        
        # Ensure selected_world_type is not None
        if self.selected_world_type is None:
            self.selected_world_type = "Not selected"  # Provide a default world type

        # Save new character stats to the character database
        insert_query = """
        INSERT INTO characters (name, species, gender, class, hp, damage, armor, world_type, turns)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        char_data = (
            self.char_name,
            self.selected_species,
            self.selected_gender,
            self.selected_class,
            self.final_hp,
            self.final_dmg,
            self.final_armor,
            self.selected_world_type,
            0,  # Initial world_type and turns count
        )

        try:
            self.db_utils.cursor.execute(insert_query, char_data)
            self.db_utils.conn.commit()
            print("[CharacterCreation]   Character saved to the database.")

            # Mark the newly created character as active
            self.db_utils.mark_character_as_active(self.char_name)

            # Update hero with the current character's data
            hero = {
                "name": self.char_name,
                "species": self.selected_species,
                "gender": self.selected_gender,
                "class": self.selected_class,
                "hp": self.final_hp,
                "damage": self.final_dmg,
                "armor": self.final_armor,
                "world_type": self.selected_world_type,
            }
        except Exception as e:
            print(f"[CharacterCreation]   Error saving character: {e}")

        # Reset the selections after saving
        self.reset_selections()

        # Navigate to the map selection screen
        self.manager.current = 'map_selection'

    def on_leave(self):
        # Reset the character name when leaving the screen
        self.char_name = ""
        self.ids.char_name_input.text = ""  # Clear the TextInput

    def on_back_button_pressed(self):
        # Reset selections when back button is pressed
        self.reset_selections()
        self.manager.current = 'main_menu'

    def on_create_button_pressed(self):
        # Validate selection and create character
        self.validate_selection()

    def random_selection(self):
        # Randomly select gender
        gender_choice = random.choice(['male', 'female'])
        if gender_choice == 'male':
            self.ids.male_button.state = 'down'
            self.select_gender('male')
        else:
            self.ids.female_button.state = 'down'
            self.select_gender('female')

        # Randomly select species
        species_choice = random.choice(['human', 'elf', 'dwarf'])
        if species_choice == 'human':
            self.ids.human_button.state = 'down'
            self.select_species('human')
        elif species_choice == 'elf':
            self.ids.elf_button.state = 'down'
            self.select_species('elf')
        else:
            self.ids.dwarf_button.state = 'down'
            self.select_species('dwarf')

        # Select a random name based on gender and species after setting them
        try:
            names_list = self.names_data[self.selected_gender][self.selected_species]
            random_name = random.choice(names_list)
        except KeyError:
            random_name = "Unknown"  # Fallback in case of a missing key

        # Set the random name into the TextInput
        self.ids.char_name_input.text = random_name
        self.on_char_name_input(random_name)

        # Randomly select class
        class_choice = random.choice(['warrior', 'ranger', 'mage'])
        if class_choice == 'warrior':
            self.ids.warrior_button.state = 'down'
            self.select_class('warrior')
        elif class_choice == 'ranger':
            self.ids.ranger_button.state = 'down'
            self.select_class('ranger')
        else:
            self.ids.mage_button.state = 'down'
            self.select_class('mage')

        self.update_create_button_state()

    def on_char_name_input(self, text):
        # Get the TextInput widget
        input_box = self.ids.char_name_input
        
        # Measure the width of the text
        label = CoreLabel(text=text, font_name=input_box.font_name, font_size=input_box.font_size)
        label.refresh()  # Required to calculate the width
        text_width = label.texture.size[0]

        # Check if the text width exceeds the input box width minus padding
        max_width = input_box.width - input_box.padding[0] - input_box.padding[2]
        
        if text_width <= max_width:
            self.char_name = text.strip()  # Accept the text
        else:
            input_box.text = self.char_name  # Revert to the last accepted state

        # Update the button state whenever the text changes
        self.update_create_button_state()

    def update_stats_display(self):
        # Basic stats
        base_hp = 50
        base_dmg = 10
        base_armor = 10

        # Race bonuses
        race_bonus = {
            'human': {'hp': 0, 'dmg': 2, 'armor': 0},
            'elf': {'hp': 2, 'dmg': 0, 'armor': 0},
            'dwarf': {'hp': 0, 'dmg': 0, 'armor': 2},
        }

        # Class bonuses
        class_bonus = {
            'warrior': {'hp': 0, 'dmg': 0, 'armor': 5},
            'ranger': {'hp': 5, 'dmg': 0, 'armor': 0},
            'mage': {'hp': 0, 'dmg': 5, 'armor': 0},
        }

        # Get bonuses based on selected options or default to zero if not selected
        species_bonus = race_bonus.get(self.selected_species, {'hp': 0, 'dmg': 0, 'armor': 0})
        class_bonus_values = class_bonus.get(self.selected_class, {'hp': 0, 'dmg': 0, 'armor': 0})

        # Calculate final stats
        self.final_hp = base_hp + species_bonus['hp'] + class_bonus_values['hp']
        self.final_dmg = base_dmg + species_bonus['dmg'] + class_bonus_values['dmg']
        self.final_armor = base_armor + species_bonus['armor'] + class_bonus_values['armor']

        # Update the stats_widget label with formatted stats
        self.ids.stats_widget.text = (
            f"  DMG:    [color=#ff0000]{self.final_dmg}[/color]\n"
            f"   HP:       [color=#00ff00]{self.final_hp}[/color]\n"
            f"ARMOR:  [color=#d3d3d3]{self.final_armor}[/color]"
        )
