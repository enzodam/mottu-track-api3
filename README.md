Mottu Track • Spring Boot + Thymeleaf + Flyway + Security

Aplicação web (challenge JAVA ADVANCED) com Spring Boot, Thymeleaf, Flyway e Spring Security.

Propósito: simular a operação da Mottu com Filiais, Pátios, Vagas, Motos e Usuários — com autenticação (ADMIN/USER), CRUDs e páginas padrão.

✅ Requisitos atendidos

Thymeleaf (30 pts)

Páginas HTML para listar / criar / editar / excluir registros.

Fragments (cabeçalho, menu, rodapé) reaproveitados no layout.

Flyway (20 pts)

Versionamento em db/migration com quatro migrations:

V1__create_tables.sql — cria tabelas

V2__seed_data.sql — dados iniciais

V3__indexes_and_constraints.sql — índices/uniqueness

V4__admin_and_user.sql — usuários padrão (seeds)

Spring Security (30 pts)

Form login e logout.

Perfis ADMIN e USER, com proteção de rotas.

Funcionalidades completas (20 pts)

Fluxos CRUD completos (ex.: Filiais e Motos).

Validações básicas (ex.: UF obrigatório para Filial).

🏗️ Arquitetura (resumo)

controller/ — rotas /login, /register, /home, /admin, /admin/*

model/ — entidades JPA: Usuario, Filial, Patio, Vaga, Moto

repository/ — Spring Data JPA

security/ — configuração do Spring Security (form login, perfis e regras)

templates/ — Thymeleaf (layouts e páginas)

db/migration/ — scripts Flyway (V1..V4)

🧰 Pré-requisitos

Java 21+

Maven (ou usar o wrapper ./mvnw)

Docker (opcional, recomendado para subir Postgres rapidamente)

▶️ Como rodar (2 passos recomendados para avaliação)
1) Subir o Postgres via Docker

Crie (ou mantenha) na raiz o arquivo docker-compose.yml:

version: '3.8'
services:
  db:
    image: postgres:17
    container_name: mottu-db
    environment:
      POSTGRES_DB: mottu
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:


Suba o banco:

docker compose up -d


Host: localhost • Porta: 5432 • DB: mottu • User: postgres • Pass: postgres

2) Rodar a aplicação
# com wrapper
./mvnw spring-boot:run

# ou com Maven instalado
mvn spring-boot:run


Acesse: http://localhost:8081

🔐 Logins / Perfis

As senhas dos usuários seed foram criadas no V4__admin_and_user.sql (BCrypt).
Se preferir criar seu usuário via UI: use /register e depois promova no banco:

update usuario set perfil = 'ADMIN' where username = '<seu-username>';


Dica: se quiser “zerar” o banco em DEV, rode:

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;


Ao subir de novo, o Flyway reaplica V1..V4.

⚙️ Configuração (sem segredos no repo)

src/main/resources/application.properties (dev/local):

server.port=8081
spring.application.name=Mottu Track API

# Datasource (usa env vars se existirem; senão, defaults do Docker)
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


Variáveis de ambiente suportadas:
SPRING_DATASOURCE_URL • SPRING_DATASOURCE_USERNAME • SPRING_DATASOURCE_PASSWORD

🌐 Rotas principais

GET /login — tela de login

GET /register — cadastro de usuário

POST /logout — sair

GET /home — home do USER

GET /admin — painel do ADMIN (protegido)

CRUDs (exemplos no painel ADMIN):

Filiais — criar/editar/excluir, com UF obrigatório

Pátios, Vagas (com código), Motos (com cor), Usuários (perfil/ativo)

🗂️ Migrations (Flyway)

src/main/resources/db/migration/

V1__create_tables.sql — criação de usuario, filial, patio, vaga, moto (FKs/defaults)

V2__seed_data.sql — dados iniciais (filiais, pátios, vagas, motos)

V3__indexes_and_constraints.sql — índices de FKs e uniqueness (placa, código, username, email)

V4__admin_and_user.sql — insere usuários padrão (ADMIN/USER)

🔒 Security (Spring Security)

Form login (/login) e logout (POST /logout)

Perfis: ADMIN e USER

Acesso: /admin/** → ADMIN • /home → autenticado

Recursos estáticos liberados (/css/**, /js/**, /images/**)

📦 Build standalone (JAR)
# gerar JAR
./mvnw -DskipTests clean package

# rodar JAR
java -Dserver.port=8081 -jar target/*.jar

🧯 Troubleshooting

Flyway checksum mismatch: em DEV, limpe o schema (comandos acima) e rode de novo.

Porta 5432 ocupada: pare outro Postgres local ou mude a porta no docker-compose.yml.

Erro de conexão: exporte as variáveis SPRING_DATASOURCE_* ou ajuste para o seu Postgres.

🎬 Vídeo Demonstrativo

[................................]

## 👨‍💻 Desenvolvedores

| Nome                          | RM      | GitHub |
|-------------------------------|---------|--------|
| Enzo Dias Alfaia Mendes       | 558438  | [@enzodam](https://github.com/enzodam) |
| Matheus Henrique Germano Reis | 555861  | [@MatheusReis48](https://github.com/MatheusReis48) |
| Luan Dantas dos Santos        | 559004  | [@lds2125](https://github.com/lds2125) |

