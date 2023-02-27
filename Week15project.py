import logging

import time
import boto3
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)
sqs = boto3.resource('sqs')

def create_sample_queue(name, queue_attributes=None):
    if not queue_attributes:
        queue_attributes = {}
    try:
        queue = sqs.create_queue(
            QueueName=name,
            Attributes=queue_attributes
        )
        logger.info("Created queue '%s' with URL=%s", name, queue.url)
    except ClientError as error:
        logger.exception("Couldn't create queue named '%s'.", name)
        raise error
    else:
        return queue
    
if __name__=="__main__":
    # create standard queue
    standard_queue_attributes = {
            'MaximumMessageSize': str(1024),
            'ReceiveMessageWaitTimeSeconds': str(20)
        }    
    standard_queue_name = "Week15pro"
    standard_queue = create_sample_queue(standard_queue_name, standard_queue_attributes)
    print(f"Created queue with URL: {standard_queue.url}.")

   
    

 
    
    
    