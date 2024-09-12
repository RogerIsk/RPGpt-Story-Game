import psycopg2
import psycopg2.extras
from random import randint
from time import sleep
from utils import read_json_file

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
        query = "SELECT * FROM characters WHERE name = %s"
        self.cursor.execute(query, (char_name,))
        char_data = self.cursor.fetchone()
        self.name = char_name
        # Importing the hero stats to instance attributes
        if char_data:
            self.species = char_data["species"]  # Access the "species" column
            self.gender = char_data["gender"]
            self.char_class = char_data["class"]  # Access the "Class" column
            self.hp = char_data["hp"]
            self.dmg = char_data["damage"]
            self.armor = char_data["armor"]
            self.items = char_data["items"]
            self.eq_weapon = char_data["equipped_weapon"]
            self.eq_armor = char_data["equipped_armor"]
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
    def __init__(self, db_config, char_name):
        '''Initialise the class'''
        super().__init__(db_config, char_name)  # Call the parent class's __init__ method
        self._get_enemy(char_name)  # Call the method to get hero data

    def _get_enemy(self, char_name):
        query = "SELECT * FROM enemies WHERE name = %s"
        self.cursor.execute(query, (char_name,))
        char_data = self.cursor.fetchone()
        self.name = char_name
        # Importing the enemy stats to instance attributes
        if char_data:
            self.hp = char_data["hp"]
            self.dmg = char_data["damage"]
            self.armor = char_data["armor"]
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
    # declare hero as global to use it from anywhere in the code
    try:
        hero = Hero(db_config, char_name)
        return hero
    except Exception as e:
        print("Character not found in database!")
        print(f"Error: {e}")
        return None


def instantiate_enemy(db_config, enemy_name):
    '''Instantiate enemy with character name'''
    #WILL NEED TO BE CALLED IN MAIN TO START COMBAT
    # declare enemy as global to use it from anywhere in the code
    global hero
    try:
        enemy = Enemy(db_config, enemy_name)
    except Exception as e:
        print("Character not found in database!")
        print(f"Error: {e}")
        return None