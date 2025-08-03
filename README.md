# Homelab Charts 

## Setup Helm Repository

1. Add Helm repository 
```sh
helm repo add hunterwilkins2 https://hunterwilkins2.github.io/homelab-charts
```

2. Install helm pkl plugin
```sh
helm plugin install https://github.com/hunterwilkins2/helm-pkl
```

## Deploy Chart

### Deploy as a standalone chart

1. Create _values.pkl_ and amend _Chart.pkl_
```pkl
amends "https://hunterwilkins2.github.io/homelab-charts/Chart.pkl"

name = "nginx"

deployment = new Deployment {
  image = "nginx"
}

service = new Service {
  targetPort = 80
}

ingress = new Ingress {
  enabled = false
}

volumes = new {
}

configmap = new {
}

secrets = new {
}
```

2. Deploy chart
```sh
helm pkl install --pkl-template values.pkl [RELEASE] hunterwilkins2/homelab-charts --namespace [NAMESPACE] --create-namespace
```

### Deploy as multiple in an umbrella chart

1. Create a new _Chart.yaml_
```yaml
apiVersion: v2
name: umbrella-charts
description: A Umbrella chart for kubernetes homelab
type: application
version: 0.1.0
appVersion: "1.0.0"
dependencies:
- name: homelab-charts
  version: "0.1.0"
  repository: hunterwilkins2
  alias: trolly
- name: homelab-charts
  version: "0.1.0"
  repository: hunterwilkins2
  alias: trolly-db
```

2. Create _values.pkl_ and import _Chart.pkl_ 
```pkl
import "https://hunterwilkins2.github.io/homelab-charts/Chart.pkl"

global = new Global {
  labels = new {
  }
  annotations = new {
  }
}

frontend = (Chart) {
  name = "frontend"

  deployment = new Chart.Deployment {
    image = "nginx"
  }

  service = new Chart.Service {
    targetPort = 80
  }

  configmap = new {
  }
  
  secrets = new {
  }
}

`trolly-db` = (Chart) {
  name = "trolly-db"

  deployment = new Chart.Deployment {
    type = "StatefulSet"
    image = "mariadb"
    tag = "10.11-jammy"
  }

  service = new Chart.Service {
    targetPort = 3306
  }

  configmap = new {
  }
  
  secrets = new {
    ["MARIADB_ROOT_PASSWORD"] = "my-secret-pw"
  }
}
```

3. Deploy the chart
```sh
helm pkl install --pkl-template values.pkl [RELEASE] . --namespace [NAMESPACE] --create-namespace
```


