FROM amazonlinux:latest

RUN mkdir /home/sducks
WORKDIR /home/sducks
COPY . /home/sducks

RUN amazon-linux-extras install python3
RUN pip3 install -r requirements.txt
ENV FLASK_DEBUG 1
ENV FLASK_APP sducks/application.py
EXPOSE 5000
ENTRYPOINT ["flask","run","--host=0.0.0.0"]