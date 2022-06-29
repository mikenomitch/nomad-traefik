job "outer_service" {
  datacenters = ["us-east-1"]

  group "service" {
    count = 2

    network {
      port "http" {
        to = 4001
      }
    }

    service {
      name     = "outer"
      provider = "nomad"
      port     = "http"
      address  = "${attr.unique.platform.aws.public-ipv4}"
      tags     = [
        "traefik.enable=true",
        "traefik.http.routers.http.rule=Path(`/outer`)"
      ]
    }

    task "curler" {
      driver = "docker"

      config {
        image = "mnomitch/curler"
        ports = ["http"]
      }

      env {
        PORT = 4001
      }

      # This gets a list of the addresses for inner-service and selects the first to query
      template {
        data = <<EOH
{{- range $index, $service := nomadService "inner" }}
{{- if eq $index 0}}
CURL_ADDR="http://{{.Address}}:{{.Port}}"
{{- end }}
{{- end }}
EOH
        destination = "local/file.env"
        env         = true
      }
    }
  }
}
