from character import PC, NPC
from combat import combat

def main():

    # create a playable character and an enemy (npc) as instances of PC and Character classes
    pc = PC("pc_sheet.json")
    mummy = NPC("npcs.json", "mummy")
    combat(pc, mummy)


if __name__ == '__main__':
    main()