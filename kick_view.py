from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
import sys

KICK_URL = "https://kick.com/elshowdelast"

def view_bot(bot_id):
    print(f"🟢 Bot {bot_id} iniciando...", flush=True)
    
    options = Options()
    options.add_argument("--headless=new")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1920,1080")
    options.add_argument("--disable-extensions")
    options.add_argument("--disable-software-rasterizer")

    # Añade un user-data-dir único por bot para evitar conflicto
    temp_dir = tempfile.mkdtemp(prefix=f"bot_{bot_id}_profile_")
    options.add_argument(f"--user-data-dir={temp_dir}")
    
    driver = None
    try:
        driver = webdriver.Chrome(options=options)
        driver.get(KICK_URL)
        print(f"✅ Bot {bot_id} viendo {KICK_URL}", flush=True)
        time.sleep(120)  # 2 minutos
        print(f"🔵 Bot {bot_id} finalizó la visualización correctamente de {KICK_URL}", flush=True)
    except Exception as e:
        print(f"❌ Bot {bot_id} error: {e}", flush=True)
    finally:
        if driver:
            try:
                driver.quit()
            except:
                pass

if __name__ == "__main__":
    bot_id = sys.argv[1] if len(sys.argv) > 1 else "1"
    view_bot(bot_id)
