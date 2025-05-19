import undetected_chromedriver as uc
import time
import sys
import tempfile
import shutil
import os
import traceback

KICK_URL = "https://kick.com/elshowdelast"

def view_bot(bot_id):
    print(f"🟢 Bot {bot_id} iniciando...", flush=True)

    temp_cache_dir = tempfile.mkdtemp(prefix=f"bot_{bot_id}_uc_")
    options = uc.ChromeOptions()
    options.add_argument("--headless=new")
    options.add_argument(f"--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) Bot/{bot_id}")

    driver = None
    try:
        driver = uc.Chrome(
            options=options,
            user_data_dir=os.path.join(temp_cache_dir, "profile"),
            driver_executable_path=None
        )
        driver.get(KICK_URL)
        print(f"✅ Bot {bot_id} viendo {KICK_URL}", flush=True)
        time.sleep(120)
        print(f"🔵 Bot {bot_id} finalizó la visualización correctamente de {KICK_URL}", flush=True)
    except Exception as e:
        traceback.print_exc()
        print(f"❌ Bot {bot_id} error: {e}", flush=True)
    finally:
        if driver:
            try:
                driver.quit()
            except:
                pass
        shutil.rmtree(temp_cache_dir, ignore_errors=True)

if __name__ == "__main__":
    bot_id = sys.argv[1] if len(sys.argv) > 1 else "1"
    view_bot(bot_id)
