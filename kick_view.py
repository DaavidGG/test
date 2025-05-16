import undetected_chromedriver as uc
import time
import sys

def view_bot(bot_id):
    print(f"🟢 Bot {bot_id} iniciando...", flush=True)
    options = uc.ChromeOptions()
    options.headless = True  # Ejecutar sin ventana gráfica (opcional)
    driver = None
    try:
        driver = uc.Chrome(options=options)
        driver.get("https://kick.com/elshowdelast")
        print(f"✅ Bot {bot_id} viendo Kick.com", flush=True)
        time.sleep(120)  # 2 minutos de duración
        print(f"🔵 Bot {bot_id} finalizó la visualización correctamente.", flush=True)
    except Exception as e:
        print(f"❌ Bot {bot_id} error: {e}", flush=True)
    finally:
        try:
            if driver:
                driver.quit()
        except:
            pass

if __name__ == "__main__":
    bot_id = sys.argv[1] if len(sys.argv) > 1 else "1"
    view_bot(bot_id)
