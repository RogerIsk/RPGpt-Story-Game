from character import Hero, Enemy
from combat import combat
from utils import read_json_file

db_config = read_json_file("Program_Files/json_files/db_config.json")

def main():

    # create a playable character and an enemy (npc) as instances of PC and Character classes
    hero = Hero(db_config, 'Grumbar')
    mummy = Enemy(db_config, "mummy")
    combat(hero, mummy)


if __name__ == '__main__':
    main()