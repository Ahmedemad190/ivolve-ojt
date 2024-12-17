#  Lab 30: OpenShift Security and RBAC

- Create a Service Account. 
-  Define a Role named pod-reader allowing read-only access to pods in the namespace.
-  Bind the pod-reader Role to the Service Account and get ServiceAccount token.
-  Make a Comparison between service account - role & role binding - and cluster role & cluster role binding.

The Comparsion

Service Account : 
- An identity used by pods/processes within the cluster to authenticate against the API server
- Namespace-scoped resource (exists within a specific namespace)
- Used for machine-to-machine communication within the cluster

Role & RoleBinding
- Defines a set of permissions (what actions can be performed on which resources)
- Can only reference resources within the same namespace
- Examples of permissions: get, list, create, update, delete, etc.

- ClusterRole
- Similar to Role but applies cluster-wide (across all namespaces)
Can define permissions for:
      - Cluster-scoped resources (nodes, PVs)
      - Resources across all namespaces
- ClusterRoleBinding
- Links (binds) a ClusterRole to users, groups, or service accounts
- Applies cluster-wide (across all namespaces)
- Can reference ClusterRoles only
- Grants permissions across all namespaces


