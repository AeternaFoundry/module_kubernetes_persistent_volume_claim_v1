resource "kubernetes_persistent_volume_claim_v1" "persistent_volume_claim_v1s" {
  for_each = var.persistent_volume_claim_v1s

  wait_until_bound = each.value.wait_until_bound

  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  spec {
    access_modes = each.value.spec.access_modes
    resources {
      limits   = each.value.spec.resources.limits
      requests = each.value.spec.resources.requests
    }
    dynamic "selector" {
      for_each = each.value.spec.selector != null ? [each.value.spec.selector] : []
      content {
        dynamic "match_expressions" {
          for_each = selector.value.match_expressions != null ? selector.value.match_expressions : []
          content {
            key      = match_expressions.value.key
            operator = match_expressions.value.operator
            values   = match_expressions.value.values
          }
        }
        match_labels = selector.value.match_labels
      }
    }
    storage_class_name = each.value.spec.storage_class_name
    volume_mode        = each.value.spec.volume_mode
    volume_name        = each.value.spec.volume_name
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
    }
  }
}

