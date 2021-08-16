data "template_file" "node1" {
  template = file("./scripts/MNroot.sh")
  vars = {
    hostname = "node1.${var.domain}.example.com"
    remote_user = var.user
  }
}

data "template_file" "node2" {
  template = file("./scripts/MNroot.sh")
  vars = {
    hostname = "node2.${var.domain}.example.com"
    remote_user = var.user
  }
}

data "template_file" "node3" {
  template = file("./scripts/MNroot.sh")
  vars = {
    hostname = "node3.${var.domain}.example.com"
    remote_user = var.user
  }
}

data "template_file" "node4" {
  template = file("./scripts/MNroot.sh")
  vars = {
    hostname = "node4.${var.domain}.example.com"
    remote_user = var.user
  }
}

data "template_file" "node5" {
  template = file("./scripts/MNroot.sh")
  vars = {
    hostname = "node5.${var.domain}.example.com"
    remote_user = var.user
  }
}

resource "aws_instance" "managednode1" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availabilty_zone
  key_name          = aws_key_pair.deployer.key_name
  user_data         = data.template_file.node1.rendered

  tags = {
    Name = "ManagedNode1"
    env  = "Ansible"
  }
}

resource "aws_instance" "managednode2" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availabilty_zone
  key_name          = aws_key_pair.deployer.key_name
  user_data         = data.template_file.node2.rendered

  tags = {
    Name = "ManagedNode2"
    env  = "Ansible"
  }
}

resource "aws_instance" "managednode3" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availabilty_zone
  key_name          = aws_key_pair.deployer.key_name
  user_data         = data.template_file.node3.rendered

  tags = {
    Name = "ManagedNode3"
    env  = "Ansible"
  }
}

resource "aws_instance" "managednode4" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availabilty_zone
  key_name          = aws_key_pair.deployer.key_name
  user_data         = data.template_file.node4.rendered

  tags = {
    Name = "ManagedNode4"
    env  = "Ansible"
  }
}

resource "aws_instance" "managednode5" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availabilty_zone
  key_name          = aws_key_pair.deployer.key_name
  user_data         = data.template_file.node5.rendered

  tags = {
    Name = "ManagedNode5"
    env  = "Ansible"
  }
}

