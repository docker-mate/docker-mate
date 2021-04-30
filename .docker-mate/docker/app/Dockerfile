ARG container
ARG tag
FROM webdevops/${container}:${tag}

COPY app.sh /
RUN /bin/bash /app.sh

WORKDIR /var/www/html/
