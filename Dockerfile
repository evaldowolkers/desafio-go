######################################################
# Builder                                            #
######################################################

# Usando golang na versão 1.15 como imagem base
FROM golang:1.15 as builder

# Criando a pasta app e definindo como pasta de trabalho
RUN mkdir -p /app
WORKDIR /app

# copiando o app.go para a pasta de trabalho
COPY app.go .

# Construindo a aplicação Go para Linux
# 'scratch' é uma distribuição Linux
RUN GOOS=linux go build ./app.go

######################################################
# Definindo a imagem de execução                     #
######################################################

FROM scratch

# Definindo a pasta de trabalho
WORKDIR /app

# Copiando o binário da aplicação da imagem 'builder'
COPY --from=builder /app/app .

# Executando o binário da aplicação
CMD ["/app/app"]