# Homelab Charts 

Umbrella chart for Hunter Wilkins' homelab

## Deploy chart

```
helm install <release-name> . -n <namespace> --create-namespace
```

### Test Chart

```
helm template <release-name> . --dry-run
```

## Service types

* `ClusterIP` exposes services internally. Use when using traefik 
* `NodePort` exposes services externally on local network. Default Aster - 192.168.1.111
* `LoadBalancer` exposes services externally with metallb