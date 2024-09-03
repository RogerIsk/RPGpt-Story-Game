from time import sleep
from utils import roll_dice

def combat (pc, npc):
    '''combat system'''
    print('It\'s a fight!')
    sleep(2)

    # print every character's hp
    print(f'''
{pc.name}: {pc.hp} HP
{npc.name}: {npc.hp} HP
''')
    
    sleep(1.5)
    
    # throw an initiative dice. 
    input('Roll for initative. Press ENTER...')
    pc_init = roll_dice()
    sleep(1.5)
    print(f'{pc.name} rolls {pc_init}...')
    npc_init = roll_dice()
    sleep(1.5)
    print(f'{npc.name} rolls {npc_init}...')
    sleep(1.5)

    # The character with highest score attacks first
    if pc_init > npc_init:
        p1 = pc
        p2 = npc
    else:
        p1 = npc
        p2 = pc
    print(f'{p1.name} is starting\n')
    sleep(1.5)

    # start fighting turns until one of the characters is down to 0 hp
    while pc.hp > 0 and npc.hp > 0:
        p1.attack(p2)
        # stop combat turns if player 2 drops to 0hp
        if p2.hp <= 0:
            break
        p2.attack(p1)
        # stop combat turns if player 1 drops to 0hp
        if p1.hp <= 0:
            break

    # If pc dies: game over
    if pc.hp <= 0:
        input('GAME OVER...')
        quit()
    # If npc dies: player wins
    if npc.hp <= 0:
        input('You won!')