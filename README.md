# 🧠 Lista de Tarefas - Backend (Elixir + Phoenix)

Este projeto é uma API REST desenvolvida em **Elixir com o framework Phoenix**. Ele oferece endpoints para autenticação com JWT e gerenciamento de tarefas (CRUD).

---

## 🚀 Como rodar o projeto

### Pré-requisitos

- Elixir ~> 1.16.2
- Erlang/OTP ~> 26
- PostgreSQL

### Passos

1. Clone o repositório:

```bash
git clone https://github.com/ObayashiTech/backendcm.git
cd backendcm
```

2. Instale as dependências:

```bash
mix deps.get
```

3. Configure o banco de dados:

```bash
cp config/dev.exs.example config/dev.exs
# Edite o arquivo com suas credenciais

mix ecto.setup
```

4. Rode o servidor Phoenix:

```bash
mix phx.server
```

5. Acesse a API em:

```
http://localhost:4000/api
```

---

## 📁 Estrutura do projeto

```
lib/
├── backendcm/           # Domínio principal (Accounts, Tasks)
├── backendcm_web/       # Camada web (controllers, views, routers, plugs)
│   └── auth/            # Módulo JWT com Joken
├── repo.ex              # Integração com banco via Ecto
config/
└── dev.exs, prod.exs    # Configurações de ambiente
```

### Elixir + Phoenix

- Confiável, performático e altamente escalável para aplicações web.
- Ótimo suporte para APIs com JSON e autenticação.

### Autenticação com JWT

- Tokens JWT são gerados com [Joken](https://hexdocs.pm/joken).
- Middleware (`Plug`) de autenticação protege rotas.
- O token carrega o `user_id`, permitindo recuperação do usuário logado.

### Organização

- Por simplicidade, seguimos a organização clássica de contextos recomendada pelo Phoenix.
```
lib/
└── backendcm/
    ├── tasks/
    │   ├── task.ex       # Schema e funções específicas de uma tarefa
    └── tasks.ex      # Contexto principal com funções como list_tasks/0, create_task/1 etc.
```
---

## Endpoints principais

- `POST /api/auth/login` – Autenticação via email/senha
- `POST /api/auth/register` – Registro de novo usuário
- `GET /api/tasks` – Lista as tarefas do usuário autenticado
- `POST /api/tasks` – Cria nova tarefa
- `PATCH /api/tasks/:id` – Atualiza título ou status
- `DELETE /api/tasks/:id` – Remove uma tarefa

---
