# peertube-helm
Helm Chart for deploy peertube

## Project structure
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

For the simplest deployment, you need to copy `Example.yaml` to another file name, for example `Secrets.yaml`. Replace the data in it with current ones, and the secrets with more complex and secure ones.

Using this command, while in the root of the project, you can see which Kubernetes resources will be created:
```
helm template . -f values/amd/Values.yaml -f values/amd/secrets/Secrets.yaml
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

## Specific spec Values.yaml
`namespace`: - This specifies the default namespace unless another one was specified during application installation.\
`defaultName`: - This specifies the application name that will be used as the default prefix for all Kubernetes resource names. This value is used unless otherwise specified when the application was installed.\
`arch`: - This specifies the architecture present in the configurations. The corresponding subdirectories and files should exist in the "configs" and "values" ​​directories.\
`tz`: - This option will set the timezone environment variable for all application deployments.\
`service`: - This describes the specification of the main service parameters that are specific to a specific deployment. The following fields are currently available:
```
    type: NodePort # or LoadBalancer
    ports:
    - name: port-name # or any other
      port: 1234 # or any other
      targetPort: portname # or any other
      protocol: TCP # or UDP
      nodePort: 4321 # or any other
```
But existing parameters cannot be edited.\
`certManager`: - By default, it is assumed that `cert-manager` is already installed in the kubernetes cluster in the "cert-manager" namespace. However, this can be changed with this parameter. Available values:
```
  enable: true # or false
  namespace: cert-manager # or any other
```
If set to "true", the "Clusterissuer" and "Certificate" will be installed for your application. The domain and credentials is used from the "Secrets.yaml" file.\
`storage`: - This specifies the storage mount options for specific deployments when using PersistensVolumeClaim. Here is an example for redis:
```
    redisData:
      accessModes: ReadWriteMany
      storageSize: 1G # or any other
      storageClassName: lvm-storage # from you storage provider
```
This will create and mount storage for redis.\
`hostPath`: - This specifies the storage mount options for specific deployments when using hostpath.
```
    redisData:
      path: "/mnt/peertube/redis"
```
The directory "/mnt/peertube/redis" must exist on the host system of the kubernetes node

Some storage must be mounted by multiple deployments at the same time, so their specification is separate.\
Here is an example of storage for "assets" using PersistensVolumeClaim:
```
assets:
  storage:
    accessModes: ReadWriteMany
    storageSize: 1G # or any other
    storageClassName: lvm-storage # from you storage provider
```
Here is an example of storage for "assets" using hostpath:
```
assets:
  hostPath:
    path: "/mnt/peertube/assets"
```
The directory "/mnt/peertube/assets" must exist on the host system of the kubernetes node.\
Ingress is disabled by default, as the default is to use a very simple kubernetes cluster, such as k3s.\
All other parameters in Values ​​repeat the kubernetes specification, its description can be found in the kubernetes documentation.

## Specific spec Secrets.yaml
It is important that all parameters present in Example.yaml are present in your secret!

`common`: - These are common settings that are used by different deployments, services, and are relevant for the entire application as a whole, not just a part of it. This is where you set the domain of your application, for certificate configuration, and peertube itself.\
`cert`: - Here are the specific settings for cert-manager. By default, the `CloudFlare` API is used.\
`peertube`: - Here are the specific settings for peertube. Confidential and simply specific parameters specific to your application.\
`pg`: - Here are the postgresql database credentials. Be sure to change them to something more difficult.\
`postfix`: - Since peertube requires the use of a mail server, this application deploys a `postfix` relay, and its parameters are listed here. You can read more about them in the official peertube documentation.\
`runner`: - There is also a peertube-runner deployment. However, because it does not yet know how to transcode with custom parameters, this deployment is disabled by default.\
`proxy`: - Since the cluster should have cert-manager deployed by default. So by default `ssl` is enabled in the proxy configuration. At the moment it is `nginx`. If you set `false`, the nginx config without ssl will be used, but this config is designed for the fact that there is also a proxy server in front of it, on which ssl and `proxy_protocol` are enabled.\
`redis`: - No specific configuration or secrets yet
