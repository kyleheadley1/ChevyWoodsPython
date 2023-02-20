import boto3

# replace the keys below

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('DrinkChoice')
with table.batch_writer() as batch:
    batch.put_item(Item={"Name": "Alex", "Drink": "TequilaSeltzer"})
    batch.put_item(Item={"Name": "Zozo", "Drink": "Margarita"})
    batch.put_item(Item={"Name": "Melanie", "Drink": "Jameson"})
print(batch)