
## Build

```
docker build -t harbor.tdoer.cn/demo/demo-php:1.0.0 .
```

## Run

```
docker run --name demo-php -d -p 8080:80 harbor.tdoer.cn/demo/demo-php:1.0.0
```

## Check Installation

```
docker run --name demo-php -it --rm harbor.tdoer.cn/demo/demo-php:1.0.0 /bin/bash
```