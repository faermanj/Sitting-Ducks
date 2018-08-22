#!flask/bin/python
import json
from flask import Flask, Response, request
from sducks.flaskrun import flaskrun

application = Flask(__name__)


@application.route('/static-text', methods=['GET'])
def get_static_text():
    return Response("hello world!", mimetype='text/plain', status=200)


def rec_fib(n):
    '''inefficient recursive function as defined, returns Fibonacci number'''
    if n > 1:
        return rec_fib(n-1) + rec_fib(n-2)
    return n


@application.route('/fibo', methods=['GET'])
def fibo():
    x = int(request.args.get('x'))
    if x:
        resp = "fibo("+str(x)+") = "+str(rec_fib(x))
    else:
        resp = "fibo(x)"
    return Response(resp, mimetype='text/plain', status=200)


@application.route('/', methods=['GET'])
def get():
    return Response(json.dumps({'Output': 'Hello World'}), mimetype='application/json', status=200)


@application.route('/', methods=['POST'])
def post():
    return Response(json.dumps({'Output': 'Hello World'}), mimetype='application/json', status=200)


if __name__ == '__main__':
    flaskrun(application)
