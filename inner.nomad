job "inner_service" {
  datacenters = ["us-east-1"]

  group "service" {
    count = 1

    network {
      port "http" {}
    }

    service {
      name     = "inner"
      provider = "nomad"
      port     = "http"
      address  = "${attr.unique.platform.aws.public-ipv4}"
    }

    task "env-reader" {
      driver = "docker"

      config {
        image = "mnomitch/env-reader"
        ports = ["http"]
      }

      env {
        PORT  = "${NOMAD_PORT_http}"
        VAR_A = "Hello,"
        VAR_B = "Traefik & Nomad Fans!"
      }
    }
  }
}
