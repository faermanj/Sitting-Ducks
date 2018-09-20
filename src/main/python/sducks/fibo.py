
def fib_iter(gw):
    x = gw.getInt('x')
    y = fib_iterative(x)
    return gw.ok(y)


def fib_iterative(x):
    a, b = 1, 1
    for i in range(x-1):
        a, b = b, a+b
    return a


def fib_rec(gw):
    x = gw.getInt('x')
    y = fib_recursive(x)
    return gw.ok(y)


def fib_recursive(x):
    if x > 1:
        return fib_recursive(x-1) + fib_recursive(x-2)
    return x


def fib_gen(gw):
    x = gw.getInt('x')
    fib = fib_generator()
    for i in range(x-1):
        next(fib)
    body = next(fib)
    return gw.ok(body)


def fib_memo(gw):
    x = gw.getInt('x')
    y = fib_memoized(x)
    return gw.ok(y)


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


def fib_memoized(x):
    return memoize(fib_iterative, x)
