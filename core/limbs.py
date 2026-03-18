import subprocess
import os

class AmevaLimbs:
    def __init__(self, workspace="/data/data/com.termux/files/home/projects/ameva"):
        self.workspace = os.path.expanduser(workspace)

    def execute_command(self, command):
        """셸 명령어를 실행하고 결과를 반환함"""
        try:
            # 보안을 위해 위험한 명령어 차단 (기초)
            if "rm -rf /" in command:
                return "❌ 위험한 명령어는 실행할 수 없습니다."
            
            result = subprocess.run(
                command, shell=True, capture_output=True, text=True, timeout=15
            )
            return f"STDOUT:\n{result.stdout}\nSTDERR:\n{result.stderr}"
        except Exception as e:
            return f"❌ 실행 에러: {str(e)}"

    def write_file(self, filename, content):
        """파일을 생성하거나 수정함"""
        try:
            path = os.path.join(self.workspace, filename)
            os.makedirs(os.path.dirname(path), exist_ok=True)
            with open(path, "w") as f:
                f.write(content)
            return f"✅ '{filename}' 파일 작성 완료."
        except Exception as e:
            return f"❌ 파일 쓰기 실패: {str(e)}"

    def read_file(self, filename):
        """파일 내용을 읽어옴"""
        try:
            path = os.path.join(self.workspace, filename)
            with open(path, "r") as f:
                return f.read()
        except Exception as e:
            return f"❌ 파일 읽기 실패: {str(e)}"
