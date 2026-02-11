resource "aws_ebs_volume" "data_vol" {
  availability_zone = data.aws_instance.existing.availability_zone
  size              = 600
  type              = "gp3"

  tags = {
    Name       = "Data Volume"
    ManagedBy = "Terraform"
  }
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.data_vol.id
  instance_id = data.aws_instance.existing.id
}
