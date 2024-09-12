# Stores the logic related to items
import os
import psycopg2
from utils import read_json_file

db_config = read_json_file("Program_Files/json_files/db_config.json")
image_folder = "/Program_Files/items_96p"

class Item:
    '''used to create an object for every item in the game'''
    def __init__(self, item_id, name, type, bonus_type, bonus_value, image_file):
        self.item_id = item_id
        self.name = name
        self.type = type
        self.bonus_type = bonus_type
        self.bonus_value = bonus_value
        self.image_file = image_file
        self.image_path = self.get_image_path(image_folder)

    def get_image_path(self, image_folder):
        '''add full image path to items (including directory)'''
        return os.path.join(image_folder, self.image_file)

    @staticmethod
    def fetch_all_items(db_config):
        conn = psycopg2.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("""
            SELECT item_id, name, type, bonus_type, bonus_value, image_file
            FROM items
        """)
        results = cursor.fetchall()
        cursor.close()
        conn.close()
        # Store items in adictionary with item_id as the key
        items = {result[0]: Item(*result) for result in results}
        return items