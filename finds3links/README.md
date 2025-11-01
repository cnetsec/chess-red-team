# 🪣 Find S3 Links

GitHub Action para **descobrir e testar buckets S3 públicos** a partir de uma URL.

---

## 🚀 Como usar

1. Vá em **Actions → Find S3 Links → Run workflow**  
2. Informe a **URL** que deseja verificar (`target_url`)  
3. Execute e aguarde o resultado

---

## ⚙️ O que faz

- Baixa a página informada  
- Extrai possíveis links de S3  
- Testa se algum está público (`HTTP 200`)  
- Mostra o resultado direto no console

---

## 🧾 Resultado esperado

---

## 📦 Artifacts

| Arquivo | Descrição |
|----------|------------|
| `s3_found.txt` | URL do bucket público encontrado |
| `results.json` | Códigos HTTP dos testes |

---

🧠 *A varredura é passiva, sem uso de credenciais ou ações invasivas.*
