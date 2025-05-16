import time
import threading
import undetected_chromedriver as uc

KICK_URL = "https://kick.com/elshowdelast"
VISIT_DURATION = 2 * 60  # 10 minutos
NUM_BOTS = 20

def view_bot(bot_id):
    try:
        options = uc.ChromeOptions()
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-dev-shm-usage")
        options.add_argument("--mute-audio")
        options.add_argument("--headless=new")
        options.add_argument("--disable-gpu")
        options.add_argument("--window-size=1920,1080")

        driver = uc.Chrome(options=options)
        driver.get(KICK_URL)
        print(f"🟢 Bot {bot_id} viendo {KICK_URL}")

        time.sleep(VISIT_DURATION)

        driver.quit()
        print(f"🔴 Bot {bot_id} terminó")
    except Exception as e:
        print(f"❌ Bot {bot_id} error: {e}")


# Lanzar bots en paralelo
threads = []
for i in range(NUM_BOTS):
    t = threading.Thread(target=view_bot, args=(i + 1,))
    t.start()
    threads.append(t)

for t in threads:
    t.join()

print("✅ Todos los bots finalizaron")
