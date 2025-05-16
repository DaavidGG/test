import undetected_chromedriver as uc
import sys
import time
from selenium.webdriver.chrome.options import Options

def view_bot(bot_id: str):
    print(f"🟢 Bot {bot_id} iniciando...")

    options = Options()
    options.headless = True
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")

    try:
        uc.install(use_subprocess=True, version_main=135)  # 👈 fuerza versión compatible
        driver = uc.Chrome(options=options)
        driver.get("https://kick.com/TU_CANAL_AQUI")

        print(f"✅ Bot {bot_id} viendo el stream...")
        time.sleep(120)
    except Exception as e:
        print(f"❌ Bot {bot_id} error: {e}")
    finally:
        try:
            driver.quit()
        except:
            pass
        print(f"🔴 Bot {bot_id} finalizó.")
