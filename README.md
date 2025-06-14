# peertube-helm
Helm Chart for deploy peertube

Project structure:
```
.
├── configs
│   ├── amd
│   │   ├── nginx
│   │   │   ├── peertube.conf
│   │   │   └── peertube-ssl.conf
│   │   └── peertube
│   │       ├── custom-environment-variables.yaml
│   │       └── production.yaml
│   ├── intel
│   │   ├── nginx
│   │   │   ├── peertube.conf
│   │   │   └── peertube-ssl.conf
│   │   └── peertube
│   │       ├── custom-environment-variables.yaml
│   │       └── production.yaml
│   └── rockchip
│       ├── nginx
│       │   ├── peertube.conf
│       │   └── peertube-ssl.conf
│       └── peertube
│           ├── custom-environment-variables.yaml
│           └── production.yaml
├── templates
│   ├── _helpers.tpl
│   ├── cert-certmanager.yaml
│   ├── dp-peertube.yaml
│   ├── dp-pg.yaml
│   ├── dp-postfix.yaml
│   ├── dp-proxy.yaml
│   ├── dp-redis.yaml
│   ├── dp-runner.yaml
│   ├── gen-configmaps.yaml
│   ├── gen-secrets.yaml
│   ├── ingress.yaml
│   ├── issuer-certmanager.yaml
│   ├── ns.yaml
│   ├── pvc.yaml
│   ├── sa.yaml
│   ├── svc-peertube-rtmp.yaml
│   ├── svc-peertube.yaml
│   ├── svc-pg.yaml
│   ├── svc-postfix.yaml
│   ├── svc-proxy.yaml
│   └── svc-redis.yaml
├── values
│   ├── amd
│   │   ├── secrets
│   │   │   └── Example.yaml
│   │   └── Values.yaml
│   ├── intel
│   │   ├── secrets
│   │   │   └──Example.yaml
│   │   └── Values.yaml
│   └── rockchip
│       ├── secrets
│       │   └── Example.yaml
│       └── Values.yaml
├── LICENSE
├── README.md
├── Chart.yaml
└── values.yaml
```

Some parameters are hardcoded in templates. Some parameters of peertube and additional services are placed in the `configs` directory and are converted to configmap or secret Kubernetes resources. Some parameters are set using the `Values.yaml` ​​file of the helm for the respective architectures in the corresponding subdirectories of the `values` directory. The most sensitive, most personal settings are set in a secrets file of the Values format of the helm file in subdirectories named `secrets`. Examples of such secrets files are given in the `Example.yaml` files.

For the simplest deployment, you need to copy `Example.yaml` to another file name, for example `Secret.yaml`. Replace the data in it with current ones, and the secrets with more complex and secure ones.

Using this command, while in the root of the project, you can see which Kubernetes resources will be created:
```
helm template . -f values/amd/Values.yaml -f values/amd/secrets/Secret.yaml
```
The default settings are designed for deployment in a simple k3s cluster. With storages mounted by the `hostpath` method by the path in the host system `/mnt/peertube`. In the peertube namespace.\
In order for deployments to run, the following subdirectories need to be created in advance:
```
/mnt/peertube/pg
/mnt/peertube/config
/mnt/peertube/redis
/mnt/peertube/postfix
/mnt/peertube/assets
/mnt/peertube/data
```
If you are using a more complex cluster that has storage providers like `openebs` or `rook` or something else, in the Values ​​file you can replace the `hostpath` mount to the creation and mounting of `PersistensVolumeClaim`. In this case, you do not need to create directories on the Kubernetes host system.
