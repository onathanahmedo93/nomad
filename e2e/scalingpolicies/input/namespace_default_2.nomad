# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

job "horizontally_scalable" {
  datacenters = ["dc1"]
  type        = "service"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  group "horizontally_scalable" {

    scaling {
      min     = 1
      max     = 11
      enabled = false

      policy {
        // Setting a single value allows us to check the policy block is
        // handled opaquely by Nomad.
        cooldown = "14m"
      }
    }

    task "test" {
      driver = "raw_exec"

      config {
        command = "bash"
        args    = ["-c", "sleep 15000"]
      }
    }
  }
}
