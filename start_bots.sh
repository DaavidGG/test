#!/bin/bash
for i in {1..10}; do
    python kick_view.py $i &
    sleep 1
done

wait
echo "Todos los bots finalizaron."
