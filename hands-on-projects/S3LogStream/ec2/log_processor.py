import boto3
import gzip
import os
import re
import logging
from io import BytesIO
from datetime import datetime

LOG_BUCKET = "s3logstream-access-logs-2097868"  # Replace or fetch via env
PREFIX = "logs/"

s3 = boto3.client('s3')
log_group = "/s3logstream/access-log-summary"
logs = boto3.client('logs')

def ensure_log_group_stream():
    try:
        logs.create_log_group(logGroupName=log_group)
    except logs.exceptions.ResourceAlreadyExistsException:
        pass
    try:
        logs.create_log_stream(logGroupName=log_group, logStreamName="access-summary")
    except logs.exceptions.ResourceAlreadyExistsException:
        pass

def send_to_cloudwatch(message):
    timestamp = int(datetime.utcnow().timestamp() * 1000)
    logs.put_log_events(
        logGroupName=log_group,
        logStreamName="access-summary",
        logEvents=[{
            'timestamp': timestamp,
            'message': message
        }]
    )

def parse_logs():
    result = s3.list_objects_v2(Bucket=LOG_BUCKET, Prefix=PREFIX)
    if 'Contents' not in result:
        return

    for obj in result['Contents']:
        key = obj['Key']
        if not key.endswith(".gz"):
            continue
        response = s3.get_object(Bucket=LOG_BUCKET, Key=key)
        bytestream = gzip.GzipFile(fileobj=BytesIO(response['Body'].read()))
        content = bytestream.read().decode("utf-8")

        lines = content.splitlines()
        count = len(lines)
        send_to_cloudwatch(f"Processed log file {key}, {count} entries.")

if __name__ == "__main__":
    ensure_log_group_stream()
    parse_logs()
