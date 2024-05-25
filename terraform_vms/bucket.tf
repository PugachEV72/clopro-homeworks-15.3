// Create Service Account
resource "yandex_iam_service_account" "servacc-for-bucket" {
    name      = "servacc-for-bucket"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "bucket-editor" {
    folder_id = var.folder_id
    role      = "storage.editor"
    member    = "serviceAccount:${yandex_iam_service_account.servacc-for-bucket.id}"
    depends_on = [yandex_iam_service_account.servacc-for-bucket]
}

resource "yandex_resourcemanager_folder_iam_member" "bucket-kms-encrypterDecrypter" {
    folder_id = var.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.servacc-for-bucket.id}"
    depends_on = [yandex_iam_service_account.servacc-for-bucket]
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "servacc-static-key" {
    service_account_id = yandex_iam_service_account.servacc-for-bucket.id
    description        = "static access key for bucket"
}

// Create KMS Key
resource "yandex_kms_symmetric_key" "my_symmetric_key" {
  name              = "my-symmetric-key"
  description       = "Key for object storage encryption"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
  lifecycle {
    prevent_destroy = true
  }
}

// Use keys to create bucket with encryption
resource "yandex_storage_bucket" "tanker72-bucket" {
  access_key = yandex_iam_service_account_static_access_key.servacc-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.servacc-static-key.secret_key
  bucket = "tanker72-first-bucket"
  max_size   = 100000

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.my_symmetric_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

// Add picture to bucket
resource "yandex_storage_object" "data-content" {
    access_key = yandex_iam_service_account_static_access_key.servacc-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.servacc-static-key.secret_key
    bucket = yandex_storage_bucket.tanker72-bucket.bucket
    key = "test_pic.jpg"
    source = "data/test_pic.jpg"
    acl    = "public-read"
    depends_on = [yandex_storage_bucket.tanker72-bucket]
}
