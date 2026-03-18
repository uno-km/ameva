import os

class AmevaBrain:
    def __init__(self, limbs):
        self.limbs = limbs
        self.memory_file = "AMOEBA.md"

    def decide(self, text):
        # 1. 텍스트 분석 (나중에 BitNet이 처리할 부분)
        # 지금은 간단한 키워드 매핑으로 에이전트 흉내를 냅니다.
        
        if "상태 보고" in text or "status" in text:
            content = self.limbs.read_file(self.memory_file)
            return f"📊 현재 상태 보고:\n{content}"

        elif "파일 생성" in text:
            # 예: "파일 생성 test.py print('hello')"
            parts = text.split(" ", 3)
            if len(parts) >= 3:
                filename = parts[2]
                code = parts[3] if len(parts) > 3 else "# empty file"
                res = self.limbs.write_file(filename, code)
                self._update_memory(f"Created file: {filename}")
                return res

        elif "실행" in text:
            # 예: "실행 python test.py"
            cmd = text.replace("실행", "").strip()
            res = self.limbs.execute_command(cmd)
            return f"⚙️ 실행 결과:\n{res}"

        return f"🤔 '{text}' 명령을 이해하지 못했습니다. (도움말: 상태 보고, 파일 생성, 실행)"

    def _update_memory(self, action):
        """기억(AMOEBA.md) 업데이트"""
        current_mem = self.limbs.read_file(self.memory_file)
        new_mem = current_mem + f"\n- {action}"
        self.limbs.write_file(self.memory_file, new_mem)
