import undetected_chromedriver as uc
import time
import sys
import tempfile
import shutil
import os
import traceback
import random
from fake_useragent import UserAgent
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

KICK_URL = "https://youtu.be/gSln4tG4TfQ?si=G8TPXj59pcGg_qyB"

class BotRunner:
def init(self, bot_id):
self.bot_id = bot_id
self.temp_cache_dir = tempfile.mkdtemp(prefix=f"bot_{bot_id}uc")
self.driver = None
self.ua = UserAgent()

def _configure_options(self):
    options = uc.ChromeOptions()
    options.add_argument(f"--user-agent={self.ua.random}")
    options.add_argument("--headless=new")
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--lang=en-US")
    options.add_argument("--window-size=1920,1080")
    
    # Opcional: Configurar proxy (descomentar y completar)
    # proxy_server = self._get_proxy()
    # options.add_argument(f"--proxy-server={proxy_server}")
    
    return options

def _human_interaction(self):
    try:
        # Comportamiento de navegación realista
        actions = [
            lambda: self.driver.execute_script(f"window.scrollBy(0, {random.randint(200, 800)})"),
            lambda: time.sleep(random.uniform(0.5, 3)),
            lambda: self.driver.find_element(By.TAG_NAME, 'body').click(),
            lambda: self.driver.switch_to.window(self.driver.window_handles[0])
        ]
        random.shuffle(actions)
        
        for action in actions[:random.randint(2, 4)]:
            action()
            
    except Exception as e:
        print(f"⚠️ Bot {self.bot_id} interacción fallida: {str(e)}", flush=True)

def _watch_video(self):
    try:
        # Navegación inicial realista
        self.driver.get("https://www.google.com")
        WebDriverWait(self.driver, 10).until(
            EC.presence_of_element_located((By.NAME, "q"))
        )
        time.sleep(random.uniform(1, 3))

        # Acceso al video
        self.driver.get(KICK_URL)
        WebDriverWait(self.driver, 30).until(
            EC.presence_of_element_located((By.TAG_NAME, "video"))
        )

        print(f"✅ Bot {self.bot_id} video cargado", flush=True)
        
        # Simulación de visualización
        total_watch = random.randint(110, 130)
        for _ in range(total_watch // 10):
            self._human_interaction()
            time.sleep(10)

    except Exception as e:
        raise RuntimeError(f"Error durante la visualización: {str(e)}")

def run(self):
    print(f"🟢 Bot {self.bot_id} iniciado", flush=True)
    try:
        options = self._configure_options()
        self.driver = uc.Chrome(
            options=options,
            user_data_dir=os.path.join(self.temp_cache_dir, "profile"),
            driver_executable_path=None,
            use_subprocess=True,
            headless=True
        )
        
        self._watch_video()
        print(f"🔵 Bot {self.bot_id} completado exitosamente", flush=True)

    except Exception as e:
        traceback.print_exc()
        print(f"❌ Bot {self.bot_id} error crítico: {e}", flush=True)
        sys.exit(1)
    finally:
        self._cleanup()

def _cleanup(self):
    try:
        if self.driver:
            self.driver.quit()
    except Exception as e:
        print(f"⚠️ Bot {self.bot_id} error cerrando driver: {str(e)}", flush=True)
    
    try:
        shutil.rmtree(self.temp_cache_dir, ignore_errors=True)
    except Exception as e:
        print(f"⚠️ Bot {self.bot_id} error limpiando cache: {str(e)}", flush=True)
if name == "main":
if len(sys.argv) != 2:
print("❌ Uso: python kick_view.py <bot_id>", flush=True)
sys.exit(1)

bot_id = sys.argv[1]
bot = BotRunner(bot_id)
bot.run()
