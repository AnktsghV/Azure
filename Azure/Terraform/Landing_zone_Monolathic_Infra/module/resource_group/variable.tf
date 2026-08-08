variable "resource_groups" {
    description = "Map of resource groups to be created with their names, locations, and optional tags"
    type = map (object ({      # MAP (map is a key-value pair (like a dictionary))
                                # object (An object defines the required properties and data types for each Resource Group) 
        name = string
        location = string
        tag = optional(map(string))
    }))
}

