import os
import psycopg2
import psycopg2.extras
from kivy.properties import StringProperty, NumericProperty
from random import randint
from time import sleep
from utils import read_json_file

image_folder = "Program_Files/items_96p"
press_enter = 'Press ENTER to continue...\n'

class Character:
    '''Character class to store the character's data'''
    # This class is used for every character, Hero and Enemys

    def __init__(self, db_config, char_name):
        '''intitialise a cursor to interact with db'''
        self.conn = psycopg2.connect(**db_config)
        self.conn.autocommit = True  # Set autocommit to True
        # Use a dictionary cursor, so we can extract the char data as a dictionary for readability
        self.cursor = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    def close(self):
        '''close the database connection'''
        self.cursor.close()
        self.conn.close()
    
    
    def print_attributes(self):
        print(f"{self.name} attributes:")
        for attr, value in vars(self).items():
            print(f"{attr}: {value}")


    def add_item_image_path(self):
        '''Update the image_file field of each item with the full image path'''
        if not self.items:
            print("No items to update.")
            return
        for item in self.items:
            if 'image_file' in item:
                item['image_file'] = os.path.join(image_folder, item['image_file'])
            else:
                print(f"Item {item} does not have an 'image_file' key.")


    def calc_dmg(self):
        '''randomize the attack damage by applying a percentage modifier to character's dmg stat'''
        # roll for random percentage
        dmg_modifier = randint(75, 125) / 100
        # apply percentage to attack stat
        dmg = self.dmg * dmg_modifier
        # Round and convert to integer
        dmg = int(round(dmg))
        return dmg    


    def take_damage(self, dmg):
        '''Apply damage to character when hit'''
        # substract armor stat from the damge received
        final_dmg = dmg - (dmg * self.armor / 100)
        # Round and convert to integer
        final_dmg = int(round(final_dmg))
        # remove the number of dmg points from the hit character's HP
        self.hp -= final_dmg
        print(f'{self.name} takes {final_dmg} damage')
        # if character has 0 HP, pronounce them DEAD!! (shouldn't have messed with opponent)
        if self.hp <= 0:
            sleep(1)
            print(f'{self.name} is dead!\n')
            sleep(1)
        else:
            print(f'and has {self.hp} HP remaining\n')
            sleep(0.5)
    


class Hero(Character):
    '''Hero class for player's character's specific data and actions'''

    def __init__(self, db_config, char_name):
        '''Initialise the class'''
        super().__init__(db_config, char_name)  # Call the parent class's __init__ method
        self._get_hero(char_name)  # Call the method to get hero data

    

    def _get_hero(self, char_name):
    # Query to fetch character data along with associated items
    # THIS CONTAINS A SUBQUERY ;) ;) ;)
        query = '''
        SELECT 
            character.*,
            ARRAY(
                SELECT json_build_object(
                    'item_id', item.item_id,
                    'name', item.name,
                    'type', item.type,
                    'bonus_type', item.bonus_type,
                    'bonus_value', item.bonus_value,
                    'image_file', item.image_file
                )
                FROM items item
                JOIN inventory inventory ON item.item_id = inventory.item_id
                WHERE inventory.character_id = character.character_id
            ) AS items
        FROM characters character
        WHERE character.name = %s;
        '''
        self.cursor.execute(query, (char_name,))
        char_data = self.cursor.fetchone()
        self.name = char_name
        # Importing the hero stats to instance attributes
        if char_data:
            self.character_id = char_data['character_id']
            self.species = char_data['species']  # Access the 'species' column
            self.gender = char_data['gender']
            self.char_class = char_data['class']  # Access the 'Class' column
            self.hp = char_data['hp']
            self.dmg = char_data['damage']
            self.armor = char_data['armor']
            # Save all owned items as a list in self.items
            # Each (python- and game-)item in this list will be a dictionary containing the item data
            self.items = char_data['items']
            # Update self.items by adding full path to item images
            self.add_item_image_path()
            self.eq_weapon = char_data['equipped_weapon']
            self.eq_armor = char_data['equipped_armor']
            # create kivy properties for each item attribute. We'll bind them to the InGameScreen in main
            self.create_kivy_properties()
            self.create_stats_view()
        else:
            return None
    
    def create_kivy_properties(self):
        # Dynamically create Kivy properties for each item attribute
        for item in (self.items):
            # fetch the item_id for each item in the dictionary
            item_id = item['item_id']

            for key, value in item.items():                
                # create a property name prefix for each item, including relevant item_id
                prop_name = f"item_{item_id}_{key}"
                if isinstance(value, str):
                    setattr(self.__class__, prop_name, StringProperty(value))
                elif isinstance(value, (int, float)):
                    setattr(self.__class__, prop_name, NumericProperty(value))
                print(f"Created property {prop_name} with value {value}")
        print('Properties created...')


    def create_stats_view(self):
        query = '''
        CREATE OR REPLACE VIEW character_full_stats AS
        SELECT 
            characters.character_id,
            characters.name,
            characters.species,
            characters.class,
            characters.hp,
            characters.damage,
            characters.armor,
            weapon.name AS equipped_weapon,
            weapon.bonus_value AS weapon_bonus,
            armor.name AS equipped_armor,
            armor.bonus_value AS armor_bonus
        FROM 
            characters
        LEFT JOIN 
            items AS weapon ON characters.equipped_weapon = weapon.item_id
        LEFT JOIN
            items AS armor ON characters.equipped_armor = armor.item_id;
        '''
        self.cursor.execute(query)

    def display_stats_view(self):
        query = '''
        SELECT 
            name, species, class, hp, damage, armor, equipped_weapon, weapon_bonus, equipped_armor, armor_bonus
        FROM 
            character_full_stats
        WHERE character_id = %s;
        '''
        self.cursor.execute(query, (self.character_id,))
        full_stats = self.cursor.fetchone()
        
        if full_stats:
            print('''
================================================
CHARACTER STATISTICS
''')
            # Get column names from cursor description
            column_names = [desc[0] for desc in self.cursor.description]
            
            # Create a dictionary of column names and values
            full_stats_dict = dict(zip(column_names, full_stats))
            
            # Print the dictionary
            for column, value in full_stats_dict.items():
                print(f'{column}: {value}')

        else:
            print('\nNo data found for the given character_id.\n')

    
    def attack(self, target):
        '''attack enemy'''
        input('Press ENTER to attack...\n')
        # calculate damage using calc_dmg()
        dmg = self.calc_dmg()
        sleep(1)
        print(f'You hit {target.name}')
        sleep(1)

        # apply damage to target
        target.take_damage(dmg)


class Enemy(Character):
    '''Enemy class for player's character's specific data and actions'''
    # For now it's only used to fetch the character's stats in a different way
    def __init__(self, db_config, char_name):
        '''Initialise the class'''
        super().__init__(db_config, char_name)  # Call the parent class's __init__ method
        self._get_enemy(char_name)  # Call the method to get hero data

    def _get_enemy(self, char_name):
        query = 'SELECT * FROM enemies WHERE name = %s'
        self.cursor.execute(query, (char_name,))
        char_data = self.cursor.fetchone()
        self.name = char_name
        # Importing the enemy stats to instance attributes
        if char_data:
            self.hp = char_data['hp']
            self.dmg = char_data['damage']
            self.armor = char_data['armor']
        return None

    def attack(self, target):
        '''attack enemy'''
        input(press_enter)
        # calculate damage using calc_dmg()
        dmg = self.calc_dmg()
        sleep(1)
        # print roll result
        print(f'{self.name} hits {target.name}')
        sleep(1.5)

        # apply damage to target
        target.take_damage(dmg)



# Character stuff
def instantiate_hero(db_config, char_name):
    '''Instantiate hero with character name'''
    # PLEASE DECLARE hero AS GLOBAL VARIABLE WHEN CALLED IN MAIN CODE
    try:
        hero = Hero(db_config, char_name)
        return hero
    except Exception as e:
        print('Character not found in database!')
        print(f'Error: {e}')
        return None


def instantiate_enemy(db_config, enemy_name):
    '''Instantiate enemy with character name'''
    # WILL NEED TO BE CALLED IN MAIN TO START COMBAT
    # PLEASE DECLARE enemy AS GLOBAL VARIABLE WHEN CALLED IN MAIN CODE
    try:
        enemy = Enemy(db_config, enemy_name)
        return enemy
    except Exception as e:
        print('Character not found in database!')
        print(f'Error: {e}')
        return None