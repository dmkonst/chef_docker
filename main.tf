/*specify aws keys as variables*/
variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}

/*create security group */
resource "aws_security_group" "terraform_chef" {
    name = "terraform_chef"
    description = "Security group for ec2 instance"
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}



provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "us-west-2"
}

/* specify keypair for remote connection*/
resource "aws_key_pair" "terraform_aws" {
    key_name = "terraform_aws"
    public_key = "${file("terraform_aws.pub")}"
}


resource "aws_instance" "chef_provisioning" {
  ami           = "ami-a58d0dc5"
  instance_type = "t2.micro"

  key_name = "${aws_key_pair.terraform_aws.key_name}"
  vpc_security_group_ids = ["${aws_security_group.terraform_chef.id}"]

  provisioner "file" {
    source = "chef"
    destination = "/home/ubuntu"
    connection {
      	type = "ssh"
        user = "ubuntu"
        private_key = "${file("terraform_aws")}"
        agent = "true"
        timeout = "1m"
      }
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /home/ubuntu/chef/provision.sh",
        "/home/ubuntu/chef/provision.sh"
    ]
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("terraform_aws")}"
        agent = "true"
        timeout = "5m"
        }
  }
}
