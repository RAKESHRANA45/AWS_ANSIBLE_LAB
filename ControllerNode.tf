data "template_file" "host_file" {
  template = file("./scripts/CNroot.sh")
  vars = {
    hostname = "control.${var.domain}.example.com"
    domain = var.domain
    remote_user = var.user
    node1 = aws_instance.managednode1.private_ip
    node2 = aws_instance.managednode2.private_ip
    node3 = aws_instance.managednode3.private_ip
    node4 = aws_instance.managednode4.private_ip
    node5 = aws_instance.managednode5.private_ip
  }
}

resource "aws_instance" "controlnode" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availabilty_zone
  key_name          = aws_key_pair.deployer.key_name
  user_data         = data.template_file.host_file.rendered

  tags = {
    Name  = "ControllerNode"
    env = "Ansible"
  }
}