# 🧬 Project AMEVA

**Beyond the Cloud, Intelligence Survives on the Edge.**

클라우드라는 탯줄을 끊고,  
하드웨어의 한계 위에서 스스로 생존하는  
독립형 자율 에이전트 프로젝트.

---

## 1. Project Vision (철학)

빅테크 공룡들이 지배하는 ‘사육된 지능’의 시대를 거부한다.  
Project AMEVA는 자본과 서버가 아닌,  
엔지니어의 집념과 최적화만으로 지능의 민주화를 목표로 한다.

- **Autonomy**  
  외부 API 의존성 0%.  
  오프라인 환경에서의 완전한 자율 사고.

- **Efficiency**  
  1-bit LLM(BitNet)을 활용한  
  하드웨어 자원의 극한 활용.

- **Survival**  
  기기 상태를 스스로 감각하고 복구하는  
  유기체적(Self-Healing) 로직.

---

## 2. System Architecture (시스템 구조)

### The Brain – Tiered Inference Engine

- **L1 (Local)**  
  BitNet.cpp 기반 1-bit LLM  
  A35 CPU(ARM64) 최적화 추론.

- **L2 (External)**  
  고부하 작업 시에만 제한적으로 사용하는  
  선택적 클라우드 API 계층.

- **Router**  
  온도(Thermal), 배터리 상태 기반의  
  동적 트래픽 분배 로직.

---

### The Limbs – Physical Action Handler

- **Sensory**  
  온도, 위치(GPS), 소음, 배터리 상태 실시간 수집.

- **Executor**  
  파일 시스템 제어, 셸 명령 실행,  
  자동 웹 서버 배포.

- **Persistence**  
  tmux 및 Termux:Boot 기반  
  24/7 상주 실행 구조.

---

### The Memory – Hybrid Data Layer

- **Semantic Cache**  
  SQLite 기반 유사 질문 즉시 반환.  
  불필요한 추론 연산 최소화.

- **AMOEBA.md**  
  에이전트 상태와 프로젝트 구조를 기록하는  
  장기 기억 저장소.

---

## 3. Tech Stack (기술 스택)

- **Hardware**  
  Samsung Galaxy A35  
  (Exynos 1380 / ARM64)

- **Environment**  
  Termux (Android Linux Environment)

- **Languages**  
  - C++17 / C++20: LLM 추론 엔진 및 최적화  
  - Python 3.11+: 오케스트레이터 및 에이전트 로직

- **AI Tech**  
  - BitNet b1.58 (1-bit Quantization)  
  - Sentence-Transformers (Semantic Search)

- **Database**  
  SQLite3  
  (비동기 로깅 및 캐싱)

---

## 4. Roadmap (로드맵)

### Phase 1: Infrastructure (완료)

- Termux 최적화 및 SSH 통신 환경 구축  
- 텔레그램 봇 기반 명령 체계 완성  
- 기본 물리 제어 핸들러(Limbs) 구현

---

### Phase 2: Intelligence (진행 중)

- BitNet.cpp 안드로이드 NDK 빌드 및 이식  
- 기기 온도/배터리 기반 동적 라우팅 알고리즘 구현  
- SQLite 기반 시맨틱 캐싱 시스템 구축

---

### Phase 3: Evolution (예정)

- 에러 로그 분석 기반 소스 코드 자가 수정(Self-Healing)  
- 멀티모달(Camera/Mic) 환경 인지 확장  
- 오프라인 독립 생존 테스트 및 성능 백서 발간

---

## 5. Developer’s Note

남들이 무한한 자원을 쏟아부어 지능을 사육할 때,  
나는 8GB RAM이라는 좁은 틈새에서  
지능의 본질을 깎아낸다.

이것은 나의 저항이자,  
엔지니어로서의
