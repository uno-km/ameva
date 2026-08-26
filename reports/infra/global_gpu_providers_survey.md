# 🌐 글로벌 GPU 대여 및 클라우드 플랫폼 전수조사 보고서

> [!NOTE]
> 본 보고서는 전 세계의 GPU 대여, 대량 임대, AI 전문 클라우드 인프라 플랫폼들의 현황을 조사한 자료입니다.
> 우리 시스템에 이미 등록된 플랫폼은 **`[v] 있음`**, 새롭게 연동 가능한 글로벌 플랫폼은 **`[ ] 없음`**으로 표시하였습니다.

---

## 1. 🇰🇷 국내 및 아시아권 플랫폼 (Local & Resellers)
주로 국내 호스팅 업체 또는 중소 B2B 렌탈, 통신사 클라우드 플랫폼들입니다. B2B 성격이 강해 가격 문의가 많은 편입니다.

| 상태 | 플랫폼 명 | 공식 주소 (URL) | 수집 가능한 데이터 | 연동 방식 | 특이사항 |
| :---: | :--- | :--- | :--- | :--- | :--- |
| **`[v] 있음`** | **gabia (가비아)** | [gabia.com](https://gabia.com) | GPU 모델명, 시간당/월간 요금 | Static Parsing | 국내 B2B 클라우드 |
| **`[v] 있음`** | **iwinv (아이윈브이)** | [iwinv.kr](https://iwinv.kr) | 인스턴스 사양, GPU 요금 | Static Parsing | 국내 저가 가성비 호스팅 |
| **`[v] 있음`** | **cloudv (클라우드브이)** | [cloudv.kr](https://cloudv.kr) | GPU 서버 사양, 월 임대 요금 | Static Parsing | 국내 IDC 인프라 대여 |
| **`[v] 있음`** | **sugarcube (StreamGPU)** | [streamgpu.io](https://streamgpu.io/ko/pricing) | GPU 사양, 실시간 분당 크레딧 요금 | Static Parsing | **[신규 확인]** 구 sugarcube 도메인에서 이전 완료 |
| **`[v] 있음`** | **ktcloud (KT 클라우드)** | [ktcloud.com](https://ktcloud.com) | AI Zone GPU 요금, 사양 | Dynamic Playwright | 국내 공공/기업용 클라우드 |
| **`[v] 있음`** | **ncloud (네이버 클라우드)** | [ncloud.com](https://ncloud.com) | 인프라 GPU 가격 리스트 | Dynamic Playwright | 네이버 클라우드 플랫폼 |
| **`[v] 있음`** | **gpuaas (GPUaaS)** | [gpuaas.co.kr](https://gpuaas.co.kr) | 실시간 GPU 단가, 스펙 | Dynamic Playwright | 국내 특화 GPU 대여 서비스 |
| **`[v] 있음`** | **runyourai (런유어에이아이)** | [runyour.ai](https://runyour.ai) | 서버 요금, 스토리지 요금 | Dynamic Playwright | 국내 컨테이너 GPU 렌탈 |
| **`[v] 있음`** | **vessl (베슬에이아이)** | [vessl.ai](https://vessl.ai) | VESSL Run 인스턴스 요금 | Dynamic Playwright | AI 오케스트레이션 플랫폼 |
| **`[v] 있음`** | **kogrobo (코그로보)** | [kogrobo.co.kr](https://kogrobo.co.kr) | RTX5090, 3090 등 월 렌탈 요금 | Static Parsing | **[버그 수정 필요]** 정규식 RTX 매칭 오류 해결 필요 |
| **`[v] 있음`** | **dknyou (디케이앤유)** | [dknyou.com](https://dknyou.com) | HPE GPU 서버 스펙 정보 | B2B Private | **[수집 제한]** 비로그인 상태는 '가격문의'만 제공 |
| **`[v] 있음`** | **snainfo (에스엔에이)** | [snainfo.com](https://snainfo.com) | GPU 서버 및 단품 렌탈 라인업 | B2B Private | **[수집 제한]** B2B 견적 전용, 공개 가격표 없음 |
| **`[v] 있음`** | **dangamsoft (단감소프트)** | [dangamsoft.com](https://dangamsoft.com) | GPU 렌탈 소개 데이터 | B2B Private | **[수집 제한]** 공개 요금표 없음 |
| **`[v] 있음`** | **globalhost (글로벌호스트)** | [globalhost.co.kr](https://globalhost.co.kr) | GPU 서버 스펙, 요금 | Static Parsing | 국내 서버 호스팅 |
| **`[v] 있음`** | **gpunex (지피유넥스)** | [gpunex.com](https://gpunex.com) | 대여 모델 및 단가 | Static Parsing | P2P 대여 및 마이닝 호스팅 |
| **`[v] 있음`** | **aieev (에이아이이브이)** | [aieev.com](https://aieev.com) | 분산형 GPU 대여 정보 | Static Parsing | 국내 분산형 연구용 대여 |
| **`[v] 있음`** | **hada (하디)** | [hada.io](https://hada.io) | 뉴스 및 인프라 요금제 | Static Parsing | 인프라 관련 소개 |
| **`[v] 있음`** | **appleplaza (애플플라자)** | - | (DB상 테이블만 존재) | - | 적재 데이터 없음 (비활성) |
| **`[v] 있음`** | **rebellion (리벨리온)** | - | (DB상 테이블만 존재) | - | 국산 NPU 전용, 실시간 데이터 없음 |

---

## 2. 🇺🇸 글로벌 AI 전문 클라우드 (Specialized GPU Clouds)
북미 및 유럽 시장에서 폭발적으로 성장 중인 AI/ML 워크로드 특화 플랫폼들입니다. 가격 투명성이 매우 높습니다.

| 상태 | 플랫폼 명 | 공식 주소 (URL) | 수집 가능한 데이터 | 연동 방식 | 특이사항 |
| :---: | :--- | :--- | :--- | :--- | :--- |
| **`[v] 있음`** | **runpod (런포드)** | [runpod.io](https://runpod.io) | 실시간 On-Demand / Spot 요금, GPU 가용성 | **공식 GraphQL API** | 개발자 선호도 최상위권 |
| **`[v] 있음`** | **xesktop (젝스탑)** | [xesktop.com](https://xesktop.com/price/) | RTX 6000 Blackwell, V100 등 USD 요금 | Static Parsing | **[신규 확인]** singular `price/` 주소로 연동 수정 필요 |
| **`[v] 있음`** | **vultr (벌쳐)** | [vultr.com](https://vultr.com) | GPU VPS 모델 및 리전별 가격 | **공식 REST API** | 글로벌 호스팅 거인 |
| **`[ ] 없음`** | **Lambda Labs (람다랩스)** | [lambdalabs.com](https://lambdalabs.com) | A100, H100, 온디맨드 & 예약 가격 | Static Parsing | AI 연구 및 학습용 표준 클라우드 |
| **`[ ] 없음`** | **TensorDock (텐서독)** | [tensordock.com](https://tensordock.com) | 온디맨드 호스트 요금, 스펙 | **공식 REST API** | 다양한 데이터센터 호스트 중개 |
| **`[ ] 없음`** | **Paperspace** | [paperspace.com](https://paperspace.com) | 인스턴스 사양, GPU 요금 | **공식 REST API** | DigitalOcean 인수 이후 인프라 결합 |
| **`[ ] 없음`** | **CoreWeave (코어위브)** | [coreweave.com](https://coreweave.com) | 대규모 고성능 인프라 요금 | B2B / Dashboard | 엔터프라이즈 AI 클러스터 리더 |
| **`[ ] 없음`** | **Latitude.sh** | [latitude.sh](https://latitude.sh) | 베어메탈 GPU 서버 가격, 리전 | **공식 REST API** | 고성능 물리서버 실시간 대여 |
| **`[ ] 없음`** | **FluidStack (플루이드스택)** | [fluidstack.io](https://fluidstack.io) | 고사양 GPU 전용 단가 | Static / API | 대형 인프라 클러스터 중개 |
| **`[ ] 없음`** | **Scaleway (스케일웨이)** | [scaleway.com](https://scaleway.com) | 유럽 리전 GPU 인스턴스 요금 | **공식 Billing API** | 유럽 최고 인프라 클라우드 |
| **`[ ] 없음`** | **Nebius AI (네비우스)** | [nebius.com](https://nebius.com) | H100, H200 등 클라우드 요금 | Static Parsing | 유럽 신흥 고성능 AI 전문 클라우드 |

---

## 3. 🌐 분산형 및 탈중앙화 GPU 마켓플레이스 (DePIN Platforms)
개인, 중소 채굴기 소유자, 중소 IDC의 유휴 GPU를 글로벌 마켓으로 모아 중개하는 탈중앙화 물리 인프라(DePIN) 네트워크입니다. **단가가 전 세계에서 가장 저렴하며, 실시간 API 지원이 훌륭합니다.**

| 상태 | 플랫폼 명 | 공식 주소 (URL) | 수집 가능한 데이터 | 연동 방식 | 특이사항 |
| :---: | :--- | :--- | :--- | :--- | :--- |
| **`[v] 있음`** | **vast-ai (바스트 에이아이)** | [vast.ai](https://vast.ai) | 실시간 호스트별 가격, GPU 종류, Uptime | **공식 REST API** | 전 세계 최저가 대여의 대명사 |
| **`[ ] 없음`** | **io.net (아이오넷)** | [io.net](https://io.net) | 솔라나 기반 분산 GPU 단가, 공급량 | REST API / Dashboard | DePIN GPU 분야 최대 시가총액 프로젝트 |
| **`[ ] 없음`** | **Akash Network (아카시)** | [akash.network](https://akash.network) | 역경매 기반 GPU 인스턴스 단가 | Cosmos/Akash API | 코스모스 생태계 기반 클라우드 |
| **`[ ] 없음`** | **Clore.ai (클로어)** | [clore.ai](https://clore.ai) | 마켓 플레이스 실시간 요금, 호스트 스펙 | **공식 JSON API** | 채굴 및 연산 성능 렌탈 특화 |
| **`[ ] 없음`** | **Cudo Compute (쿠도컴퓨트)** | [cudocompute.com](https://cudocompute.com) | 글로벌 데이터센터 분산 GPU 요금 | Public API / Static | AI 연산 분산형 마켓플레이스 |

---

## 4. ☁️ 퍼블릭 클라우드 대기업 (Hyperscalers)
전 세계 클라우드 시장을 지배하는 초대형 퍼블릭 클라우드입니다. 가격은 비싸지만 엔터프라이즈 기능 연동으로 필수 수집 대상입니다.

| 상태 | 플랫폼 명 | 공식 주소 (URL) | 수집 가능한 데이터 | 연동 방식 | 특이사항 |
| :---: | :--- | :--- | :--- | :--- | :--- |
| **`[v] 있음`** | **aws (아마존 웹 서비스)** | [aws.amazon.com](https://aws.amazon.com) | 전 세계 리전별 EC2 GPU 인스턴스 요금 | **AWS Price List API** | 클라우드 점유율 1위 |
| **`[v] 있음`** | **gcp (구글 클라우드)** | [cloud.google.com](https://cloud.google.com) | Compute Engine GPU 가격 | **Google Billing API** | AI 하드웨어(TPU, GPU) 리더 |
| **`[ ] 없음`** | **Azure (MS 클라우드)** | [azure.microsoft.com](https://azure.microsoft.com) | N 시리즈 AI 인스턴스 요금 | **Retail Prices API** | OpenAI 파트너십 인프라 기반 |
| **`[ ] 없음`** | **OCI (오라클 클라우드)** | [oracle.com](https://oracle.com) | GPU 리전별 단가 리스트 | Price List API | 엔비디아의 핵심 파트너 클라우드 중 하나 |

---

### 💡 조사 요약 및 향후 연동 추천
1. **국내 B2B/렌탈몰 한계 극복:** 현재 보유 중인 `dknyou`, `snainfo`, `dangamsoft` 등은 가격이 비공개라 데이터를 가져오지 못하고 있습니다. 
2. **글로벌 API 플랫폼 추가 추천 (우선순위 상):**
   * **Lambda Labs** (Static 크롤링으로 간단히 람다 표준가 연동 가능)
   * **Clore.ai** (공식 API가 있어 1시간 만에 연동 가능)
   * **TensorDock** / **Latitude.sh** (공식 REST API 제공으로 구현 쉬움)
3. **글로벌 DePIN 마켓플레이스 추가 추천:**
   * **io.net** 및 **Akash Network**는 최신 분산형 AI 트렌드의 핵심이므로, 해당 요금을 확보하여 우리 플랫폼의 요금 지표 경쟁력을 극대화할 수 있습니다.
