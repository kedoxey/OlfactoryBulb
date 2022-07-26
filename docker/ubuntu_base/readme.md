## Build image
```
docker build . -t ob_image
```

## Run image
```
docker run -t -d --name ob_container ob_image
```

## Open container
```
docker exec -it ob_container /bin/bash
```