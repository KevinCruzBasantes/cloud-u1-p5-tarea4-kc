#Configuracion del proveedor es AWS
provider "aws" {
    region = "us-east-1" #Region donde se despliegan los recursos

  
}
#Creamos el security group
resource "aws_security_group" "mi-sg-windows" {
  name        = "mi-security-group-terraform-windows"
  description = "Security group para terraform para instancia windows"
  vpc_id      = "vpc-0e8eef941e0d368ae"

  # Regla para Escritorio Remoto
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Regla de ingreso HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir todo el tráfico de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Declaracion de los recursos de AWS todo lo que quiera aprivicionar es un recursos(resource)
resource "aws_instance" "mi_instancia_windows" {
    ami = "ami-0b5f645abc199e666" #id de la imagen de aws windows server
    instance_type = "t3.micro"#tipo de instancia
    key_name="mi-clave"
    tags = {
    Name = "MiInstanciaTerraformWindows"
}
    vpc_security_group_ids = [aws_security_group.mi-sg-windows.id] #asignar el sg a la instancia
}
