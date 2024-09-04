from character import PC, NPC
from combat import combat

def main():

    # create a playable character and an enemy (npc) as instances of PC and Character classes
    pc = PC("pc_sheet.json")
    goblin = NPC("npcs.json", "goblin")
    print(pc.char_dictionary)
    print(goblin.char_dictionary)
    input("")
    combat(pc, goblin)


if __name__ == '__main__':
    main()