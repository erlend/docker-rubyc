variable "LATEST" { default = "" }
variable "VERSION" { default = "3.1.3" }

group "default" {
  targets = ["rubyc"]
}

target "release" {
  inherits = ["rubyc"]
  output = ["type=registry"]
  platforms = [
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64/v8",
  ]
}

target "rubyc" {
  output = ["type=docker"]
  args = {
    VERSION = VERSION
  }
  tags = [
    "erlend/rubyc:${VERSION}",
    notequal("",LATEST) ? "erlend/rubyc:latest" : ""
  ]
}
