import undetected_chromedriver as uc
import time
import sys

KICK_URL = "https://kick.com/elshowdelast"

def view_bot(bot_id):
    print(f"🟢 Bot {bot_id} iniciando...", flush=True)
    options = uc.ChromeOptions()
    options.headless = True
    options.binary_location = "/usr/bin/google-chrome"  # 👈 Añade esta línea

    driver = None
    try:
        driver = uc.Chrome(options=options)
        driver.get(KICK_URL)
        print(f"✅ Bot {bot_id} viendo {KICK_URL}", flush=True)
        time.sleep(120)
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
