import boto3
s3 = boto3.resource('s3')
s3.meta.client.upload_file('/home/mahmoud/microserviese-task/test1-file.txt', 's3-bucket-micro-task', 'test1-file.txt')
print ("file uploaded successfully")