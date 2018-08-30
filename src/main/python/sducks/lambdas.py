import json
import pprint
from sducks.fibo import fib_gen, fib_iter, fib_rec, fib_memo
from sducks.gateway import apigw
pp = pprint.PrettyPrinter(indent=4)


def fibo_iter(event, context):
    gw = apigw(event, context)
    return fib_iter(gw)


def fibo_rec(event, context):
    gw = apigw(event, context)
    return fib_rec(gw)


def fibo_gen(event, context):
    gw = apigw(event, context)
    return fib_gen(gw)


def fibo_memo(event, context):
    gw = apigw(event, context)
    return fib_memo(gw)
