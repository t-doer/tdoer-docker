
## Build

```
docker build -t harbor.tdoer.cn/demo/demo-nginx:1.0.0 .
```

## Run

```
docker run --name demo-nginx -d -p 8080:80 harbor.tdoer.cn/demo/demo-nginx:1.0.0
```

## Check Installation

```
docker run --name demo-nginx -it --rm harbor.tdoer.cn/demo/demo-nginx:1.0.0 /bin/bash
```