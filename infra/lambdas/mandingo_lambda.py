import boto3
import json
import os
import string
import uuid
import sys
import logging.config
import logging
import random



moves = set(['up', 'down', 'left', 'right'])
moves_and_fire = set(['up', 'down', 'left', 'right', 'fire-up', 'fire-down', 'fire-right', 'fire-left'])

def handler(event,context):
    print('RECEIVED EVENT:')
    print(event)

    
    if (random.uniform(0, 1)):
        my_move = random.choice(tuple(moves_and_fire))
    else:
        logger.info("Can't fire!!")
        my_move = random.choice(tuple(moves))

    return {'move': my_move}

