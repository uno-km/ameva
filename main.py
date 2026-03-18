from core.messenger import AmevaMessenger
from core.brain import AmevaBrain
from core.limbs import AmevaLimbs
import config

def main():
    # 1. 팔다리(Limbs) 장착
    limbs = AmevaLimbs()
    
    # 2. 뇌(Brain) 가동 및 팔다리 연결
    brain = AmevaBrain(limbs=limbs)

    # 3. 메신저(Messenger) 가동 및 뇌 연결
    ameva_bot = AmevaMessenger(brain_callback=brain.decide)
    
    print("👾 AMEVA가 물리적 제어 권한을 가지고 깨어났습니다.")
    ameva_bot.run()

if __name__ == "__main__":
    main()
