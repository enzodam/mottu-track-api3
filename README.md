## Mottu Track · API

**Aplicação web (challenge JAVA ADVANCED) construída com Spring Boot, Thymeleaf, Flyway e Spring Security.**

Objetivo: simular a operação da Mottu com Filiais, Pátios, Vagas, Motos e Usuários — com autenticação (ADMIN/USER), CRUDs completos e páginas no padrão visual unificado.

## ✅ O que foi implementado (rubrica do desafio)

* Thymeleaf 

* Páginas para listar, criar, editar e excluir registros (CRUDs).

* Fragments (cabeçalho, menu, rodapé) para evitar repetição de código.

* Flyway

* Versionamento do banco em src/main/resources/db/migration.

- Quatro versões mínimas:

 - V1__create_tables.sql – criação de tabelas

 - V2__seed_data.sql – dados iniciais

 - V3__indexes_and_constraints.sql – índices e unicidades

 - V4__admin_and_user.sql – usuários padrão

* Spring Security

* Login (formulário) e logout.

* Perfis USER e ADMIN com proteção de rotas.

## 📦 Stack

* Java 21 • Spring Boot 3

* Spring MVC • Spring Data JPA • Spring Security

* Thymeleaf (com fragments)

* Flyway (migrations)

* PostgreSQL

## 🗂️ Estrutura (resumo)


src/main/java/...
  ├─ controller/      # Rotas MVC (/login, /home, /admin, /admin/*)
  
  ├─ model/           # Entidades JPA (Usuario, Filial, Patio, Vaga, Moto)
  
  ├─ repository/      # Spring Data JPA
  
  └─ security/        # Configuração Spring Security


src/main/resources/
  ├─ templates/       # Thymeleaf (layouts e páginas)
  
  │   ├─ fragments/   # header/menu/footer
  
  │   ├─ auth/        # login, register
  
  │   ├─ home-user.html
  
  │   └─ home-admin.html
  
  ├─ static/          # CSS/JS/Imagens
  
  └─ db/migration/    # Scripts Flyway (V1..V4)

## ▶️ Como executar (2 passos recomendados)

1. **Subir PostgreSQL via Docker (opção recomendada)**

* O repositório inclui um docker-compose.yml com Postgres 17 (DB: mottu, user: postgres, senha: postgres).

```bash
docker compose up -d
```

* Isso abre o banco em localhost:5432.

* Caso prefira um Postgres local próprio, veja a seção Variáveis de Ambiente abaixo.

2. **Subir a aplicação**

* Com Java 21+ instalado:

# usando o Maven Wrapper (preferível)
```bash
./mvnw spring-boot:run
```

# ou, se tiver Maven instalado
```bash
mvn spring-boot:run
```

* Acesse: [http://localhost:8081]

## 🔐 Acesso / Perfis

* Se o V4__admin_and_user.sql já estiver aplicado com usuários padrão, será possível entrar diretamente com os seeds (admin/user).

* Caso contrário (ou para testar do zero), acesse /register e crie um usuário.
- Para promovê-lo a ADMIN, execute no banco:
```bash
update usuario set perfil = 'ADMIN' where username = '<seu-username>';
```

- Observação: as senhas salvas via aplicação usam BCrypt (PasswordEncoder), conforme configuração de Security.

## ⚙️ Configuração (sem segredos no repositório)

* src/main/resources/application.properties usa variáveis de ambiente com defaults adequados ao docker-compose:

```bash
server.port=8081
spring.application.name=Mottu Track API

# Datasource (lê variáveis de ambiente; senão usa defaults do compose)
spring.datasource.url=${SPRING_DATASOURCE_URL:jdbc:postgresql://localhost:5432/mottu}
spring.datasource.username=${SPRING_DATASOURCE_USERNAME:postgres}
spring.datasource.password=${SPRING_DATASOURCE_PASSWORD:postgres}
spring.datasource.hikari.maximum-pool-size=5

# JPA / Flyway
spring.jpa.hibernate.ddl-auto=none
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
spring.flyway.baseline-on-migrate=true

# Thymeleaf
spring.thymeleaf.cache=false
server.error.whitelabel.enabled=false
```

**Variáveis de ambiente suportadas (opcional):**

* SPRING_DATASOURCE_URL • SPRING_DATASOURCE_USERNAME • SPRING_DATASOURCE_PASSWORD

## 🔀 Migrations (Flyway)

**As migrations são aplicadas automaticamente na inicialização:**


* V1__create_tables.sql – tabelas e FKs

* V2__seed_data.sql – dados iniciais

* V3__indexes_and_constraints.sql – índices/uniqueness

* V4__admin_and_user.sql – usuários padrão

Reiniciar (ambiente de dev):

```bash
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
```

Ao subir novamente, o Flyway reaplica V1..V4.

## 🌐 Rotas principais

-GET /login – login

-GET /register – cadastro

-POST /logout – sair

-GET /home – home do USER autenticado

-GET /admin – painel do ADMIN (protegido)


**CRUDs no painel ADMIN (exemplos):**

* Filiais (com UF obrigatório)

* Pátios (relacionados à Filial)

* Vagas (com código e disponibilidade)

* Motos (com cor e Filial)

* Usuários (ativo/perfil)

## 🧯 Troubleshooting rápido

**Porta 5432 ocupada (Postgres):**

* Pare instâncias existentes ou altere a porta no docker-compose.yml (ex.: "5433:5432").

**Erro de conexão (Hikari/Flyway):**

* Ajuste as variáveis SPRING_DATASOURCE_* ou garanta que o Postgres do compose está de pé (docker ps).

**Checksum mismatch (Flyway):**

* Em dev, limpe o schema (comandos acima).

* Em cenários reais, utilize flyway repair e crie novas versões (V5, V6…).

## Link do Deploy

[https://mottu-track-api4-1.onrender.com/login].

## 🎬 Vídeo Demonstrativo

[https://youtu.be/UbWzTS0KuZo]


## 👨‍💻 Desenvolvedores

| Nome                          | RM      | GitHub |
|-------------------------------|---------|--------|
| Enzo Dias Alfaia Mendes       | 558438  | [@enzodam](https://github.com/enzodam) |
| Matheus Henrique Germano Reis | 555861  | [@MatheusReis48](https://github.com/MatheusReis48) |
| Luan Dantas dos Santos        | 559004  | [@lds2125](https://github.com/lds2125) |
