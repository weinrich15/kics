resource "google_project" "my_project" {
  name       = "My Project"
  project_id = "your-project-id"
  org_id     = "1234567"
  auto_create_network = false
}

resource "google_project" "my_project2" {
  name       = "My Project"
  project_id = "your-project-id"
  org_id     = "1234567"
}