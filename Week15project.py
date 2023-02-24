import boto3

def create_queue():
    sqs_client = boto3.client("sqs", region_name="us-east-1")
    response = sqs_client.create_queue(
        QueueName="Week15",
        Attributes={
            "DelaySeconds": "0",
            "VisibilityTimeout": "60",  # 60 seconds
        }
    )
    print(response)
    
    
    
    
def get_queue_url():
    sqs_client = boto3.client("sqs", region_name="us-east-1")
    response = sqs_client.get_queue_url(
        QueueName="Week15",
    )
    return response["QueueUrl"]
    
    
    