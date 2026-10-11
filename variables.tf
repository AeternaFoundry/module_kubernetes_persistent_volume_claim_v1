variable "persistent_volume_claim_v1s" {
  description = <<EOT
Map of persistent_volume_claim_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
    - spec (block):
        - access_modes (required)
        - resources (required, block):
            - limits (optional)
            - requests (optional)
        - selector (optional, block):
            - match_expressions (optional, block):
                - key (optional)
                - operator (optional)
                - values (optional)
            - match_labels (optional)
        - storage_class_name (optional)
        - volume_mode (optional)
        - volume_name (optional)
Optional:
    - wait_until_bound
    - timeouts (block):
        - create (optional)
EOT

  type = map(object({
    wait_until_bound = optional(bool)
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    spec = object({
      access_modes = set(string)
      resources = object({
        limits   = optional(map(string))
        requests = optional(map(string))
      })
      selector = optional(object({
        match_expressions = optional(list(object({
          key      = optional(string)
          operator = optional(string)
          values   = optional(set(string))
        })))
        match_labels = optional(map(string))
      }))
      storage_class_name = optional(string)
      volume_mode        = optional(string)
      volume_name        = optional(string)
    })
    timeouts = optional(object({
      create = optional(string)
    }))
  }))
}

