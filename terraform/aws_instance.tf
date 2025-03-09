data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = [var.image_name]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "strapi" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.deployer.key_name
  subnet_id = aws_subnet.public_subnets["mx-central-1a"].id

  tags = {
    Name = "Sleepy Api"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "4m"
  }

  provisioner "file" {
    source      = "./scripts"
    destination = "/home/ubuntu/.scripts"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/.scripts/*",
      "/home/ubuntu/.scripts/pullCode.sh ${local.repo.git_username} ${local.repo.git_token} ${local.repo.owner} ${local.repo.name}",
    ]
  }

  provisioner "file" {
    source      = "${var.terraform_root_path}/config/database.ts"
    destination = "/home/ubuntu/sleepy-api/config/database.ts"
  }

  provisioner "file" {
    source      = "${var.terraform_root_path}/config/plugins.ts"
    destination = "/home/ubuntu/sleepy-api/config/plugins.ts"
  }

  provisioner "file" {
    source      = "${var.terraform_root_path}/config/server.ts"
    destination = "/home/ubuntu/sleepy-api/config/server.ts"
  }

  provisioner "file" {
    source      = "${var.terraform_root_path}/ecosystem.config.js"
    destination = "/home/ubuntu/ecosystem.config.js"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/.scripts/*",
      "/home/ubuntu/.scripts/nodeSetup.sh",
    ]
  }

  depends_on = [aws_db_instance.sleepy_db]
}

resource "null_resource" "instance_details" {

  provisioner "local-exec" {
    command = <<EOF
      echo '{
        "instance_id": "${aws_instance.strapi.id}",
        "public_ip": "${aws_instance.strapi.public_ip}"
      }' > ./output/instance-details.json
    EOF
  }
}
