import json
import psycopg2
from random import randint

class DatabaseUtils:
    '''class containing the methods to open and close a connection'''
    # we can import these methods in another class
    # this way we can use all the class features without having to pass attributes individuallly between methods
    def __init__(self, db_config):
        self.db_config = db_config
        self.conn = None
        self.cursor = None

    def connect_db(self):
        '''Initialize a cursor to interact with db'''
        self.conn = psycopg2.connect(**self.db_config)
        # Use a dictionary cursor, so we can extract the char data as a dictionary for readability
        self.cursor = self.conn.cursor()

    def close(self):
        '''Close the database connection'''
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()


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
    
