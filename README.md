# Rinha de Backend - Elixir Edition

Essa é a implementação da [Rinha de Backend 2023 Q3](https://github.com/zanfranceschi/rinha-de-backend-2023-q3) usando:

- [x] Elixir (Com [Phoenix Framework](https://www.phoenixframework.org/))
- [x] Postgres

## Desenvolvimento

Para desenvolver nesse projeto, você precisa ter instalado:

- [x] [Elixir 1.15.4](https://elixir-lang.org/)
- [x] [Erlang 26](https://www.erlang.org/)
- [x] [Docker](https://www.docker.com/products/docker-desktop/)

A forma mais simples de instalar Elixir e Erlang é usando o [asdf](https://asdf-vm.com/). Esse projeto
usa arquivo `.tools-version` para configurar as versões corretas. Com o asdf instalado, execute:

```shell
asdf install
```

> Erlang e Elixir serão instalados automaticamente.

Agora com o Docker instalado, de o start no Postgres com o comando:

```shell
docker-compose -f docker-compose.dev.yml up -d
```

Inicie seu servidor Phoenix com os seguintes comandos:

1. Rode `mix setup` para instalar as dependências
1. Agora de o start no servidor com `mix phx.server`

Agora vá para [`localhost:4000`](http://localhost:4000) no seu browser.
