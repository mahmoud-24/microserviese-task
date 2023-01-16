import boto3
s3 = boto3.resource('s3')
s3.meta.client.upload_file('~/microserviese-task/', 's3-bucket-micro-task', '')
print ("file uploaded successfully")