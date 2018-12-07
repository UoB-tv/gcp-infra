/*
    videos-store is used to store all videos uploaded by
    user which haven't yet been made public.
*/
resource "google_storage_bucket" "uob-tv-videos-store" {
    name = "uob-tv-videos"
    location = "europe-west2"
    storage_class = "NEARLINE"

    versioning {
        enabled = false
    }
}

resource "google_storage_bucket_acl" "uob-tv-videos-store-acl" {
    bucket = "${google_storage_bucket.uob-tv-videos-store.name}"
    role_entity = [
    ]
}



/*
    uob-tv-videos-public-store contains all public videos which have
    been transcoded.
 */
resource "google_storage_bucket" "uob-tv-videos-public-store" {
    name = "uob-tv-videos-public"
    location = "europe-west2"
    storage_class = "REGIONAL"

    versioning {
        enabled = false
    }

    cors {
        origin = ["*"]
        response_header = ["Content-Type"]
        method = ["GET", "HEAD"]
        max_age_seconds = 3600
    }
}

resource "google_storage_default_object_acl" "uob-tv-videos-public-default-acl" {
    bucket = "${google_storage_bucket.uob-tv-videos-public-store.name}"
    role_entity = [
        "READER:allUsers",
    ]
}

resource "google_storage_bucket_iam_binding" "uob-video-public-store-viewer-binding" {
    bucket = "${google_storage_bucket.uob-tv-videos-public-store.name}"
    role        = "roles/storage.legacyBucketReader"

    members = [
        "serviceAccount:${data.google_service_account.video-proc-service-account.email}",
    ]
}

resource "google_storage_bucket_iam_binding" "uob-video-public-store-writer-binding" {
    bucket = "${google_storage_bucket.uob-tv-videos-public-store.name}"
    role        = "roles/storage.legacyBucketWriter"

    members = [
        "serviceAccount:${data.google_service_account.video-proc-service-account.email}",
    ]
}

resource "google_pubsub_topic" "video-jobs-topic" {
    name = "video-proc-jobs-topic"
}

resource "google_pubsub_subscription" "video-proc-workers-subscription" {
    name = "video-proc-workers-subscription"
    topic = "${google_pubsub_topic.video-jobs-topic.name}"

    ack_deadline_seconds = 60
}

data "google_service_account" "video-proc-service-account" {
    account_id = "video-proc-sa"
}

data "google_iam_policy" "video-proc-sa-policy" {
    binding {
        role = "roles/storage.objectViewer"
        members = [
            "serviceAccount:${data.google_service_account.video-proc-service-account.email}"
        ]
    }
    binding {
        role = "roles/storage.objectCreator"
        members = [
            "serviceAccount:${data.google_service_account.video-proc-service-account.email}"
        ]
    }

    binding {
        role = "roles/pubsub.subscriber"
        members = [
            "serviceAccount:${data.google_service_account.video-proc-service-account.email}"
        ]
    }

    binding {
        role = "roles/pubsub.publisher",
        members = [
            "serviceAccount:${data.google_service_account.video-proc-service-account.email}"
        ]
    }
}

output "video-proc-sa-email" {
    value = "${data.google_service_account.video-proc-service-account.email}"
}

resource "google_service_account_key" "video-proc-sa-key" {
    service_account_id = "${data.google_service_account.video-proc-service-account.account_id}"
}

resource "kubernetes_secret" "video-proc-sa-credential" {
    metadata {
        name = "video-proc-sa-credential"
    }
    data {
        credentials.json = "${base64decode(google_service_account_key.video-proc-sa-key.private_key)}"
    }
}
