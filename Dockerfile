FROM amazonlinux:latest

RUN mkdir -p /home/sducks
WORKDIR /home/sducks
COPY . /home/sducks

RUN amazon-linux-extras install python3
RUN pip3 install -r requirements.txt
RUN pwd
RUN find .
ENV FLASK_DEBUG 1
ENV FLASK_APP src/main/python/sducks/application.py
EXPOSE 5000
ENTRYPOINT ["flask","run","--host=0.0.0.0"]