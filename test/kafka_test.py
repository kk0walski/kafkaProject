import uuid
import time
from time import sleep
from json import dumps
from dataclasses_json import dataclass_json
from kafka import KafkaProducer
from dataclasses import dataclass

@dataclass_json
@dataclass
class Filter:
    timestamp: float
    userId: int
    name: str
    value: str
    ccPath: str

producer = KafkaProducer(
    bootstrap_servers=['localhost:9092', '192.168.0.43:9092'],
    value_serializer=lambda x: dumps(x).encode('utf-8')
)
for j in range(9999):
    print("Iteration", j)
    message = Filter(time.time(), uuid.uuid4(), f"field#{j}", f"value#{j}", f"#{j}_controller")
    producer.send('filters', value=message.to_json())
    sleep(0.5)