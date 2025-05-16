import sys
import time
import undetected_chromedriver as uc
from selenium.webdriver.chrome.options import Options

def view_bot(bot_id):
    print(f"🟢 Bot {bot_id} iniciando...", flush=True)

    options = uc.ChromeOptions()
    options.add_argument("--headless=new")  # "new" evita problemas de compatibilidad
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1920,1080")

    try:
        driver = uc.Chrome(options=options)
        driver.get("https://kick.com/TU_CANAL_AQUI")  # Reemplaza TU_CANAL_AQUI
        print(f"✅ Bot {bot_id} viendo Kick.com", flush=True)
        time.sleep(60)  # Mantener abierto 1 minuto
    except Exception as e:
        print(f"❌ Bot {bot_id} error: {e}", flush=True)
    finally:
        try:
            print(f"❌ Bot {bot_id} saliendo Kick.com", flush=True)
            driver.quit()
        except:
             print(f"❌ Bot {bot_id} error finally", flush=True)
            pass

if __name__ == "__main__":
    import sys
    bot_id = sys.argv[1] if len(sys.argv) > 1 else "1"
    view_bot(bot_id)
