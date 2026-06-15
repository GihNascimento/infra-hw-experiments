# infra-hw-experiments

Experimentos de caracterização de desempenho de hardware para o artigo:
**"Impacto da Localidade Espacial no Desempenho de Memória: Degradação de 7,66× em Sistema Intel Core i5-1135G7"**

Autora: Giovanna Karla Santos do Nascimento  
CESAR School – Recife, PE, Brasil

---

## Hardware utilizado

| Componente | Especificação |
|---|---|
| Processador | Intel Core i5-1135G7 (Tiger Lake, 4 núcleos / 8 threads) |
| Frequência | 2,40 GHz base / 4,20 GHz turbo |
| Cache L1d/L1i/L2/L3 | 192 KiB / 128 KiB / 5 MiB / 8 MiB |
| RAM | 16 GiB DDR4 (canal único) |
| Armazenamento | NVMe PCIe Gen3 x4 |
| Sistema Operacional | Ubuntu 22.04 LTS via WSL2 (Windows 11) |

---

## Como reproduzir os experimentos

### 1. Instalar dependências
```bash
sudo apt update && sudo apt install -y mbw python3 python3-numpy
```

### 2. Rodar coleta completa (30 repetições por condição)
```bash
bash coletar_dados.sh
```

### 3. Os resultados serão salvos em:
- `memoria_16.csv` — largura de banda com array de 16 MiB
- `memoria_128.csv` — largura de banda com array de 128 MiB
- `memoria_1024.csv` — largura de banda com array de 1.024 MiB
- `localidade.csv` — tempo de execução Loop A (sequencial) vs Loop B (colunar)
- `paralelismo.csv` — tempo de execução com 1, 2 e 4 threads

---

## Resultados principais

| Experimento | Resultado | p-value |
|---|---|---|
| Localidade espacial (B/A) | 7,66× degradação | p < 0,001 |
| Banda de memória (16→1024 MiB) | estável ~8.800 MiB/s | p = 0,61 |
| Paralelismo 4 threads Python | speedup 0,86× | p = 0,003 |

---

## Licença
MIT License — veja o arquivo LICENSE.
