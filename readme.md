# app 実行
uvicorn main:app --reload

http://localhost:8000


# Docker
docker login

## build
docker build . -t docker-fastapi:1

## exec
docker run -d -p 8000:8000 dockerk-fastapi:1

## stop
docker stop <<CONTAINER ID>>

