name             "nginx"
maintainer       "Phil Cohen"
maintainer_email "github@phlippers.net"
license          "All rights reserved"
description      "Installs/configures nginx"
long_description "Please refer to README.md"
version          "0.1.0"

recipe "nginx", "The default recipe which sets up the repository."
recipe "nginx::configuration", "Internal recipe to setup the configuration files."
recipe "nginx::service", "Internal recipe to setup the service definition."
recipe "nginx::light", "Install and configure the `nginx-light` package."

depends "apt"

supports "debian"
supports "ubuntu"