# 🚀 Projeto Hello World com CI/CD e Docker

Este é um projeto prático projetado para aprender e validar os fundamentos de **Automação, Integração Contínua (CI)** com o **GitHub Actions** e empacotamento com **Docker**.

## 🛠️ Tecnologias Utilizadas

*   **Node.js**: Linguagem base para o servidor web simplificado.
*   **Docker**: Criação e isolamento do ambiente da aplicação em um container.
*   **GitHub Actions**: Automatização de testes de sintaxe e validação do build do Docker.


---

## 📁 Estrutura do Projeto

```text
ci-cd/
├── .github/
│   └── workflows/
│       └── ci.yml          # Configuração da pipeline do GitHub Actions
├── Dockerfile              # Instruções de empacotamento da aplicação
├── README.md               # Documentação do projeto
└── server.js               # Código fonte do servidor HTTP (Hello World)
```

---

## 🚀 Como Executar o Projeto Localmente

### Pré-requisitos
Antes de começar, você precisa ter instalado na sua máquina:
*   [Node.js](https://nodejs.org) (versão 20 ou superior)
*   [Docker Desktop](https://docker.com) (rodando em segundo plano)

### 1. Testando o Servidor Node.js diretamente
Abra o terminal na raiz do projeto e execute:
```bash
node server.js
```
Acesse no seu navegador: `http://localhost:3000`

### 2. Construindo a Imagem Docker
Para simular o processo de build do container localmente:
```bash
docker build -t meu-app-hello-world:latest .
```

### 3. Rodando o Container Docker
Para iniciar a aplicação isolada dentro do container:
```bash
docker run -p 3000:3000 meu-app-hello-world:latest
```
Acesse novamente `http://localhost:3000` para garantir que o container está respondendo.

---

## 🤖 Integração Contínua (GitHub Actions)

A pipeline configurada no arquivo `.github/workflows/ci.yml` é disparada automaticamente a cada `push` ou `pull_request` na branch `main`.

### Etapas da Pipeline:
1.  **Baixar o código**: Utiliza a action padrão `actions/checkout@v4`.
2.  **Validar script Node.js**: Executa um teste rápido de compilação/sintaxe no arquivo `server.js`.
3.  **Validar Build do Dockerfile**: Executa o comando `docker build` nos servidores do GitHub para garantir que as instruções do container não possuem erros.
