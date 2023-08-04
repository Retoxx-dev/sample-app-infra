locals {
  location = "northeurope"
  project  = "sample-app"

  naming_convention_dash = "${local.project}-neu"

  tags = {
    "Owner"       = "Kacper Dziedzic",
    "Application" = "Sample App"
  }
}