#!/bin/bash
# RESET=1 - reset output file
# VERBOSE=1 - pass verbose mode to count_kw.sh script
# SRC_BASE=/path/to/sources/folder (defaults to ~/devstats_repos)
# ONLY='Kubernetes,Prometheus' - specify subset of projects to run
# ONLY='Kubernetes,Linux kernel,Node.js,Helm,gRPC,Prometheus,Jenkins,Zephyr,Envoy,Fluentd,GraphQL,OpenTelemetry,Jenkins X,KubeVirt,Jaeger,Tekton,Spinnaker,TiKV,NATS,Flux,Rook,Thanos,etcd,OpenEBS,containerd,Linkerd,Vitess,CoreDNS,OPA,Harbor,KubeEdge,Falco,CRI-O,CloudEvents,Strimzi,Cortex,OCI,Network Service Mesh,CNI,Dragonfly,Buildpacks,CDF,OpenTracing,Virtual Kubelet,Spiffe,Spire,ChubaoFS,TUF,Telepresence,in-toto,Notary,rkt,OpenMetrics,CNCF,Knative,Istio,CloudFoundry,Hyperledger,Hyperledger Labs,Aries,Avalon,Besu,Burrow,Cactus,Caliper,Cello,Composer,Explorer,Fabric,Grid,Indy,Iroha,Quilt,Sawtooth,Transact,Ursa,Academy Software Foundation,OpenColor.io,OpenCue,OpenEXR,Open Shading Language,OpenTimeline.io,OpenVDB,DPDK,Dronecode,Stack Storm,Tars Cloud,Yocto,ACUMOS,Adlik,ANGEL,PaddlePaddle,EDL,Zowe,ForestFlow,Horovod,LF-AI,Ludwig,Marquez,Milvus,NNSTREAMER,ONNX,Pyro,Sparklyr,Akraino Edge,Baetyl,EdgeX Foundry,Fledge,Home Edge,Open Horizon,Project Eve,State of the Edge,LF Edge,OPX,CNTT,FD.io,OpenDaylight,ONAP,OPNFV,PNDA,TungstenFabric,O-RAN'
# FN=resultfile.csv (default: result.csv)
wd=`pwd`
if [ -z "${FN}" ]
then
  fn="${wd}/result.csv"
else
  fn="${wd}/${FN}"
fi
if [ ! -z "${RESET}" ]
then
  echo 'project,master,slave,whitelist,blacklist' > "${fn}"
fi
if [ -z "${SRC_BASE}" ]
then
  cd ~/devstats_repos/
else
  cd "${SRC_BASE}" || exit 1
fi
declare -A kws
kws[${#kws[@]}]='master'
kws[${#kws[@]}]='slave'
kws[${#kws[@]}]='white-?list'
kws[${#kws[@]}]='black-?list'
declare -A projs
projs[${#projs[@]}]='Kubernetes'
projs[${#projs[@]}]='Linux kernel'
projs[${#projs[@]}]='Node.js'
projs[${#projs[@]}]='Helm'
projs[${#projs[@]}]='gRPC'
projs[${#projs[@]}]='Prometheus'
projs[${#projs[@]}]='Jenkins'
projs[${#projs[@]}]='Zephyr'
projs[${#projs[@]}]='Envoy'
projs[${#projs[@]}]='Fluentd'
projs[${#projs[@]}]='GraphQL'
projs[${#projs[@]}]='OpenTelemetry'
projs[${#projs[@]}]='Jenkins X'
projs[${#projs[@]}]='KubeVirt'
projs[${#projs[@]}]='Jaeger'
projs[${#projs[@]}]='Tekton'
projs[${#projs[@]}]='Spinnaker'
projs[${#projs[@]}]='TiKV'
projs[${#projs[@]}]='NATS'
projs[${#projs[@]}]='Flux'
projs[${#projs[@]}]='Rook'
projs[${#projs[@]}]='Thanos'
projs[${#projs[@]}]='etcd'
projs[${#projs[@]}]='OpenEBS'
projs[${#projs[@]}]='containerd'
projs[${#projs[@]}]='Linkerd'
projs[${#projs[@]}]='Vitess'
projs[${#projs[@]}]='CoreDNS'
projs[${#projs[@]}]='OPA'
projs[${#projs[@]}]='Harbor'
projs[${#projs[@]}]='KubeEdge'
projs[${#projs[@]}]='Falco'
projs[${#projs[@]}]='CRI-O'
projs[${#projs[@]}]='CloudEvents'
projs[${#projs[@]}]='Strimzi'
projs[${#projs[@]}]='Cortex'
projs[${#projs[@]}]='OCI'
projs[${#projs[@]}]='Network Service Mesh'
projs[${#projs[@]}]='CNI'
projs[${#projs[@]}]='Dragonfly'
projs[${#projs[@]}]='Buildpacks'
projs[${#projs[@]}]='CDF'
projs[${#projs[@]}]='OpenTracing'
projs[${#projs[@]}]='Virtual Kubelet'
projs[${#projs[@]}]='Spiffe'
projs[${#projs[@]}]='Spire'
projs[${#projs[@]}]='ChubaoFS'
projs[${#projs[@]}]='TUF'
projs[${#projs[@]}]='Telepresence'
projs[${#projs[@]}]='in-toto'
projs[${#projs[@]}]='Notary'
projs[${#projs[@]}]='rkt'
projs[${#projs[@]}]='OpenMetrics'
projs[${#projs[@]}]='CNCF'
projs[${#projs[@]}]='Knative'
projs[${#projs[@]}]='Istio'
projs[${#projs[@]}]='CloudFoundry'
projs[${#projs[@]}]='Hyperledger'
projs[${#projs[@]}]='Hyperledger Labs'
projs[${#projs[@]}]='Aries'
projs[${#projs[@]}]='Avalon'
projs[${#projs[@]}]='Besu'
projs[${#projs[@]}]='Burrow'
projs[${#projs[@]}]='Cactus'
projs[${#projs[@]}]='Caliper'
projs[${#projs[@]}]='Cello'
projs[${#projs[@]}]='Composer'
projs[${#projs[@]}]='Explorer'
projs[${#projs[@]}]='Fabric'
projs[${#projs[@]}]='Grid'
projs[${#projs[@]}]='Indy'
projs[${#projs[@]}]='Iroha'
projs[${#projs[@]}]='Quilt'
projs[${#projs[@]}]='Sawtooth'
projs[${#projs[@]}]='Transact'
projs[${#projs[@]}]='Ursa'
projs[${#projs[@]}]='Academy Software Foundation'
projs[${#projs[@]}]='OpenColor.io'
projs[${#projs[@]}]='OpenCue'
projs[${#projs[@]}]='OpenEXR'
projs[${#projs[@]}]='Open Shading Language'
projs[${#projs[@]}]='OpenTimeline.io'
projs[${#projs[@]}]='OpenVDB'
projs[${#projs[@]}]='DPDK'
projs[${#projs[@]}]='Dronecode'
projs[${#projs[@]}]='Stack Storm'
projs[${#projs[@]}]='Tars Cloud'
projs[${#projs[@]}]='Yocto'
projs[${#projs[@]}]='ACUMOS'
projs[${#projs[@]}]='Adlik'
projs[${#projs[@]}]='ANGEL'
projs[${#projs[@]}]='PaddlePaddle'
projs[${#projs[@]}]='EDL'
projs[${#projs[@]}]='Zowe'
projs[${#projs[@]}]='ForestFlow'
projs[${#projs[@]}]='Horovod'
projs[${#projs[@]}]='LF-AI'
projs[${#projs[@]}]='Ludwig'
projs[${#projs[@]}]='Marquez'
projs[${#projs[@]}]='Milvus'
projs[${#projs[@]}]='NNSTREAMER'
projs[${#projs[@]}]='ONNX'
projs[${#projs[@]}]='Pyro'
projs[${#projs[@]}]='Sparklyr'
projs[${#projs[@]}]='Akraino Edge'
projs[${#projs[@]}]='Baetyl'
projs[${#projs[@]}]='EdgeX Foundry'
projs[${#projs[@]}]='Fledge'
projs[${#projs[@]}]='Home Edge'
projs[${#projs[@]}]='Open Horizon'
projs[${#projs[@]}]='Project Eve'
projs[${#projs[@]}]='State of the Edge'
projs[${#projs[@]}]='LF Edge'
projs[${#projs[@]}]='OPX'
projs[${#projs[@]}]='CNTT'
projs[${#projs[@]}]='FD.io'
projs[${#projs[@]}]='OpenDaylight'
projs[${#projs[@]}]='ONAP'
projs[${#projs[@]}]='OPNFV'
projs[${#projs[@]}]='PNDA'
projs[${#projs[@]}]='TungstenFabric'
projs[${#projs[@]}]='O-RAN'
declare -A sources
sources[${#sources[@]}]='kubernetes kubernetes-client kubernetes-csi kubernetes-incubator kubernetes-security kubernetes-sigs kubernetes-sig-testing'
sources[${#sources[@]}]='torvalds/linux'
sources[${#sources[@]}]='nodejs/node'
sources[${#sources[@]}]='helm'
sources[${#sources[@]}]='grpc'
sources[${#sources[@]}]='prometheus'
sources[${#sources[@]}]='jenkinsci jenkins-infra'
sources[${#sources[@]}]='zephyrproject-rtos'
sources[${#sources[@]}]='envoyproxy'
sources[${#sources[@]}]='fluent'
sources[${#sources[@]}]='graphql'
sources[${#sources[@]}]='open-telemetry'
sources[${#sources[@]}]='jenkins-x jenkins-x-apps jenkins-x-buildpacks jenkins-x-charts jenkins-x-quickstarts'
sources[${#sources[@]}]='kubevirt'
sources[${#sources[@]}]='jaegertracing'
sources[${#sources[@]}]='tektoncd'
sources[${#sources[@]}]='spinnaker'
sources[${#sources[@]}]='tikv'
sources[${#sources[@]}]='nats-io'
sources[${#sources[@]}]='fluxcd'
sources[${#sources[@]}]='rook'
sources[${#sources[@]}]='thanos-io'
sources[${#sources[@]}]='etcd-io'
sources[${#sources[@]}]='openebs'
sources[${#sources[@]}]='containerd'
sources[${#sources[@]}]='linkerd'
sources[${#sources[@]}]='vitessio'
sources[${#sources[@]}]='coredns'
sources[${#sources[@]}]='open-policy-agent'
sources[${#sources[@]}]='goharbor'
sources[${#sources[@]}]='kubeedge'
sources[${#sources[@]}]='falcosecurity'
sources[${#sources[@]}]='cri-o'
sources[${#sources[@]}]='cloudevents'
sources[${#sources[@]}]='strimzi'
sources[${#sources[@]}]='cortexproject'
sources[${#sources[@]}]='opencontainers'
sources[${#sources[@]}]='networkservicemesh'
sources[${#sources[@]}]='containernetworking'
sources[${#sources[@]}]='dragonflyoss'
sources[${#sources[@]}]='buildpacks'
sources[${#sources[@]}]='cdfoundation'
sources[${#sources[@]}]='opentracing'
sources[${#sources[@]}]='virtual-kubelet'
sources[${#sources[@]}]='spiffe'
sources[${#sources[@]}]='spiffe/spire'
sources[${#sources[@]}]='chubaofs'
sources[${#sources[@]}]='theupdateframework'
sources[${#sources[@]}]='telepresenceio'
sources[${#sources[@]}]='in-toto'
sources[${#sources[@]}]='theupdateframework/notary'
sources[${#sources[@]}]='rkt'
sources[${#sources[@]}]='OpenObservability'
sources[${#sources[@]}]='cncf crosscloudci cdfoundation'
sources[${#sources[@]}]='knative'
sources[${#sources[@]}]='istio'
sources[${#sources[@]}]='cloudfoundry cloudfoundry-incubator cloudfoundry-tutorials paketo-buildpacks'
sources[${#sources[@]}]='hyperledger'
sources[${#sources[@]}]='hyperledger-labs'
sources[${#sources[@]}]='hyperledger/aries hyperledger/aries-acapy-controllers hyperledger/aries-acapy-plugin-toolbox hyperledger/aries-cloudagent-python hyperledger/aries-framework-dotnet hyperledger/aries-framework-go hyperledger/aries-framework-javascript hyperledger/aries-mobileagent-xamarin hyperledger/aries-protocol-test-suite hyperledger/aries-rfcs hyperledger/aries-sdk-android hyperledger/aries-sdk-java hyperledger/aries-sdk-javascript hyperledger/aries-sdk-ruby hyperledger/aries-staticagent-python hyperledger/aries-toolbox'
sources[${#sources[@]}]='hyperledger/avalon'
sources[${#sources[@]}]='hyperledger/besu hyperledger/besu-docs hyperledger/besu-native hyperledger/besu-permissioning-smart-contracts hyperledger/homebrew-besu'
sources[${#sources[@]}]='hyperledger/burrow'
sources[${#sources[@]}]='hyperledger/cactus'
sources[${#sources[@]}]='hyperledger/caliper hyperledger/caliper'
sources[${#sources[@]}]='hyperledger/cello hyperledger/cello-analytics'
sources[${#sources[@]}]='hyperledger/composer'
sources[${#sources[@]}]='hyperledger/blockchain-explorer'
sources[${#sources[@]}]='hyperledger/fabric hyperledger/fabric-amcl hyperledger/fabric-baseimage hyperledger/fabric-ca hyperledger/fabric-chaincode-evm hyperledger/fabric-chaincode-go hyperledger/fabric-chaincode-java hyperledger/fabric-chaincode-node hyperledger/fabric-chaintool hyperledger/fabric-cli hyperledger/fabric-config hyperledger/fabric-contract-api-go hyperledger/fabric-docs-i18n hyperledger/fabric-gateway-java hyperledger/fabric-lib-go hyperledger/fabric-protos-go hyperledger/fabric-protos hyperledger/fabric-rfcs hyperledger/fabric-samples hyperledger/fabric-sdk-go hyperledger/fabric-sdk-java hyperledger/fabric-sdk-node hyperledger/fabric-sdk-py hyperledger/fabric-test'
sources[${#sources[@]}]='hyperledger/grid hyperledger/grid-contrib hyperledger/grid-rfcs hyperledger/grid-website'
sources[${#sources[@]}]='hyperledger/indy-docs hyperledger/indy-hipe hyperledger/indy-node hyperledger/indy-plenum hyperledger/indy-sdk hyperledger/indy-test-automation hyperledger/indy-vdr'
sources[${#sources[@]}]='hyperledger/iroha hyperledger/iroha-android hyperledger/iroha-deploy hyperledger/iroha-ed25519 hyperledger/iroha-ios hyperledger/iroha-java hyperledger/iroha-javascript hyperledger/iroha-python hyperledger/iroha-state-migration-tool hyperledger/iroha-tui-client'
sources[${#sources[@]}]='hyperledger/quilt'
sources[${#sources[@]}]='hyperledger/education-sawtooth-simple-supply hyperledger/sawtooth-ansible hyperledger/sawtooth-contrib hyperledger/sawtooth-core hyperledger/sawtooth-devmode hyperledger/sawtooth-explorer hyperledger/sawtooth-marketplace hyperledger/sawtooth-pbft hyperledger/sawtooth-poet hyperledger/sawtooth-raft hyperledger/sawtooth-rfcs hyperledger/sawtooth-sabre hyperledger/sawtooth-sdk-cxx hyperledger/sawtooth-sdk-dotnet hyperledger/sawtooth-sdk-go hyperledger/sawtooth-sdk-java hyperledger/sawtooth-sdk-javascript hyperledger/sawtooth-sdk-python hyperledger/sawtooth-sdk-rust hyperledger/sawtooth-sdk-swift hyperledger/sawtooth-seth hyperledger/sawtooth-supply-chain hyperledger/sawtooth-website'
sources[${#sources[@]}]='hyperledger/transact hyperledger/transact-rfcs hyperledger/transact-contrib hyperledger/transact-sdk-javascript hyperledger/transact-sdk-go'
sources[${#sources[@]}]='hyperledger/ursa hyperledger/ursa-docs hyperledger/ursa-python hyperledger/ursa-rfcs'
sources[${#sources[@]}]='AcademySoftwareFoundation'
sources[${#sources[@]}]='AcademySoftwareFoundation/OpenColorIO'
sources[${#sources[@]}]='AcademySoftwareFoundation/OpenCue AcademySoftwareFoundation/opencue.io'
sources[${#sources[@]}]='AcademySoftwareFoundation/openexr AcademySoftwareFoundation/openexr-images'
sources[${#sources[@]}]='imageworks/OpenShadingLanguage'
sources[${#sources[@]}]='PixarAnimationStudios/OpenTimelineIO'
sources[${#sources[@]}]='AcademySoftwareFoundation/openvdb AcademySoftwareFoundation/openvdb-website'
sources[${#sources[@]}]='dpdk'
sources[${#sources[@]}]='dronecode'
sources[${#sources[@]}]='StackStorm'
sources[${#sources[@]}]='TarsCloud'
sources[${#sources[@]}]='yocto'
sources[${#sources[@]}]='acumos'
sources[${#sources[@]}]='Adlik'
sources[${#sources[@]}]='Angel-ML/angel Angel-ML/PyTorch-On-Angel Angel-ML/sona Angel-ML/automl Angel-ML/serving Angel-ML/mlcore Angel-ML/PyAngelPS'
sources[${#sources[@]}]='PaddlePaddle'
sources[${#sources[@]}]='PaddlePaddle/edl'
sources[${#sources[@]}]='zowe'
sources[${#sources[@]}]='ForestFlow'
sources[${#sources[@]}]='horovod'
sources[${#sources[@]}]='lfai'
sources[${#sources[@]}]='uber/ludwig'
sources[${#sources[@]}]='MarquezProject'
sources[${#sources[@]}]='milvus-io'
sources[${#sources[@]}]='nnstreamer'
sources[${#sources[@]}]='onnx'
sources[${#sources[@]}]='pyro-ppl'
sources[${#sources[@]}]='sparklyr'
sources[${#sources[@]}]='akraino-edge-stack'
sources[${#sources[@]}]='baetyl'
sources[${#sources[@]}]='edgexfoundry'
sources[${#sources[@]}]='fledge-iot'
sources[${#sources[@]}]='lf-edge/edge-home-orchestration-go'
sources[${#sources[@]}]='open-horizon'
sources[${#sources[@]}]='lf-edge/eve lf-edge/runx lf-edge/edge-containers lf-edge/adam lf-edge/eden'
sources[${#sources[@]}]='state-of-the-edge'
sources[${#sources[@]}]='lf-edge'
sources[${#sources[@]}]='open-switch/opx-tools open-switch/opx-pas open-switch/opx-sdi-sys open-switch/opx-platform-config open-switch/opx-nas-daemon open-switch/opx-nas-qos open-switch/opx-nas-l3 open-switch/opx-nas-l2 open-switch/opx-nas-multicast open-switch/opx-nas-interface open-switch/opx-nas-acl open-switch/opx-nas-sdi open-switch/opx-nas-sdi-api open-switch/opx-nas-linux open-switch/opx-nas-common open-switch/opx-sai-vm open-switch/opx-sai-api open-switch/opx-base-model open-switch/opx-cps open-switch/opx-common-utils open-switch/opx-onie-installer open-switch/opx-build open-switch/opx-test open-switch/opx-core open-switch/continuous-integration open-switch/opx-logging open-switch/ansible-role-opx-vlan open-switch/opx-docs open-switch/rootfs'
sources[${#sources[@]}]='cntt-n'
sources[${#sources[@]}]='fdio'
sources[${#sources[@]}]='odl'
sources[${#sources[@]}]='onap'
sources[${#sources[@]}]='opnfv'
sources[${#sources[@]}]='pndaproject'
sources[${#sources[@]}]='tungstenfabric'
sources[${#sources[@]}]='oran'
skip_project() {
  if [ -z "${ONLY}" ]
  then
    return 1
  fi
  OIFS=$IFS
  IFS=','
  for only in $ONLY
  do
    if [ "${1}" = "${only}" ]
    then
      IFS=$OIFS
      return 1
    fi
  done
  IFS=$OIFS
  return 0
}
# echo "Projects: ${projs[@]}"
# echo "Sources: ${sources[@]}"
# echo "Keywords: ${kws[@]}"
for i in "${!projs[@]}"
do
  proj="${projs[$i]}"
  if skip_project "${proj}"
  then
    # echo "Skipped ${proj}"
    continue
  fi
  src="${sources[$i]}"
  echo -n "${proj}," >> "${fn}"
  for j in "${!kws[@]}"
  do
    kw="${kws[$j]}"
    echo -n "`date +%T.%N` ${proj}(${src}) ${kw}: "
    res=`"${wd}/count_kw.sh" "${src}" '*' "${kw}"`
    echo "${res}"
    echo -n "${res}" >> "${fn}"
    if [ ! "${j}" = "3" ]
    then
      echo -n ',' >> "${fn}"
    fi
  done
  echo '' >> "${fn}"
done
