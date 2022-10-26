import json

def handler(event,context):
    print('RECEIVED EVENT:')
    value = {
        "name": "mandingos",
        "email": "jordi.pala@claranet.es"
    }
   
    return  value


