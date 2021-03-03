# Baixar a imagem do Golang Alpine (Versão mais leve).

FROM golang:1.12-alpine AS builder

# Definindo o diretório padrão a ser criado dentro da imagem.

WORKDIR /go/src/app

# Copiando nosso arquivo main.go para dentro do diretório.

COPY ./main.go .

# Buildando nossa aplicação go utilizando o main.go.

RUN go build -ldflags '-s -w' main.go

# Utilizando a imagem scratch para trabalhar com Multi Stage Builds
# De modo que iremos utilizar unicamente o código binário do Golang alpine
# para rodar a aplicação, isto reduz significativamente o tamanho da imagem.

FROM scratch

# Definindo um diretório chamado /app.

WORKDIR /app

# Copiando tudo que está dentro do Builder (Go) na pasta /go/src/app para o nosso diretório.

COPY --from=builder /go/src/app / 

# Executando o go

CMD ["/main"]