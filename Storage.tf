# Create an EBS Volume
resource "aws_ebs_volume" "pendrive1" {
	availability_zone = var.availabilty_zone
	size              = 2

	tags = {
		"Name" = "PenDrive 1"
		"env"  = "Ansible"
	}
}

resource "aws_ebs_volume" "pendrive2" {
	availability_zone = var.availabilty_zone
	size              = 1

	tags = {
		"Name" = "PenDrive 2"
		"env"  = "Ansible"
	}
}

# Create an association between EC2 instances and EBS volumes
resource "aws_volume_attachment" "ebsattach1" {
	device_name = "/dev/sdb"
	volume_id   = aws_ebs_volume.pendrive1.id
	instance_id = aws_instance.managednode3.id
	force_detach = true

	depends_on = [
		aws_instance.managednode3
	]
}

resource "aws_volume_attachment" "ebsattach2" {
	device_name = "/dev/sdb"
	volume_id   = aws_ebs_volume.pendrive2.id
	instance_id = aws_instance.managednode4.id
	force_detach = true

	depends_on = [
		aws_instance.managednode4
	]
}