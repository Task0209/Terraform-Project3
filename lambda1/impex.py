import json
def lambda_handler(event, context):

    query_body = json.loads(event['body'])

    x = int(query_body ['x'])
    y = int(query_body ['y'])
    op = query_body['op']

    print(f"x:{x}, y:{y}, op:{op}")

    result = {}
    result = {'x': x, 'y': y}

    if op == 'add':
        result['result'] = add(x,y)
    elif op == 'sub':
        result['result'] = sub(x,y)
    elif op == 'mul':
        result['result'] = mul(x,y)
    else :
        result['result'] = f'{op} is not defined in lambda function'

    return {
        'statusCode': 200,
        "headers": {"Content-Type": "application/json"},
        'body': json.dumps(result)
    }

def add(x,y):
    return x+y

def sub(x,y):
    return x-y

def mul(x,y):
    return x*y