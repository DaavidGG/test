import time
import threading
import undetected_chromedriver as uc

KICK_URL = "https://kick.com/elshowdelast"
VISIT_DURATION = 2 * 60  # 10 minutos
NUM_BOTS = 20

def view_bot(bot_id: str):
    print(f"🟢 Bot {bot_id} iniciando...")

    options = Options()
    options.headless = True
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")

    try:
        driver = uc.Chrome(options=options)
        driver.get("https://kick.com/TU_CANAL_AQUI")

        print(f"✅ Bot {bot_id} viendo el stream...")
        time.sleep(120)  # 2 minutos
    except Exception as e:
        print(f"❌ Bot {bot_id} error: {e}")
    finally:
        driver.quit()
        print(f"🔴 Bot {bot_id} finalizó.")

if __name__ == "__main__":
    bot_id = sys.argv[1] if len(sys.argv) > 1 else "1"
    view_bot(bot_id)


# Lanzar bots en paralelo
threads = []
for i in range(NUM_BOTS):
    t = threading.Thread(target=view_bot, args=(i + 1,))
    t.start()
    threads.append(t)

for t in threads:
    t.join()

print("✅ Todos los bots finalizaron")
