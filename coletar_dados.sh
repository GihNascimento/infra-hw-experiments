#!/bin/bash
mkdir -p ~/dados_artigo
echo "=== INICIANDO COLETA ==="
echo "--- Memoria 16 MiB (30x) ---"
echo "repeticao,vazao_mib_s" > ~/dados_artigo/memoria_16.csv
for i in $(seq 1 30); do
val=$(mbw -n 1 16 | grep "AVG" | awk '{print $8}')
echo "$i,$val" | tee -a ~/dados_artigo/memoria_16.csv
done
echo "--- Memoria 128 MiB (30x) ---"
echo "repeticao,vazao_mib_s" > ~/dados_artigo/memoria_128.csv
for i in $(seq 1 30); do
val=$(mbw -n 1 128 | grep "AVG" | awk '{print $8}')
echo "$i,$val" | tee -a ~/dados_artigo/memoria_128.csv
done
echo "--- Memoria 1024 MiB (30x) ---"
echo "repeticao,vazao_mib_s" > ~/dados_artigo/memoria_1024.csv
for i in $(seq 1 30); do
val=$(mbw -n 1 1024 | grep "AVG" | awk '{print $8}')
echo "$i,$val" | tee -a ~/dados_artigo/memoria_1024.csv
done
echo "--- Paralelismo CPU (30x) ---"
echo "repeticao,threads,tempo_s" > ~/dados_artigo/paralelismo.csv
for t in 1 2 4; do
for i in $(seq 1 30); do
inicio=$(date +%s%N)
python3 -c "
N=300
M=[[i*j for j in range(N)] for i in range(N)]
print(sum(sum(r) for r in M))
" > /dev/null
fim=$(date +%s%N)
dur=$(echo "scale=4; ($fim - $inicio) / 1000000000" | bc)
echo "$i,$t,$dur" | tee -a ~/dados_artigo/paralelismo.csv
done
done
echo "--- Localidade espacial (30x) ---"
echo "repeticao,loop_a_s,loop_b_s" > ~/dados_artigo/localidade.csv
for i in $(seq 1 30); do
resultado=$(python3 -c "
import time, numpy as np
N=2048
M=np.random.rand(N,N)
t0=time.perf_counter()
for r in range(N): M[r,:].sum()
ta=round(time.perf_counter()-t0,4)
t0=time.perf_counter()
for c in range(N): M[:,c].sum()
tb=round(time.perf_counter()-t0,4)
print(f'{ta},{tb}')
")
echo "$i,$resultado" | tee -a ~/dados_artigo/localidade.csv
done
echo "=== COLETA CONCLUIDA ==="
ls ~/dados_artigo/
