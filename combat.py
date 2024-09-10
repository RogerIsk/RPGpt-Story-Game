from time import sleep
from utils import roll_dice

def combat (hero, enemy):
    '''combat structure'''
    # the actual combat actions attack() and take_damage() are in character.py
    print('It\'s a fight!')
    sleep(1)

    # print every character's hp
    print(f'''
{hero.name}: {hero.hp} HP
{enemy.name}: {enemy.hp} HP
''')
    
    sleep(1.5)
    
    # throw an initiative dice. 
    input('Roll for initative. Press ENTER...')
    hero_init = roll_dice()
    sleep(1.5)
    print(f'You roll {hero_init}...')
    enemy_init = roll_dice()
    sleep(1.5)
    print(f'{enemy.name} rolls {enemy_init}...')
    sleep(1.5)

    # The character with highest score attacks first
    if hero_init > enemy_init:
        p1 = hero
        p2 = enemy
    else:
        p1 = enemy
        p2 = hero
    print(f'{p1.name} is starting\n')
    sleep(0.5)

    # start fighting turns until one of the characters is down to 0 hp
    while hero.hp > 0 and enemy.hp > 0:
        p1.attack(p2)
        # stop combat turns if player 2 drops to 0hp
        if p2.hp <= 0:
            break
        p2.attack(p1)
        # stop combat turns if player 1 drops to 0hp
        if p1.hp <= 0:
            break

    # If hero dies: game over
    if hero.hp <= 0:
        combat_result = "LOST"
    # If enemy dies: player wins
    if enemy.hp <= 0:
        combat_result = "WON"
        input('You won!')

    # return combat result to check_instructions()
    return f'[END_COMBAT, {combat_result}]'