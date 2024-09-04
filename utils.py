import json
from random import randint


def read_json_file(file_path):
    '''Read the data from a json file'''
    with open(file_path, 'r') as file:
        return json.load(file)
    
def roll_dice(bonus=0):
    '''roll a dice with or without adding a bonus (default bonus is 0)'''
    base_result = randint(1, 20)
    # If there is a bonus, return base_result + final result
    if bonus != 0:
        result = base_result + bonus
        return base_result, result
    # If no bonus, return only base_result
    else:
        return base_result
    
