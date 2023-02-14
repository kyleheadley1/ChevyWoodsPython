import boto3

dynamodb = boto3.resource(
    'dynamodb',
    aws_access_key_id='*****',
    aws_secret_access_key='*****',
    )