provider "google" {
  credentials = file("../key.json")
  project     = "moustafa-gcp"
  region      = "us-east1"
}
