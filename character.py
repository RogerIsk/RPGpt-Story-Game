from random import randint
from time import sleep
from utils import read_json_file

press_enter = 'Press ENTER to continue...\n'

class Character:
    '''Character class to store the character's data'''
    # This class is used for every character, PC and NPCs

    def _read_char_sheet(self):
        '''Read the data and get character's stats from the character sheet'''
        
        # unpack the stats dictionary to get all the character's data
        self.name = self.char_dictionary['name']
        self.hp = self.char_dictionary['hp']
        self.armor = self.char_dictionary['armor']
        self.atk = self.char_dictionary['atk']
        self.xp = self.char_dictionary['xp']

    def calc_dmg(self):
        '''randomize the attack damage by applying a percentage modifier to character's atk stat'''
        # roll for random percentage
        dmg_modifier = randint(75, 125) / 100
        # apply percentage to attack stat
        dmg = self.atk * dmg_modifier
        # Round and convert to integer
        dmg = int(round(dmg))
        return dmg

    def take_damage(self, dmg):
        '''Apply damage to PC when hit'''
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
    


class PC(Character):
    '''PC class for player's character's specific data and actions'''

    def __init__(self, sheet_path):
        '''Initialise the class with character's data from read_char_sheet'''
        # This class will be used only for the playable character and add specific stats
        # use the entire json file as the character dictionary
        self.char_dictionary = read_json_file(sheet_path)
        # Call read_char_sheet method to get both general and PC specific character's attributes
        self._read_char_sheet()

    def _read_char_sheet(self):
        '''Read the data and get character's stats from the character sheet'''
        # Inherit the instance attributes (characteristics) from the parent class Character
        super()._read_char_sheet()

        # unpack the stats dictionary to get the additional PC data
        self.race = self.char_dictionary['race']
        self.char_class = self.char_dictionary['char_class']
        self.level = self.char_dictionary['level']

    def attack(self, target):
        '''attack enemy'''
        input('Press ENTER to attack...\n')
        # calculate damage using calc_dmg()
        dmg = self.calc_dmg()
        sleep(1)
        print(f'{self.name} hits {target.name}')
        sleep(1)

        # apply damage to target
        target.take_damage(dmg)


class NPC(Character):
    '''NPC class for player's character's specific data and actions'''
    # For now it's only used to fetch the character's stats in a different way
    def __init__(self, sheet_path, npc_id):
        '''Initialise the class with character's data from read_char_sheet'''
        # Read the whole json file
        char_sheet = read_json_file(sheet_path)
        # Get the dictionary with the stats of the selected npc
        self.char_dictionary = char_sheet.get(npc_id, {})
        # read the dictionary to assign stats asthe character's object attributes
        self._read_char_sheet()

    def attack(self, target):
        '''attack enemy'''
        input(press_enter)
        # calculate damage using calc_dmg()
        dmg = self.calc_dmg()
        sleep(1)
        # print roll result
        print(f'You hit {target.name}')
        sleep(1.5)

        # apply damage to target
        target.take_damage(dmg)