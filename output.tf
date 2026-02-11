output "volume_id" {
  value = aws_ebs_volume.data_vol.id
}

output "instance_az" {
  value = data.aws_instance.existing.availability_zone
}
