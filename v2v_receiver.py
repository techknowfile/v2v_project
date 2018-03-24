import pika

credentials = pika.PlainCredentials('yochan', 'yochan')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost', credentials=credentials))
channel = connection.channel()

channel.queue_declare(queue='v2v')

def callback(ch, method, properties, body):
    print(" [x] received %r" % body)

channel.basic_consume(callback, queue='v2v', no_ack=True)

print(' [*] Listening for vehicle messages. To exit, press CTRL-C')
channel.start_consuming()
