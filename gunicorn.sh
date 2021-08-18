#!/bin/bash

echo "starting django server"

python3 manage.py migrate
python3 manage.py collectstatic --noinput

NAME="django-blog"                                  # Name of the application
NUM_WORKERS=1                                       # how many worker processes should Gunicorn spawn
DJANGO_WSGI_MODULE=config.wsgi              	      # WSGI module name

gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --bind 0.0.0.0:9090 \
  --log-level=debug \
  --log-file=-
