terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}


variable "internal_port" {
  description = "Internal port for the container"
  default     = 9876
}

variable "external_port" {
  description = "External port for accessing the container"
  default     = 5432
}

variable "container_name" {
  description = "Name of the Docker container"
  default     = "Alta3ResearchWebService"
}

resource "docker_image" "simplegoservice" {
  name         = "registry.gitlab.com/alta3/simplegoservice"
  keep_locally = true      // keep image after "destroy"
}

 resource "docker_container" "simplegoservice" {
  image = docker_image.simplegoservice.image_id
  name = var.container_name
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}

