# Lab 28: Deployment vs. StatefulSet

- 1. Definition
Deployment: Manages stateless applications. Ensures a specific number of pod replicas are running and can easily handle scaling, rolling updates, and rollbacks.
StatefulSet: Manages stateful applications. Ensures ordered deployment, scaling, and management of pods with unique identities and stable storage.
- 2. Pod Identity
Deployment: Pods are treated as interchangeable and don't maintain a unique identity. Any pod can be replaced without concern for its order or name.
StatefulSet: Pods have a stable identity (a predictable name, e.g., my-app-0, my-app-1) that persists even if the pod is rescheduled.
- 3. Storage
Deployment: Pods usually use ephemeral storage. Data is lost when a pod is deleted unless external storage (e.g., PersistentVolumes) is explicitly used.
StatefulSet: Each pod can have its own dedicated PersistentVolume. Volumes are uniquely associated with each pod and retain data even if the pod is deleted or rescheduled.
