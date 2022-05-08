data "google_iam_policy" "owner" {
  binding {
    role = "roles/owner"

    members = [
      "serviceAccount:${google_service_account.mostafa-sa.email}",
    ]
  }
}

resource "google_project_iam_member" "mostafa-iam" {
  project = "moustafa-gcp"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.mostafa-sa.email}"
}

resource "google_service_account" "mostafa-sa" {
  account_id   = "mostafa-sa"
  display_name = "mostafa"
  project = "moustafa-gcp"
}

resource "google_service_account_iam_policy" "mostafa-owner" {
  service_account_id = google_service_account.mostafa-sa.name
  policy_data        = data.google_iam_policy.owner.policy_data
}


resource "google_compute_instance" "mostafa-private-vm" {
  name         = "mostafa-private-vm"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  tags = ["mostafa"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "mostafa-vpc"
    subnetwork = "management-subnet"
  }

  metadata = {
    name = "private-vm"
  }

  allow_stopping_for_update = true


  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.mostafa-sa.email
    scopes = ["cloud-platform"]
  }
}