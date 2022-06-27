job "traefik" {
  datacenters = ["us-east-1"]
  type        = "system"

  group "traefik" {
    network {
      port "http" {
        static = 80
      }

      port "admin" {
        static = 8080
      }
    }

    task "server" {
      driver = "docker"

      config {
        image = "traefik:2.8"
        ports = ["admin", "http"]
        args = [
          "--api.dashboard=true",
          "--api.insecure=true",
          "--entrypoints.web.address=:${NOMAD_PORT_http}",
          "--entrypoints.traefik.address=:${NOMAD_PORT_admin}",
          "--providers.nomad=true",
          "--providers.nomad.endpoint.address=http://3.95.169.195:4646"
        ]
      }
    }
  }
}
