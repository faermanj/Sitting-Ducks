def fib_iter(gw):
    n = gw.getInt('x')
    a, b = 1, 1
    for i in range(n-1):
        a, b = b, a+b
    return gw.ok(a)


def fib_rec(gw):
    n = gw.getInt('x')
    if n > 1:
        return fib_rec(n-1) + fib_rec(n-2)
    return gw.ok(n)


def fib_gen(gw):
    x = gw.getInt('x')
    fib = fib_generator()
    for i in range(x-1):
        next(fib)
    body = next(fib)
    return gw.ok(body)


def fib_generator():
    a, b = 0, 1
    while True:
        a, b = b, a+b
        yield a


def memoize(fn, arg):
    memo = {}
    if arg not in memo:
        memo[arg] = fn(arg)
        return memo[arg]


def fib_memo(gw):
    return memoize(fib_iter, gw)
