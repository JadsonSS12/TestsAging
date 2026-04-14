#!/bin/bash

# Caminhos onde estao os workloads
PYTHON_JMX="/home/jadson/Downloads/TestsAging/python/http_test.jmx"
JS_JMX="/home/jadson/Downloads/TestsAging/js/http_test.jmx"

# Caminho para o executável do JMeter
JMETER_BIN="/home/jadson/Downloads/TestsAging/js/apache-jmeter-5.6.3/bin/jmeter.sh"


stop_workload() {
    echo -e "\n[!] Interrupção detectada. Encerrando workloads..."
    # Mata os processos
    kill $PYTHON_PID $JS_PID 2>/dev/null
    echo "[+] Testes parados com sucesso."
    exit 0
}


trap stop_workload SIGINT

#echo "Iniciando Python "
$JMETER_BIN -n -t "$PYTHON_JMX" -l /dev/null > /dev/null 2>&1 &
PYTHON_PID=$!

echo "Iniciando carga para Aplicação JS (Porta 8081)..."
$JMETER_BIN -n -t "$JS_JMX" -l /dev/null > /dev/null 2>&1 &
JS_PID=$!

echo "----------------------------------------------------"
echo "PID Python: $PYTHON_PID | PID JS: $JS_PID"
echo "Crtl+c pra parar"
echo "----------------------------------------------------"


wait
