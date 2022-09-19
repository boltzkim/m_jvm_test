JAVA_HOME=/home/openmcm/SAPJVM/sapjvm_8


#setup JAVA_ARGS.
export MCM_HOME=/home/openmcm/wasagent_jdk8
export VM_ID=server2

MCM_OPTION=" -Xbootclasspath/p:${MCM_HOME}/lib/MCMAdapterRT_8_1_076.jar"
#MCM_OPTION=" -Xbootclasspath/p:${MCM_HOME}/lib/MCMAdapterRT_8_1_085.jar"
MCM_OPTION=${MCM_OPTION}" -javaagent:${MCM_HOME}/lib/MCMAdapterJavaagent.jar"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.mcmHome=${MCM_HOME}"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.vmId=${VM_ID}"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.domain=SAPJVM"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.properties=${MCM_HOME}/config/mcmAdapter_${VM_ID}.properties"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.sysCode=2"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.prodCode=21"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.dbSysCode=4"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.gcLogPath=/home/openmcm/Logs/gc"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.gcLogName=${VM_ID}_gc.log"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.bypassCachePath=${MCM_HOME}/cache"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.MSLLoaded=true"
MCM_OPTION=${MCM_OPTION}" -Dsun.boot.library.path=${JAVA_HOME}/jre/bin:${MCM_HOME}/lib"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.SYSInfoLoaded=true"
MCM_OPTION=${MCM_OPTION}" -Dcom.hp.mcm.adapter.MCMExec=SAP"


case $1 in
mcm)
JAVA_ARGS=${MCM_OPTION}
#삭제시 윈도우 실행 가능
export LD_PRELOAD=${MCM_HOME}/lib/libMcmMSL6twl.so
export MCM_CONFIG_FILE=${MCM_HOME}/config/mcmAdapter_${VM_ID}.properties
;;
*)
;;
esac

JAVA_ARGS=${JAVA_ARGS}" -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC "
JAVA_ARGS=${JAVA_ARGS}" -XX:+PrintGCDetails -XX:+DisableExplicitGC "
JAVA_ARGS=${JAVA_ARGS}" -Xloggc:/home/openmcm/Logs/gc/server2_gc.log "
JAVA_ARGS=${JAVA_ARGS}" -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:ParallelGCThreads=2  "
JAVA_ARGS=${JAVA_ARGS}" -XX:+CMSClassUnloadingEnabled -XX:CMSInitiatingOccupancyFraction=85 "
JAVA_ARGS=${JAVA_ARGS}" -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError "

#strace -s 4096 -X verbose -o java.strace.out -f ${JAVA_HOME}/bin/java ${JAVA_ARGS} -cp wasagent_jdk8/cpuloadgenerator.jar GenerateCPULoad 

${JAVA_HOME}/bin/java -version 

${JAVA_HOME}/bin/java ${JAVA_ARGS} -cp ./cpuloadgenerator.jar GenerateCPULoad 
