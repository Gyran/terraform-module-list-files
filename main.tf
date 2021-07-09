variable "base_dir" { type = string }
variable "default_content_type" {
  type    = string
  default = "application/octet-stream"
}

locals {
  mime_types     = jsondecode(file("${path.module}/mime.json"))
  all_file_paths = fileset(var.base_dir, "**")

  files = { for path in local.all_file_paths : path => {
    source_path  = "${var.base_dir}/${path}"
    content_type = lookup(local.mime_types, regex("\\.([^.]+)$", path)[0], var.default_content_type)
  } }

}

output "files" {
  value = local.files
}
