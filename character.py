import os
import psycopg2
import psycopg2.extras
from kivy.properties import StringProperty, NumericProperty
from random import randint
from item import Item
from time import sleep
from utils import read_json_file

item_image_folder = 'Program_Files/9_items_96p'
char_image_folder = 'Program_Files/5_playable_characters'
press_enter = 'Press ENTER to continue...\n'

class Character:
    '''Character class to store the character's data'''
    # This class is used for every character, Hero and Enemys

    def __init__(self, db_config, char_name):
        '''initialize a cursor to interact with db'''
        self.conn = psycopg2.connect(**db_config)
        self.conn.autocommit = True  # Set autocommit to True
        # Use a dictionary cursor, so we can extract the char data as a dictionary for readability
        self.cursor = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


    def close(self):
        '''close the database connection'''
        self.cursor.close()
        self.conn.close()


    def print_attributes(self):
        if self.name:
            print(f"{self.name} attributes:")
            for attr, value in vars(self).items():
                print(f"{attr}: {value}")
        else:
            print("Character data not initialized properly.")


    def add_item_image_path(self):
        '''Update the image_file field of each item with the full image path'''
        if not self.item_list:
            print("No items to update.")
            return
        for item in self.item_list:
            if 'image_file' in item:
                item['image_file'] = os.path.join(item_image_folder, item['image_file'])
            else:
                print(f"Item {item} does not have an 'image_file' key.")


    def calc_dmg(self):
        '''randomize the attack damage by applying a percentage modifier to character's dmg stat'''
        dmg_modifier = randint(75, 125) / 100
        dmg = self.dmg * dmg_modifier
        dmg = int(round(dmg))
        return dmg

    def take_damage(self, dmg):
        '''Apply damage to character when hit'''
        final_dmg = dmg - (dmg * self.armor / 100)
        final_dmg = int(round(final_dmg))
        self.hp -= final_dmg
        print(f'{self.name} takes {final_dmg} damage')
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
        self.current_xp = 0  # Initialize to 0
        self.xp_for_next_level = 50  # Example starting value
        self.level = 1
        super().__init__(db_config, char_name)  # Call the parent class's __init__ method
        self._get_hero(char_name)  # Call the method to get hero data

    

    def _get_hero(self, char_name):
        # Query to fetch character data along with associated items
        query = '''
        SELECT 
            characters.*,
            ARRAY(
                SELECT json_build_object(
                    'item_id', items.item_id,
                    'name', items.name,
                    'type', items.type,
                    'bonus_type', items.bonus_type,
                    'bonus_value', items.bonus_value,
                    'image_file', items.image_file
                )
                FROM items
                JOIN inventory ON items.item_id = inventory.item_id
                WHERE inventory.character_id = characters.character_id
            ) AS items
        FROM characters 
        WHERE characters.name = %s;
        '''
        self.cursor.execute(query, (char_name,))
        char_data = self.cursor.fetchone()

        # Print the retrieved character data to ensure species exists
        print(f"Character Data: {char_data}")

        self.name = char_name

        if char_data:
            self.character_id = char_data['character_id']
            self.species = char_data['species']  # Make sure this key exists
            self.gender = char_data['gender']
            self.char_class = char_data['class']  # Access the 'class' column
            self.hp = char_data['hp']
            self.base_dmg = char_data['damage']
            self.base_armor = char_data['armor']
            # Save all owned items as a list in item_list.items
            # Each (python- and game-)item in this list will be a dictionary containing the item data
            self.item_list = char_data['items']
            self.add_item_image_path()
            self.eq_weapon = char_data['equipped_weapon']
            self.eq_armor = char_data['equipped_armor']
            print('\nFetching weapon bonus\n')
            # fetch equipment bonus for weapon and armor and add it to base damage to get final damage
            self.dmg = self.base_dmg + self.add_equipment_bonus('equipped_weapon', self.eq_weapon)
            print('\nFetching armor bonus\n')
            self.armor = self.base_armor + self.add_equipment_bonus('equipped_armor', self.eq_armor)
            self.level = char_data['level']
            self.xp_for_next_level = char_data['xp_for_next_level']
            self.current_xp = char_data['current_xp']
            self.world_type = char_data['world_type']
            self.turns = char_data['turns']
            self.gold = char_data['gold']
            self.history = char_data['history']
            char_image_name = f'{self.gender}_{self.species}_{self.char_class}.png'
            self.char_image = os.path.join(char_image_folder, char_image_name)

            # Create Item objects and assign them to the hero
            self.create_items()

            self.create_stats_view()

        else:
            print("No character data found for this character name.")
            return None
        

    def add_equipment_bonus(self, item_type, item_id):
        # fetch the bonus data from equipped items
        # item_type = "equipped_weapon"/"equipped_armor"
        # item_id = equipped_weapon/equipped_armor
        query = f'''
        SELECT
            items.bonus_value
        FROM items
        JOIN characters ON items.item_id = characters.{item_type}
        WHERE characters.{item_type} = %s;
        '''
        self.cursor.execute(query, (item_id,))
        #bonus_value is returned as a tuple
        result = self.cursor.fetchone()
        # extract the bonus_value as integer
        if result:
            bonus_value = result[0]  # Extract the integer value from the tuple
        else:
            bonus_value = 0
        return bonus_value
    

    def create_items(self):
        # Create Item objects from the fetched item data
        for item_data in self.item_list:
            item = Item(
                item_id=item_data['item_id'],
                name=item_data['name'],
                item_type=item_data['type'],
                bonus_type=item_data['bonus_type'],
                bonus_value=item_data['bonus_value'],
                image_file=item_data['image_file']
            )
            # Dynamically create an attribute on the Hero instance
            setattr(self, f'item_{item.item_id}', item)
            print(f'created item: {item.name}, {item.item_type}, Bonus: {item.bonus_value}')


    def create_stats_view(self):
        # Drop the existing view if it exists
        drop_view_query = '''
        DROP VIEW IF EXISTS character_full_stats;
        '''
        self.cursor.execute(drop_view_query)

        # Recreate the view without renaming any columns
        create_view_query = '''
        CREATE VIEW character_full_stats AS
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
            armor.bonus_value AS armor_bonus,
            level,
            xp_for_next_level,  -- Directly reference xp_for_next_level
            current_xp,
            history,
            world_type,
            turns,
            gold
        FROM 
            characters
        LEFT JOIN 
            items AS weapon ON characters.equipped_weapon = weapon.item_id
        LEFT JOIN
            items AS armor ON characters.equipped_armor = armor.item_id;
        '''
        self.cursor.execute(create_view_query)


    def display_stats_view(self):
        query = '''
        SELECT 
            name, species, class, hp, damage, armor, equipped_weapon, weapon_bonus, equipped_armor, armor_bonus, level, xp_for_next_level, current_xp, gold, world_type, turns
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
                # Replace underscores with spaces and capitalize each word
                column = column.replace('_', ' ').title()
                # Replace names with clearer ones
                if column == 'Damage':
                    column = 'Base Damage'
                if column == 'Armor':
                    column = 'Base Armor'
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
    try:
        # Create a new hero object by passing the config and character name
        hero = Hero(db_config, char_name)
        return hero
    except Exception as e:
        print(f"Error instantiating Hero: {e}")
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