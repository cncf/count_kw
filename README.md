# count_kw

Count given keywords in a given project, example call:

- `./count_kw.sh '/path/1 /path/2' '*.go *.c* *.md' '(argument1|argument2)'`.
- Example: `VERBOSE=1 ./count_kw.sh '/root/devstats_repos/cncf /root/devstats_repos/crosscloudci /root/devstats_repos/cdfoundation' '*' master`.

Count predefined 4 keywords counts in LF projects:

- `[SRC_BASE=/root/devstats_repos/] [RESET=1] [ONLY='TiKV,NATS,Flux,Rook,Thanos,etcd,OpenEBS,containerd,Linkerd,Vitess,CoreDNS,OPA,Harbor,KubeEdge'] ./run.sh`.
- Example: `ONLY=Prometheus ./run.sh`
- Example: `SRC_BASE=/root/sources ONLY='Hyperledger Labs,Hyperledger' ./run.sh`
- Example: `SRC_BASE=/root/sources FN=cf.csv RESET=1 ONLY=CloudFoundry ./run.sh`

To cone entire GitHub organization use:

- `SRC_BASE=/root/sources/ ./clone_org.sh hyperledger`.

