#!flask/bin/python
import json
from flask import Flask, Response
from sducks.flaskrun import flaskrun

application = Flask(__name__)


@application.route('/static-text', methods=['GET'])
def get_static_text():
    return Response("hello world!", mimetype='text/plain', status=200)


@application.route('/static-more-text', methods=['GET'])
def get_static_more_text():
    return Response("hello world! Ipsum lorem", mimetype='text/plain', status=200)


@application.route('/', methods=['GET'])
def get():
    return Response(json.dumps({'Output': 'Hello World'}), mimetype='application/json', status=200)


@application.route('/', methods=['POST'])
def post():
    return Response(json.dumps({'Output': 'Hello World'}), mimetype='application/json', status=200)


if __name__ == '__main__':
    flaskrun(application)
