# Kustomize ArgoCD manifests

GitHub action used kustomize applications manifests

## Inputs
- **app-name:** 'The app name'
- **app-registry:** 'The Docker image registry name'
- **github-actor:** 'The github commit actor ID'
- **github-token:** 'The github PAT token to clone GitOps repo and repocreate PR'
- **k8s-manifest-repo-name:** 'The name of K8S manifests repository'
- **k8s-manifest-repo-ssh:** 'The SSH of K8S manifests repository'


**OBS.:** All inputs are **required**

## Outputs

There are no outputs for this action

## Example usage

```yaml
      - name: Kustomize step
        uses: <ORG NAME>/github-actions-kustomize-argocd-manifests@main
        with:
          app-name: '<The app name>'
          app-registry: '<The Docker image registry name>'
          github-actor: '<The github commit actor ID>'
          github-token: '<The github PAT token to clone GitOps repo and repocreate PR>'
          k8s-manifest-repo-name: '<The name of K8S manifests repository>'
          k8s-manifest-repo-ssh: '<The SSH of K8S manifests repository>'
```

## How to send updates?
If you wants to update or make changes in module code you should use the **develop** branch of this repository, you can test your module changes passing the `@develop` in module calling. Ex.:

```yaml
      # Example using this actions
      - name: Kustomize step
        uses: <ORG NAME>/github-actions-kustomize-argocd-manifests@develop
        with:
          app-name: '<The app name>'
          app-registry: '<The Docker image registry name>'
          github-actor: '<The github commit actor ID>'
          github-token: '<The github PAT token to clone GitOps repo and repocreate PR>'
          k8s-manifest-repo-name: '<The name of K8S manifests repository>'
          k8s-manifest-repo-ssh: '<The SSH of K8S manifests repository>'
```
After execute all tests you can open a pull request to the main branch.