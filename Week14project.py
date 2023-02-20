import boto3  #allows access to boto3

dynamodb = boto3.resource( #allows access to DynamoDB with boto3
    'dynamodb')


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

with table.batch_writer() as batch:
    batch.put_item(Item={"Name": "Alex", "Drink": "TequilaSeltzer"})
    batch.put_item(Item={"Name": "Zozo", "Drink": "Margarita"})
    batch.put_item(Item={"Name": "Melanie", "Drink": "Jameson"})
print(batch)
