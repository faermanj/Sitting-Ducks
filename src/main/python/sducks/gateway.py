
def apigw(event, context):
    return APIGateway(event, context)


class APIGateway():
    def __init__(self, event, context):
        self.event = event
        self.context = context

    def ok(self, body):
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "text/plain"},
            "body": str(body)
        }

    def getInt(self, param=""):
        return int(self.event['queryStringParameters'][param])


from flask import Flask, Response, request


def flaskgw():
    return FlaskGateway()


class FlaskGateway:
    def ok(self, body):
        return Response(str(body), mimetype='text/plain', status=200)

    def getInt(self, param="", default=0):
        try:
            arg = request.args.get(param)
            return int(arg) if arg else default
        except ValueError:
            return default
