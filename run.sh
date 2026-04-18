#!/bin/bash


export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export JAVA_HOME="/root/.sdkman/candidates/java/17.0.10-tem"
export JRE_HOME="$JAVA_HOME"
export PATH=$JAVA_HOME/bin:$PATH

# arquivos workload
PYTHON_JMX="/home/jadson/Downloads/TestsAging/py/test_js.jmx"

JS_JMX="/home/jadson/Downloads/TestsAging/js/test_python.jmx"


# Caminhodo Jemter
JMETER_BIN="/home/jadson/Downloads/TestsAging/js/apache-jmeter-5.6.3/bin/jmeter.sh"


stop_workload() {
    echo -e "\n[!] Interrupção detectada. Encerrando workloads..."
   
    kill $PYTHON_PID 2>/dev/null
    
    kill $JS_PID 2>/dev/null

    
    echo "[+] Testes parados com sucesso."
    exit 0
}


trap stop_workload SIGINT

echo "Iniciando Python "
$JMETER_BIN -n -t "$PYTHON_JMX" -l /dev/null > /dev/null 2>&1 &
PYTHON_PID=$!


echo "Iniciando js"
$JMETER_BIN -n -t "$JS_JMX" -l /dev/null > /dev/null 2>&1 &
JS_PID=$!


echo "----------------------------------------------------"
echo "PID Python: $PYTHON_PID | PID JS: $JS_PID"
echo "Crtl+c pra parar"
echo "----------------------------------------------------"


wait
