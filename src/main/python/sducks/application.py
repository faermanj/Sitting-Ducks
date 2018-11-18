#!flask/bin/python
import json
from flask import Flask, Response, request
from sducks.flaskrun import flaskrun
from sducks.fibo import fib_gen, fib_iter, fib_rec, fib_memo
from sducks.gateway import flaskgw

application = Flask(__name__, static_url_path='/static')
version = "2018-08-26T164315"
gw = flaskgw()


@application.route('/version', methods=['GET'])
def get_version():
    return gw.ok(version)


@application.route('/static-text', methods=['GET'])
def get_static_text():
    return gw.ok("Hello World!")


@application.route('/fib_rec', methods=['GET'])
def get_fib_rec():

    return fib_rec(gw)


@application.route('/fib_iter', methods=['GET'])
def get_fib_iter():
    return fib_iter(gw)


@application.route('/fib_gen', methods=['GET'])
def get_fib_gen():
    return fib_gen(gw)


@application.route('/fib_memo', methods=['GET'])
def get_fib_memo():
    return fib_memo(gw)


@application.route('/', methods=['GET'])
def get():
    return get_static_text()


if __name__ == '__main__':
    flaskrun(application)
