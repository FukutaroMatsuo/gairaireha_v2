FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
ENV RAILS_ROOT /app
WORKDIR $RAILS_ROOT
RUN mkdir log
COPY public public/
RUN rm -f /etc/nginx/conf.d/*
COPY /docker/web/nginx/nginx.conf /tmp/app.conf
EXPOSE 80
COPY docker/web/nginx/start.sh ./
RUN chmod 755 ./start.sh
CMD ["./start.sh"]