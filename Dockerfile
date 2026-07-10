# Usa uma imagem oficial leve do Node.js
FROM node:20-alpine 
# A imagem com -alpine fica mais leve

# Define a pasta de trabalho dentro do container
WORKDIR /app

# Copia o arquivo do servidor para dentro do container
COPY server.js .

# Informa que o container vai rodar na porta 3000
EXPOSE 3000

# Comando para iniciar o servidor quando o container ligar
CMD ["node", "server.js"]
