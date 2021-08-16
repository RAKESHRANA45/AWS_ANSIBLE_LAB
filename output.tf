output "WorkStation" {
  value = "${var.user}@${aws_instance.controlnode.public_ip}"
}
