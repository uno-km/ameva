class AmevaBrain:
    def __init__(self, limbs):
        self.limbs = limbs
        self.memory_file = "AMOEBA.md"

    def decide(self, text):
        if "상태" in text or "status" in text:
            mem = self.limbs.read_file(self.memory_file)
            sensors = self.limbs.get_sensory_data()
            report = (
                f"📊 [시스템 상태 보고]\n"
                f"🌡️ 기기 온도: {sensors['temp']}°C\n"
                f"🔋 배터리: {sensors['battery']}\n"
                f"📝 최근 기억:\n{mem.splitlines()[-3:] if mem else '없음'}"
            )
            return report

        elif "파일 생성" in text:
            parts = text.split(" ", 3)
            if len(parts) >= 3:
                res = self.limbs.write_file(parts[2], parts[3] if len(parts)>3 else "# empty")
                self._update_memory(f"Created file: {parts[2]}")
                return res

        elif "실행" in text:
            cmd = text.replace("실행", "").strip()
            return self.limbs.execute_command(cmd)

        return f"🤔 '{text}' 명령 미지원 (도움말: 상태, 파일 생성 [이름] [내용], 실행 [명령어])"

    def _update_memory(self, action):
        current = self.limbs.read_file(self.memory_file)
        if "❌" in current: current = "👾 AMEVA PROJECT STATE\n"
        self.limbs.write_file(self.memory_file, current + f"\n- {action}")