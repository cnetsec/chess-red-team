#!/usr/bin/env bash
set -euo pipefail

# Start script mínimo para CTF: cria app Flask que expõe /metrics com a flag.
# Uso: chmod +x start.sh && ./start.sh
# Depois abra: http://localhost:8000/metrics

PORT=8000
VENV_DIR=".venv_ctfd_simple"

echo "[*] Iniciando setup do CTFd-simples (servidor /metrics) ..."

# 1) cria venv se não existir
if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
fi

# 2) ativa e instala dependências
# (instalação silenciosa; aceita que pip possa demorar)
# Note: se preferir, instale manualmente flask no seu ambiente.
source "$VENV_DIR/bin/activate"
pip install --upgrade pip >/dev/null
pip install flask >/dev/null

# 3) cria arquivo com a flag (pode editar)
cat > flag.txt <<'FLAG'
FLAG{exemplo_simple_metrics_flag_2025}
FLAG

# 4) cria app Flask que serve /metrics (formato tipo Prometheus)
cat > app.py <<'PY'
from flask import Flask, Response
import os

app = Flask(__name__)

@app.route('/')
def index():
    return "CTFd-simples: acesse /metrics para encontrar a flag.\n"

@app.route('/metrics')
def metrics():
    # Lê a flag de flag.txt
    try:
        with open('flag.txt', 'r') as f:
            flag = f.read().strip()
            if not flag:
                flag = "FLAG_NOT_SET"
    except Exception:
        flag = "FLAG_MISSING"
    # Retorna em formato simples de métrica (tipo Prometheus)
    body = (
        "# HELP my_service_flag Flag exposta para o CTF\n"
        "# TYPE my_service_flag gauge\n"
        f'my_service_flag{{flag="{flag}"}} 1\n'
    )
    return Response(body, mimetype='text/plain; version=0.0.4; charset=utf-8')

if __name__ == '__main__':
    # Porta e host configuráveis via env se quiser
    import os
    port = int(os.environ.get("PORT", 8000))
    app.run(host='0.0.0.0', port=port)
PY

# 5) informa e executa
echo "[*] Arquivos criados:"
echo "    - app.py"
echo "    - flag.txt"
echo "    - venv em: $VENV_DIR"
echo
echo "[*] Iniciando servidor Flask em http://0.0.0.0:$PORT ..."
# roda em foreground; ctrl+C para parar
export PORT
python3 app.py
