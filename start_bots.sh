#!/bin/bash
for i in $(seq 1 10); do
  echo "🟢 Iniciando Bot $i"
  python kick_view.py $i &
done

wait
echo "Todos los bots finalizaron."
