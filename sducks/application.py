#!flask/bin/python
import json
from flask import Flask, Response, request
from sducks.flaskrun import flaskrun

application = Flask(__name__, static_url_path='/static')


@application.route('/static-text', methods=['GET'])
def get_static_text():
    return Response("hello world!", mimetype='text/plain', status=200)


def fib_iter(n):
    a, b = 1, 1
    for i in range(n-1):
        a, b = b, a+b
    return a


def fib_rec(n):
    if n > 1:
        return fib_rec(n-1) + fib_rec(n-2)
    return n


def fib_gen():
    a, b = 0, 1
    while True:
        a, b = b, a+b
        yield a


def memoize(fn, arg):
    memo = {}
    if arg not in memo:
        memo[arg] = fn(arg)
        return memo[arg]


def ok(data):
    return Response(str(data), mimetype='text/plain', status=200)


def intArg(name, default=0):
    try:
        arg = request.args.get(name)
        return int(arg) if arg else default
    except ValueError:
        return default


@application.route('/fib_rec', methods=['GET'])
def get_fib_rec():
    x = intArg('x')
    body = fib_rec(x)
    return ok(body)


@application.route('/fib_iter', methods=['GET'])
def get_fib_iter():
    x = intArg('x')
    body = fib_iter(x)
    return ok(body)


@application.route('/fib_gen', methods=['GET'])
def get_fib_gen():
    x = intArg('x')
    fib = fib_gen()
    for i in range(x-1):
        next(fib)
    body = next(fib)
    return ok(body)


@application.route('/fib_memo', methods=['GET'])
def get_fib_memo():
    x = intArg('x')
    body = memoize(fib_iter, x)
    return ok(body)


@application.route('/', methods=['GET'])
def get():
    return Response(json.dumps({'Output': 'Hello World'}), mimetype='application/json', status=200)


@application.route('/', methods=['POST'])
def post():
    return Response(json.dumps({'Output': 'Hello World'}), mimetype='application/json', status=200)


if __name__ == '__main__':
    flaskrun(application)
