#!/bin/bash

# Exit on first command that goes wrong
set -e

HASH=$(git rev-parse HEAD)
TAG="${HASH:0:10}"
TMPIMAGENAME="oohnana_tmp_$TAG"
POSTGRES_PASSWORD=pyobo
PORT=5433

IMAGENAME=oohnana
TEST=""

# Testing environment
#IMAGENAME=oohnana-test
#TEST=" --test"

docker image build -t $TMPIMAGENAME .
docker container run -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -p $PORT:5432 -t -d --name $TMPIMAGENAME $TMPIMAGENAME

python3 -m venv env
source env/bin/activate
python -m pip install --upgrade pip
python -m pip install pyobo
python -m pyobo.database.sql.loader --uri postgresql+psycopg2://postgres:$POSTGRES_PASSWORD@localhost:$PORT/postgres $TEST

docker container commit $TMPIMAGENAME $IMAGENAME:$TAG
docker container stop $TMPIMAGENAME

# VERIFY, run on a different port to be sure
# docker container run -p 5436:5432 --rm -it --name $IMAGENAME $IMAGENAME

docker login
docker tag $IMAGENAME:$TAG pyobo/$IMAGENAME:$TAG
docker push pyobo/$IMAGENAME:$TAG
