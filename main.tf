# data "aws_instance" "existing" {
#   instance_id = var.instance_id
# }
# resource "aws_ebs_volume" "data_vol" {
#     availability_zone = var.availability_zone
#     size = 600
#     type = "gp3"

#     tags = {
#         Name = "Data Volume"
#         ManagedBy = "Terraform"
#     }
  
# }
# resource "aws_volume_attachment" "ebs_volume_attachment" {
#     device_name = "/dev/sdf"
#     volume_id = aws_ebs_volume.data_vol.id
#     instance_id = data.aws_instance.existing.id
  
# }

data "aws_instance" "existing" {
  instance_id = var.instance_id
  user_data = file("user_data.sh")
  
  tags = {
    Name = "Existing Instance"
  }
}