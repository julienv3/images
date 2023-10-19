terraform {
  required_providers {
    oci = { source = "chainguard-dev/oci" }
  }
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

module "test-latest" {
  source = "./tests"
  digests = {
    operator = module.operator.image_ref
  }
}

resource "oci_tag" "latest" {
  for_each = {
    "operator" : module.operator.image_ref
  }
  digest_ref = each.value
  tag        = "latest"
}

resource "oci_tag" "latest-dev" {
  for_each = {
    "operator" : module.operator.dev_ref
  }
  digest_ref = each.value
  tag        = "latest-dev"
}
