# docker-php

[![Docker Images build](https://github.com/Enabel/docker-php/actions/workflows/publish.yml/badge.svg)](https://github.com/Enabel/docker-php/actions/workflows/publish.yml)

Docker image based on the official php image (fpm-alpine) embedding some useful extensions (intl, mbstring, pdo, gd, ...) for Symfony projects.
Default image don't have any debug tools, but you can use the `debug` image to have xdebug and pcov.
The 'cli' image is also available for running php scripts.

## Usage

### Working directory

The working directory is `/usr/share/nginx/html` for the `default` and `debug` images, and `/app` for the `cli` image.

### Docker compose

Exemple of a `docker-compose.yml` file using the `enabel/php:8.3` image:
```yaml
    php:
        image: enabel/php:8.3
        volumes:
          - ./:/usr/share/nginx/html
```

Example of a `docker-compose.yml` file using with pcov and php.ini customization:
```yaml
    php:
        image: enabel/php:8.3-debug
        volumes:
          - ./:/usr/share/nginx/html
          - ./php.ini:/usr/local/etc/php/conf.d/custom.ini
```

### Docker run

```bash
docker run --rm -v $(pwd):/app/ enabel/php:8.3-cli php /app/script.php
```

## Contributing

Feel free to contribute, like sending [pull requests](https://github.com/enabel/docker-php/pulls) to add features/tests
or [creating issues](https://github.com/enabel/docker-php/issues)

## License

This project is open-sourced software licensed under the [GNU AGPLv3 License](LICENSE).

## About
Originally designed by [Damien Lagae][1]. If you have any questions, please contact [Damien Lagae][1].

[1]: damien.lagae@enabel.be
