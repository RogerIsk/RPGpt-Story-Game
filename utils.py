import json
import psycopg2
from random import randint


class DatabaseUtils:
    """Class containing the methods to open and close a database connection."""
    def __init__(self, db_config):
        self.db_config = db_config
        self.conn = None
        self.cursor = None

    def connect_db(self):
        """Initialize a cursor to interact with the database."""
        self.conn = psycopg2.connect(**self.db_config)
        self.cursor = self.conn.cursor()

    def close(self):
        """Close the database connection."""
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()

    def mark_character_as_active(self, char_name):
        """Mark the newly created character as active and deactivate others."""
        try:
            # Set all characters as inactive first
            self.cursor.execute("UPDATE characters SET is_active = FALSE")
            self.conn.commit()

            # Mark the new character as active
            self.cursor.execute("UPDATE characters SET is_active = TRUE WHERE name = %s", (char_name,))
            self.conn.commit()

            print(f"[DatabaseUtils] Character '{char_name}' marked as active.")
        except Exception as e:
            self.conn.rollback()
            print(f"[DatabaseUtils] Error marking character as active: {e}")


def read_json_file(file_path):
    """Read the data from a JSON file."""
    with open(file_path, 'r') as file:
        return json.load(file)


def roll_dice(bonus=0):
    """Roll a dice with or without adding a bonus (default bonus is 0)."""
    base_result = randint(1, 20)
    if bonus != 0:
        result = base_result + bonus
        return base_result, result
    else:
        return base_result


# Shared hero variable
hero = None


# Function to load the database configuration
def load_db_config():
    config_path = 'Program_Files/7_json_files/db_config.json'
    with open(config_path, 'r') as file:
        return json.load(file)


    # Create a shared db_utils instance
    db_config = load_db_config()
    db_utils = DatabaseUtils(db_config)
    db_utils.connect_db()
