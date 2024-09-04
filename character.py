from time import sleep
from utils import read_json_file, roll_dice

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

    def attack(self, target, result):
        '''attack opponent'''
        # if target is hit, apply damage
        # target is hit if the attack roll is higher than target's armor
        if result >= target.armor:
            print(f'{self.name} hits {target.name}!\n')
            sleep(1)
            # apply damage to oponent (damage points = attacker's attack points)
            target.take_damage(self.atk)
        # if target is missed, stop the character's turn without dealing damage
        else:
            print(f'{self.name} misses\n')
            sleep(1.5)

    def take_damage(self, damage):
        '''Apply damage to PC when hit'''
        # remove the number of damage points from the hit character's HP
        self.hp -= damage
        # if character has 0 HP, pronounce them DEAD!! (shouldn't have messed with opponent)
        if self.hp <= 0:
            print(f'{self.name} is dead!\n')
            sleep(1)
        else:
            print(f'{self.name} takes {damage} damage! {self.hp} HP remaining.\n')
    


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
        # run the attack() method inherited from the Character class for the rest of the action
        # rolls dice with character's attack points as bonus
        # the roll will return the base result AND the final result
        # base result = random d20 | result = base_result + character's attack points
        base_result, result = roll_dice(self.atk)
        sleep(1)
        # print roll result
        print(f'Base attack score = {base_result}')
        sleep(1.5)
        print(f'Total attack score = {base_result} + {self.atk} attack points = {result}')
        sleep(3)
        print(f'{target.name}\'s armor = {target.armor}')
        sleep(2)

        # Inherit the rest of the attack process from the Character attack() method
        super().attack(target, result)


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
        # roll dice with character's attack points as bonus
        # the roll will return the base result AND the final result
        # base result = random d20 | result = base_result + character's attack points
        print(f'{self.name} attacks. Rolling for attack score.')
        sleep(2)
        base_result, result = roll_dice(self.atk)
        # print roll result
        print(f'Base attack score = {base_result}')
        sleep(1.5)
        print(f'Total attack score = {base_result} + {self.atk} attack points = {result}')
        sleep(3)
        print(f'{target.name}\'s armor = {target.armor}')
        sleep(2)

        # Inherit the rest of the attack process from the Character attack() method
        super().attack(target, result)