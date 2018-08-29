import json
import pprint
from sducks.fibo import fib_gen, fib_iter, fib_rec, fib_memo
from sducks.gateway import apigw
pp = pprint.PrettyPrinter(indent=4)


def fibo_iter(event, context):
    gw = apigw(event, context)
    return fib_iter(gw)
