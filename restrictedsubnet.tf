resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-east1"
  network       = google_compute_network.mostafa-vpc.id
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.0.3.0/24"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.0.4.0/24"
  }
}