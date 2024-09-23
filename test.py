
# from character import Hero, Enemy
# from combat import combat
# from utils import read_json_file

# db_config = read_json_file("Program_Files/json_files/db_config.json")

# def main():

#     create a playable character and an enemy (npc) as instances of PC and Character classes
#     hero = Hero(db_config, 'Grumbar')
#     mummy = Enemy(db_config, "mummy")
#     combat(hero, mummy)


# if __name__ == '__main__':
#     main()

# Test function to start with existing hero ====================================

from character import Hero, Enemy, instantiate_hero, instantiate_enemy
from utils import read_json_file, DatabaseUtils
from openai import OpenAI
from combat import combat
from stringcolor import *
import threading
import psycopg2
import pygame
import random
import atexit
import kivy
import json
import sys
import os
import re



def load_db_config():
    config_path = 'Program_Files/7_json_files/db_config.json'
    with open(config_path, 'r') as file:
        db_config = json.load(file)
    return db_config

# Step 2: Initialize db_utils using the loaded configuration
db_config = load_db_config()
db_utils = DatabaseUtils(db_config)
db_utils.connect_db()  # Establish connection to the database

# Replace with your actual model
model = "gpt-4o"

# Ensure the correct path resolution and print the resolved path
def get_full_path(relative_path):
    base_path = os.path.dirname(__file__)  
    full_path = os.path.join(base_path, relative_path)
    print(f"Resolved full path: {full_path}")  # Debug statement
    return full_path

# Example usage with additional checks
config_path = get_full_path("Program_Files/7_json_files/db_config.json")
if not os.path.exists(config_path):
    print(f"Error: File not found at {config_path}")
else:
    db_config = read_json_file(config_path)


instantiate_hero(db_config, 'Sora')