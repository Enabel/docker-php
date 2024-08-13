# docker-php

[![Docker Images build](https://github.com/Enabel/docker-php/actions/workflows/publish.yml/badge.svg)](https://github.com/Enabel/docker-php/actions/workflows/publish.yml)

Docker image based on the official php image (fpm-alpine) embedding some useful extensions (intl, mbstring, pdo, gd, ...) for Symfony projects.
Default image don't have any debug tools, but you can use the `xdebug` image to have xdebug or the `pcov` image to have pcov.

## Usage

### Docker compose

Exemple of a `docker-compose.yml` file using the `enabel/php:8.2` image:
```yaml
    php:
        image: enabel/php:8.2
        volumes:
          - ./:/usr/share/nginx/html
```

Example of a `docker-compose.yml` file using with pcov and php.ini customization:
```yaml
    php:
        image: enabel/php:8.2-pcov
        volumes:
          - ./:/usr/share/nginx/html
          - ./php.ini:/usr/local/etc/php/conf.d/custom.ini
```

## Contributing

Feel free to contribute, like sending [pull requests](https://github.com/enabel/docker-php/pulls) to add features/tests
or [creating issues](https://github.com/enabel/docker-php/issues)

## License

This project is open-sourced software licensed under the [GNU AGPLv3 License](LICENSE).

## About
Originally designed by [Damien Lagae][1]. If you have any questions, please contact [Damien Lagae][1].

[1]: damien.lagae@enabel.be
