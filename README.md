Example usage to upload files to S3

```tf
module "file_list" {
  source = "github.com/Gyran/terraform-module-list-files"
gi
  base_dir = "path/to/lots/of/files"
}

resource "aws_s3_bucket_object" "objects" {
  for_each     = module.file_list.files
  bucket       = "my-cool-aws-bucket"
  key          = each.key
  source       = each.value.source_path
  etag         = filemd5(each.value.source_path)
  content_type = each.value.content_type
}
```

Inspired by https://engineering.statefarm.com/blog/terraform-s3-upload-with-mime/
