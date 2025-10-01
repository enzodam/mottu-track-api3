Mottu Track - Spring Boot Application
Aplicação web desenvolvida com Spring Boot, Thymeleaf, Flyway e Spring Security para simular a operação da Mottu com gestão de Filiais, Pátios, Vagas, Motos e Usuários.

📋 Descrição
Sistema completo com autenticação baseada em perfis (ADMIN/USER), CRUDs completos e interface web responsiva utilizando Thymeleaf.

✨ Funcionalidades
✅ Thymeleaf - Páginas HTML para listar/criar/editar/excluir registros

✅ Fragments - Cabeçalho, menu e rodapé reaproveitados

✅ Flyway - Versionamento de banco de dados com migrations

✅ Spring Security - Autenticação com form login e proteção de rotas

✅ CRUD Completo - Gestão de Filiais, Pátios, Vagas, Motos e Usuários

✅ Validações - Regras de negócio e validações básicas

🏗️ Arquitetura
text
src/
├── controller/     # Rotas (/login, /register, /home, /admin/*)
├── model/          # Entidades JPA (Usuario, Filial, Patio, Vaga, Moto)
├── repository/     # Spring Data JPA
├── security/       # Configuração Spring Security
└── templates/      # Thymeleaf (layouts e páginas)

resources/
├── db/migration/   # Scripts Flyway (V1..V4)
└── application.properties
🚀 Como Executar
Pré-requisitos
Java 21+

Maven (ou usar wrapper)

Docker (opcional - recomendado para Postgres)

1. Subir Banco de Dados (Docker)
bash
# Criar e executar container PostgreSQL
docker compose up -d
Configuração do Banco:

Host: localhost

Porta: 5432

Database: mottu

Usuário: postgres

Senha: postgres

2. Executar Aplicação
bash
# Usando Maven Wrapper
./mvnw spring-boot:run

# Ou com Maven instalado
mvn spring-boot:run
Acesse: http://localhost:8081

🔐 Autenticação
Usuários Padrão
Os seguintes usuários são criados automaticamente:

Perfil	Usuário	Senha
ADMIN	admin	admin
USER	user	user
Registrar Novo Usuário
Acesse /register para criar nova conta

Para promover para ADMIN, execute no banco:

sql
UPDATE usuario SET perfil = 'ADMIN' WHERE username = '<seu-usuario>';
📊 Migrations (Flyway)
Versão	Descrição
V1	Criação das tabelas (usuario, filial, patio, vaga, moto)
V2	Dados iniciais (filiais, pátios, vagas, motos)
V3	Índices e constraints (uniqueness)
V4	Usuários padrão (ADMIN/USER)
🔧 Configuração
application.properties (Desenvolvimento)
properties
server.port=8081
spring.application.name=Mottu Track API

# Datasource
spring.datasource.url=jdbc:postgresql://localhost:5432/mottu
spring.datasource.username=postgres
spring.datasource.password=postgres

# JPA / Flyway
spring.jpa.hibernate.ddl-auto=none
spring.jpa.show-sql=true
spring.flyway.enabled=true
Variáveis de Ambiente Suportadas
SPRING_DATASOURCE_URL

SPRING_DATASOURCE_USERNAME

SPRING_DATASOURCE_PASSWORD

🌐 Rotas Principais
Rota	Descrição	Acesso
/login	Tela de login	Público
/register	Cadastro de usuário	Público
/home	Home do usuário	USER
/admin	Painel administrativo	ADMIN
/logout	Logout	Autenticado
📦 Build
bash
# Gerar JAR
./mvnw -DskipTests clean package

# Executar JAR
java -Dserver.port=8081 -jar target/*.jar
🐛 Troubleshooting
Reset do Banco (Desenvolvimento)
sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
Porta Ocupada
Altere a porta no docker-compose.yml se 5432 estiver em uso

Erros de Conexão
Verifique se as variáveis de ambiente estão corretas

Confirme se o container PostgreSQL está executando

## 👨‍💻 Desenvolvedores

| Nome                          | RM      | GitHub |
|-------------------------------|---------|--------|
| Enzo Dias Alfaia Mendes       | 558438  | [@enzodam](https://github.com/enzodam) |
| Matheus Henrique Germano Reis | 555861  | [@MatheusReis48](https://github.com/MatheusReis48) |
| Luan Dantas dos Santos        | 559004  | [@lds2125](https://github.com/lds2125) |
