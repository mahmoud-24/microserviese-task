import boto3
s3 = boto3.resource('s3')
s3.meta.client.upload_file('~/microserviese-task/test-file.txt/', 's3-bucket-micro-task', 'test-file.txt')
print ("file uploaded successfully")