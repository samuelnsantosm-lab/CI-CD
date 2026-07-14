# =========================================================================
# ESTÁGIO 1: Construção, instalação de dependências e execução de testes
# =========================================================================

# Define a imagem base leve do Node.js (Alpine Linux) e dá o nome de "builder" a este estágio
FROM node:20-alpine AS builder

# Cria e define o diretório de trabalho onde o código do app ficará dentro do container
WORKDIR /usr/src/app

# Copia os arquivos de manifesto de dependências (package.json e package-lock.json) para o diretório atual
COPY package*.json ./

# Instala todas as dependências (inclusive as de desenvolvimento) de forma limpa e determinística para o CI
RUN npm ci

# Copia todo o restante dos arquivos do projeto do seu computador para dentro do container
COPY . .

# Comando opcional para rodar os testes automatizados durante o processo de build da imagem
# RUN npm test

# =========================================================================
# ESTÁGIO 2: Imagem final de produção (focada em tamanho reduzido e segurança)
# =========================================================================

# Inicia um novo estágio limpo usando a mesma imagem leve do Node.js 20 Alpine
FROM node:20-alpine

# Define o diretório de trabalho isolado para a aplicação que vai rodar em produção
WORKDIR /usr/src/app

# Copia novamente os manifestos de dependências para este novo estágio limpo
COPY package*.json ./

# Instala estritamente as dependências necessárias para a execução, ignorando as de desenvolvimento
RUN npm ci --only=production

# Copia apenas o arquivo do servidor gerado no estágio "builder", deixando arquivos desnecessários para trás
COPY --from=builder /usr/src/app/server.js .

# Altera o usuário do container para "node" (padrão não-root do Alpine) para evitar privilégios de administrador
USER node

# Informa ao Docker que o container vai escutar a porta 3000 em tempo de execução
EXPOSE 3000

# Define o comando padrão que será executado assim que o container for iniciado
CMD ["node", "server.js"]
