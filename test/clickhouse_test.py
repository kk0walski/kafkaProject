from clickhouse_driver import Client
client = Client(host='localhost')
print(client.execute('SHOW DATABASES'))
print(client.execute('SHOW TABLES'))
print(client.execute('SELECT * FROM filters', settings={'stream_like_engine_allow_direct_select': True}))