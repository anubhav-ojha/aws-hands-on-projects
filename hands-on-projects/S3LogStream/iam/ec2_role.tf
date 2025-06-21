resource "aws_iam_role" "ec2_s3_log_processor" {
  name = "EC2S3LogProcessorRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_attach" {
  role       = aws_iam_role.ec2_s3_log_processor.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "cw_access_attach" {
  role       = aws_iam_role.ec2_s3_log_processor.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2LogProfile"
  role = aws_iam_role.ec2_s3_log_processor.name
}
