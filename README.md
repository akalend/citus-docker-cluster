# Проект citus-docker-cluster

Создание среды  для отладки кластера citus

Dockerfile.postgres - образ для postgres.
На его основе строится образ для citus: Dockerfile.citus.
Dockerfile.citus_s - файлы для slave образа.
В директории citus должны быть исходники citus.

Файл cmd - набор разных часто используемых команд.

init_docker.sh - скрипт создания кластера для двух рабочих узлов, координатора и их реплик.
