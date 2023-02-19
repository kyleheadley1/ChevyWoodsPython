import boto3  #allows access to boto3

dynamodb = boto3.resource(
    'dynamodb',
    aws_access_key_id='AKIAS6FLDRQ5YYONVTUB',
    aws_secret_access_key='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',
    )


# Create the DynamoDB table.
table = dynamodb.create_table ( # Create the DynamoDB table.
    TableName = 'DrinkChoice',
       KeySchema = [
        {
            'AttributeName': 'Name',
            'KeyType': 'HASH'
        },
        {
            'AttributeName': 'Drink',
            'KeyType': 'RANGE'
        }
    ],
    AttributeDefinitions=[
        {
            'AttributeName': 'Name',
            'AttributeType': 'S'
        },
        {
            'AttributeName': 'Drink',
            'AttributeType': 'S'
        },
    ],
    ProvisionedThroughput={
        'ReadCapacityUnits': 5,
        'WriteCapacityUnits': 5
    }
)


table.wait_until_exists() # Waits until the table exists before finishing

print(table) #returns confirmation of table creation


