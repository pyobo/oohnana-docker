#!/bin/bash

# Exit on first command that goes wrong
set -e

TMPIMAGENAME=obo_postgres4
IMAGENAME=oohnana
TAG="1.0.0"

docker image build -t $TMPIMAGENAME .
docker container run -e POSTGRES_PASSWORD=pyobo -p 5433:5432 -t -d --name $TMPIMAGENAME $TMPIMAGENAME

python -m pip install -q pyobo
python -m pyobo.database.sql.loader --uri postgresql+psycopg2://postgres:pyobo@localhost:5433/postgres

docker container commit $TMPIMAGENAME $IMAGENAME:TAG
docker container stop $TMPIMAGENAME

# VERIFY, run on a different port to be sure
# docker container run -p 5436:5432 --rm -it --name $IMAGENAME $IMAGENAME

docker login
docker tag $IMAGENAME:TAG cthoyt/$IMAGENAME:TAG
docker push cthoyt/$IMAGENAME:TAG
