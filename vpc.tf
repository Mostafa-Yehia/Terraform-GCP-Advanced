resource "google_compute_network" "mostafa-vpc" {
  project                 = "moustafa-gcp"
  name                    = "mostafa-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}
