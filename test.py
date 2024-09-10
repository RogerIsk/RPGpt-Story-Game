from character import Hero, Enemy
from combat import combat

def main():

    # create a playable character and an enemy (npc) as instances of PC and Character classes
    hero = Hero("Dwarf female warrior")
    mummy = Enemy("Mummy")
    combat(hero, mummy)


if __name__ == '__main__':
    main()