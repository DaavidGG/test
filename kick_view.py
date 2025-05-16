import sys
import time
import undetected_chromedriver as uc
from selenium.webdriver.chrome.options import Options

def view_bot(bot_id: str):
    print(f"🟢 Bot {bot_id} iniciando...")

    options = Options()
    options.headless = True
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")

    try:
        driver = uc.Chrome(options=options)
        driver.get("https://kick.com/TU_CANAL_AQUI")  # Cambia por tu canal real

        print(f"✅ Bot {bot_id} viendo el stream...")
        time.sleep(120)  # 2 minutos
    except Exception as e:
        print(f"❌ Bot {bot_id} error: {e}")
    finally:
        driver.quit()
        print(f"🔴 Bot {bot_id} finalizó.")

if __name__ == "__main__":
    import sys  # <--- Esta línea es esencial
    bot_id = sys.argv[1] if len(sys.argv) > 1 else "1"
    view_bot(bot_id)
