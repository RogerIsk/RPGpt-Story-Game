from character import Character, PC
from combat import combat

def main():

    # create a playable character and an enemy (npc) as instances of PC and Character classes
    pc = PC("pc_sheet.json")
    npc = Character("npcs.json")
    
    combat(pc, npc)


if __name__ == '__main__':
    main()