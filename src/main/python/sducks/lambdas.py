import json
import pprint
import random
import boto3
import os
from sducks.fibo import fib_gen, fib_iter, fib_rec, fib_memo
from sducks.gateway import apigw
import mysql.connector

max = 999999999
pp = pprint.PrettyPrinter(indent=4)
dynamodb = boto3.resource('dynamodb')


def hello(event, context):
    gw = apigw(event, context)
    return gw.ok("Hello World!")


def put_rand_rdb(event, context):
    gw = apigw(event, context)
    rand = random.randint(0, max)
    db_host = os.environ['DB_HOST']
    conn = mysql.connector.connect(
        host=db_host,
        user="root",
        passwd="Masterkey123")
    print(conn)
    cursor = conn.cursor()
    cursor.execute("create database if not exists sducks")
    cursor.execute(
        "create table if not exists sducks.rands(rand integer primary key)")
    sql = "insert into sducks.rands(rand) values (%(rand)s)"
    params = {
        'rand': rand
    }
    cursor.execute(sql, params)
    conn.commit()
    cursor.close()
    conn.close()
    return gw.ok("Inserted "+str(rand)+" to endpoint "+db_host)


def put_rand_ddb(event, context):
    gw = apigw(event, context)
    rand_table_name = os.environ['RAND_TABLE_NAME']
    rand = random.randint(0, max)
    table = dynamodb.Table(rand_table_name)
    item = {
        'rand': rand
    }
    table.put_item(Item=item)
    return gw.ok("random number "+str(rand)+" put to table "+rand_table_name)


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
