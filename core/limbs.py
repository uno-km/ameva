import subprocess
import os

class AmevaLimbs:
    def __init__(self, workspace="/data/data/com.termux/files/home/projects/ameva"):
        self.workspace = os.path.expanduser(workspace)

    def execute_command(self, command):
        try:
            if "rm -rf" in command: return "❌ 위험 명령어 차단됨"
            result = subprocess.run(command, shell=True, capture_output=True, text=True, timeout=15)
            return f"STDOUT:\n{result.stdout}\nSTDERR:\n{result.stderr}"
        except Exception as e:
            return f"❌ 에러: {str(e)}"

    def get_sensory_data(self):
        """A35의 물리적 상태(온도, 배터리)를 읽어옴"""
        try:
            # 온도 읽기 (Exynos 1380 기준 thermal_zone0)
            temp_raw = subprocess.check_output("cat /sys/class/thermal/thermal_zone0/temp", shell=True).decode().strip()
            temp_c = int(temp_raw) / 1000
            
            # 배터리 상태 (termux-api 필요)
            batt_raw = subprocess.check_output("termux-battery-status", shell=True).decode().strip()
            return {"temp": temp_c, "battery": batt_raw}
        except:
            return {"temp": "Unknown", "battery": "Unknown"}

    def write_file(self, filename, content):
        path = os.path.join(self.workspace, filename)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w") as f: f.write(content)
        return f"✅ '{filename}' 작성 완료"

    def read_file(self, filename):
        path = os.path.join(self.workspace, filename)
        if not os.path.exists(path): return "❌ 파일 없음"
        with open(path, "r") as f: return f.read()