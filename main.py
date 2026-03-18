from core.messenger import AmevaMessenger
from core.brain import AmevaBrain
from core.limbs import AmevaLimbs

def main():
    limbs = AmevaLimbs()
    brain = AmevaBrain(limbs=limbs)
    # brain.decide 함수를 콜백으로 전달
    messenger = AmevaMessenger(brain_callback=brain.decide)

    print("👾 AMEVA가 물리적 제어권을 확보하고 깨어났습니다.")
    messenger.run()

if __name__ == "__main__":
    main()