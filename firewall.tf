resource "google_compute_firewall" "mostafa-firewall-ssh" {
  name    = "mostafa-firewall-ssh"
  network = google_compute_network.mostafa-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"] 
  target_tags = ["mostafa"]
}
