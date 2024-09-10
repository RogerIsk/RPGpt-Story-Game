import psycopg2
from random import randint
from time import sleep
from utils import read_json_file

press_enter = 'Press ENTER to continue...\n'

class Character:
    '''Character class to store the character's data'''
    # This class is used for every character, Hero and Enemys

    def __init__(self, db_config):
        '''intitialise a cursor to interact with db'''
        self.conn = psycopg2.connect(**db_config)
        self.cursor = self.conn.cursor()

    def close(self):
        '''close the database connection'''
        self.cursor.close()
        self.conn.close()

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

    def __init__(self, db_config, start_char):
        '''Initialise the class'''
        super().__init__(db_config)  # Call the parent class's __init__ method
        self._get_hero(start_char)  # Call the method to get hero data

    

    def _get_hero(self, start_char):
        query = "SELECT * FROM heroes WHERE class = %s"
        self.cursor.execute(query, (start_char,))
        char_data = self.cursor.fetchone()
        # REPLACE THE FOLLOWING LINE TO INTERACT WITH GUI
        self.name = input('Enter your name')
        # Importing the hero stats to instance attributes
        if char_data:
            self.race = char_data["Race"]  # Access the "Race" column
            self.char_class = char_data["Class"]  # Access the "Class" column
            self.hp = char_data["HP"]
            self.dmg = char_data["Damage"]
            self.armor = char_data["Armor"]
            self.items = char_data["Items"]
            self.eq_weapon = char_data["Weapon equipped"]
            self.eq_armor = char_data["Armor equipped"]
        return None
    
    
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
    def __init__(self, sheet_path, enemy_id):
        '''Initialise the class with character's data from read_char_sheet'''
        # Read the whole json file
        char_sheet = read_json_file(sheet_path)
        # Get the dictionary with the stats of the selected Enemy
        self.char_dictionary = char_sheet.get(enemy_id, {})
        # read the dictionary to assign stats asthe character's object attributes
        self._read_char_sheet()

    def _get_enemy(self, start_char):
        query = "SELECT * FROM enemies WHERE class = %s"
        self.cursor.execute(query, (start_char,))
        char_data = self.cursor.fetchone()
        # Importing the enemy stats to instance attributes
        if char_data:
            self.name = char_data["Name"]
            self.hp = char_data["HP"]
            self.dmg = char_data["Damage"]
            self.armor = char_data["Armor"]
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