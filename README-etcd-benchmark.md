# etcd-benchmark

docker build -t rubinus/etcd-benchmark:v1.0 .

确认etcd状态
etcdctl endpoint status --endpoints=10.10.14.127:2379,10.10.14.128:2379,10.10.14.129:2379 -w table

读取
benchmark --endpoints=10.10.14.127:2379,10.10.14.128:2379,10.10.14.129:2379  --conns=1 --clients=1  range foo --consistency=l --total=10000
benchmark --endpoints=10.10.14.127:2379,10.10.14.128:2379,10.10.14.129:2379  --conns=100 --clients=1000  range foo --consistency=l --total=100000

写入
benchmark --endpoints=10.10.14.127:2379,10.10.14.128:2379,10.10.14.129:2379 --target-leader --conns=1 --clients=1 put --key-size=8 --sequential-keys --total=10000 --val-size=256
benchmark --endpoints=10.10.14.127:2379,10.10.14.128:2379,10.10.14.129:2379  --target-leader --conns=100 --clients=1000 put --key-size=8 --sequential-keys --total=100000 --val-size=256

