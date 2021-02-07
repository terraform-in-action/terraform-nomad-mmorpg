job "fabio" {
  datacenters = ["azure"]
  region = "${region}"
  type = "system"
  group "fabio" {
    volume "vol" {
      type      = "host"
      read_only = false
      source    = "fabio"
    }
    task "fabio" {
      driver = "docker"
      config {
        image = "fabiolb/fabio"
        network_mode = "host"
      }

      volume_mount {
        volume      = "vol"
        destination = "/etc/fabio/fabio.properties"
        read_only   = false
      }

      resources {
        cpu    = 200
        memory = 128
        network {
          mbits = 20
          port "db" {
            static = 27017
          }
          port "ui" {
            static = 9998
          }
        }
      }
    }
  }
}