# 📊 InfraIndex 데이터 전수조사 보고서
> 작성일: 2026-07-31 | 조사자: Antigravity AI Agent
> 대상 레포: infraindex-batch + infraindex-platform
> 조사 방법: 코드베이스 정적 분석 (파일 전수 탐색 + grep 패턴 검색)

---

## 🗂️ 목차
1. AI 토큰 가격 크롤링
2. CPU 리테일 가격
3. GPU 리테일 가격
4. DRAM 가격
5. 반도체 주식 가격
6. GPU 서버 렌트비
7. CPU 서버 렌트비
8. 클라우드 스토리지 렌트비
9. 뉴스
10. 유튜브
11. 취약점 / 목데이터 / 하드코딩 / 풀백 종합

---

## 1. AI 토큰 가격 크롤링

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | AI_PRICING_CRAWLING |
| 서비스 경로 | apps/batch/services/ai_pricing/ |
| 수집 방식 | OpenRouter API (REST JSON) |
| 대상 API | https://openrouter.ai/api/v1/models |
| 저장 테이블 | ai_model_master, ai_model_price_history |

### DTL 상세

| job_id | slug | job_nm | use_yn | 국가/리전 | 상태 |
|--------|------|--------|--------|-----------|------|
| JOB_OPENROUTER | openrouter | OpenRouter Crawling | Y | 글로벌 | ✅ 정상 |
| JOB_DEEPINFRA | deepinfra | DeepInfra AI Pricing | Y | 글로벌(US) | ✅ 정상 |
| JOB_NOVITA | novita | Novita AI Pricing | Y | 글로벌 | ✅ 정상 |

### 수집 대상 AI 모델

| Tier | 모델 ID | 제공사 | 국가 |
|------|---------|--------|------|
| Tier 0 | openai/o1-pro | OpenAI | US |
| Tier 0 | openai/o1 | OpenAI | US |
| Tier 0 | openai/o1-mini | OpenAI | US |
| Tier 1 | anthropic/claude-opus-4.1 | Anthropic | US |
| Tier 1 | anthropic/claude-opus-5 | Anthropic | US |
| Tier 1 | google/gemini-3.1-pro-preview | Google | US |
| Tier 1 | openai/gpt-4o | OpenAI | US |
| Tier 1 | openai/gpt-4.1 | OpenAI | US |
| Tier 2 | anthropic/claude-sonnet-5 | Anthropic | US |
| Tier 2 | mistralai/mistral-large | Mistral | EU |
| Tier 2 | google/gemini-2.5-pro | Google | US |
| Tier 3 | anthropic/claude-haiku-4.5 | Anthropic | US |
| Tier 3 | openai/gpt-4o-mini | OpenAI | US |
| Regional-China | deepseek/deepseek-r1 | DeepSeek | CN |
| Regional-China | deepseek/deepseek-v4-pro | DeepSeek | CN |
| Regional-China | z-ai/glm-5.2 | Zhipu AI | CN |
| Regional-EU | mistralai/mistral-small-3.2-24b | Mistral | EU(FR) |
| Regional-Korea | upstage/solar-pro-3 | Upstage | KR |

> **[WARNING]** LG Exaone, CLOVA X, HyperCLOVA X, Alibaba Qwen 등 누락.

---

## 2. CPU 리테일 가격

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | RETAIL_DATA_CRAWLING |
| 서비스 경로 | apps/batch/services/market/crawler_retail.py |
| 수집 방식 | Naver Shopping API + Coupang Affiliate API |
| 저장 테이블 | market_product, market_listing, market_price_observation |
| 국가/리전 | KR (한국) |

### DTL 상세

| job_id | slug | job_nm | use_yn | 상태 |
|--------|------|--------|--------|------|
| JOB_RETAIL_UNIVERSAL | retail_universal | Universal Retail | Y | ✅ 네이버+쿠팡 |
| JOB_ENTERPRISE_HW | retail_enterprise | Enterprise HW Retail | Y | ✅ CDW/B&H/Newegg |

### 수집 CPU 키워드 (하드코딩)

| 키워드 | 구분 | 국가 |
|--------|------|------|
| i9-14900K | Consumer CPU | 국내 유통 |
| Ryzen 9 7950X3D | Consumer CPU | 국내 유통 |
| i7-14700K | Consumer CPU | 국내 유통 |
| Ryzen 7 7800X3D | Consumer CPU | 국내 유통 |
| NVIDIA A100 | AI/Server GPU | 국내 |
| NVIDIA H100 | AI/Server GPU | 국내 |
| DDR5 32GB | RAM | 국내 |
| DDR5 64GB | RAM | 국내 |

### 엔터프라이즈 리테일 (해외)

| 사이트 | URL | 국가 | 상태 |
|--------|-----|------|------|
| CDW | cdw.com | US | ✅ Playwright |
| B&H Photo | bhphotovideo.com | US | ✅ Playwright |
| Newegg | newegg.com | US | ✅ Playwright |

> **[WARNING]** Naver API Key 미설정시 RuntimeError 전체 중단.
> **[CAUTION]** 검색 키워드 코드 내 하드코딩. RTX 5090, RX 9000, Intel Arc 미포함.

---

## 3. GPU 리테일 가격

배치 BAS: RETAIL_DATA_CRAWLING (CPU와 동일 배치)

| 수집 GPU 키워드 | 구분 | 국가 |
|----------------|------|------|
| RTX 4090 | Consumer GPU | 국내 |
| RTX 4080 SUPER | Consumer GPU | 국내 |
| RTX 4070 Ti | Consumer GPU | 국내 |
| RX 7900 XTX | AMD GPU | 국내 |
| NVIDIA RTX 6000 Ada | Workstation | 국내 |
| Tesla V100 | Legacy Server | 국내 |

> **[CAUTION]** RTX 5090/5080 (최신세대), AMD RX 9000, Intel Arc 완전 누락.

---

## 4. DRAM 가격

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | FINANCIAL_DATA_CRAWLING |
| 서비스 경로 | apps/batch/services/financial/ |
| 크롤러 | DramFuturesCrawler + DramExchangeCrawler |
| 저장 테이블 | fin_mkt_history |

### DTL 상세

| job_id | slug | job_nm | use_yn | 수집 소스 | 국가/리전 | 상태 |
|--------|------|--------|--------|-----------|-----------|------|
| JOB_DRAM_FUTURES | financial | DRAM Futures | Y | yfinance 프록시 | 글로벌 | ✅ |
| JOB_STOCK_MARKET | financial | Stock Market | Y | yfinance | 글로벌 | ✅ |

### DRAM 수집 세부

| 구분 | 크롤러 | 수집 소스 | 심볼 | 국가 |
|------|--------|-----------|------|------|
| 주가 프록시 | DramFuturesCrawler | yfinance | 000660.KS (SK하이닉스) | KR (KRX) |
| 주가 프록시 | DramFuturesCrawler | yfinance | MU (Micron) | US (NASDAQ) |
| 주가 프록시 | DramFuturesCrawler | yfinance | 005930.KS (삼성전자) | KR (KRX) |
| 현물가격 | DramExchangeCrawler | dramexchange.com | DRAM Spot Price | TW |
| 현물가격 | DramExchangeCrawler | dramexchange.com | Module Spot Price | TW |
| 현물가격 | DramExchangeCrawler | dramexchange.com | Flash Spot (NAND) | TW |
| 현물가격 | DramExchangeCrawler | dramexchange.com | Wafer Spot Price | TW |
| 현물가격 | DramExchangeCrawler | dramexchange.com | eMMC Spot Price | TW |

> **[WARNING]** DramFuturesCrawler는 선물가가 아닌 주가 프록시. SSL verify=False 인증서 경고 상시 발생.
> **[CRITICAL]** adapters/macro/memory_crawler.py에 목데이터 잔존 (DDR5=$320, HBM3E=$4500).

---

## 5. 반도체 주식 가격

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | FINANCIAL_DATA_CRAWLING |
| 서비스 경로 | apps/batch/services/financial/crawler_stock.py |
| 크롤러 클래스 | StockMarketCrawler |
| 저장 테이블 | fin_mkt_history |
| 수집 방식 | yfinance (Yahoo Finance API) |

### DTL 상세

| job_id | slug | job_nm | use_yn | 상태 |
|--------|------|--------|--------|------|
| JOB_STOCK_MARKET | financial | Stock Market | Y | ✅ 정상 |

### 현재 수집 중인 종목

| 심볼 | 기업명 | 거래소 | 국가 | 상태 |
|------|--------|--------|------|------|
| NVDA | NVIDIA Corporation | NASDAQ | US | ✅ 수집 |
| AMD | Advanced Micro Devices | NASDAQ | US | ✅ 수집 |
| 005930.KS | Samsung Electronics | KRX | KR | ✅ 수집 |
| 000660.KS | SK Hynix | KRX | KR | ✅ 수집 |
| WDC | Western Digital (SanDisk) | NASDAQ | US | ✅ 수집 |

### 누락된 주요 종목 (미구현)

| 요청 종목 | 심볼 | 거래소 | 국가 | 구현 상태 |
|----------|------|--------|------|-----------|
| Intel | INTC | NASDAQ | US | ❌ 미구현 |
| Micron Technology | MU | NASDAQ | US | ⚠️ DramFutures에서만 |
| 창신메모리(CXMT) | 비상장 | 비상장 | CN | ❌ 수집불가 |
| Qualcomm | QCOM | NASDAQ | US | ❌ 미구현 |
| TSMC | TSM | NYSE/TWSE | TW | ❌ 미구현 |
| ASML | ASML | NASDAQ/AMS | NL | ❌ 미구현 |
| Broadcom | AVGO | NASDAQ | US | ❌ 미구현 |

> **[CAUTION]** SYMBOLS 리스트 코드 내 하드코딩. Intel, TSMC, Qualcomm 등 핵심 반도체주 미수집.

---

## 6. GPU 서버 렌트비 (GPU Cloud Rental)

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | GPU_DATA_CRAWLING |
| 서비스 경로 | apps/batch/services/gpu/ + crawlers/ |
| 저장 테이블 | gpu_prc_hist / tbl_gpu_prc_hist |

### DTL 전체 목록 — 정상 수집 (Active)

| job_id | slug | 서비스명 | 국가/리전 | 수집방식 | 상태 |
|--------|------|---------|-----------|---------|------|
| JOB_VAST_AI | vast-ai | Vast.ai | Global | REST API | ✅ |
| JOB_RUNPOD | runpod | RunPod | Global | REST API | ✅ |
| JOB_AWS_GPU | aws_gpu | AWS GPU | US/Global | Scraping | ✅ |
| JOB_VESSL | vessl | VESSL AI | KR | Dynamic | ✅ |
| JOB_XESKTOP | xesktop | Xesktop | KR | Static HTML | ✅ |
| JOB_GPUAAS | gpuaas | GPUaaS | KR | Dynamic | ✅ |
| JOB_CLOUDV | cloudv | CloudV | Global | Static HTML | ✅ |
| JOB_RUNYOURAI | runyourai | RunYourAI | KR | Dynamic | ✅ |
| JOB_KTCLOUD | ktcloud | KT Cloud | KR | Dynamic | ✅ |
| JOB_GPU_IWINV | iwinv | iwinv | KR | Static HTML | ✅ |
| JOB_SUGARCUBE | sugarcube | Sugarcube/StreamGPU | KR | Static HTML | ✅ |
| JOB_GPU_KOGROBO | kogrobo | Kogrobo | KR | Static HTML | ✅ |
| JOB_GPU_GLOBALHOST | globalhost | Globalhost | KR | Static HTML | ✅ |
| JOB_NCLOUD | ncloud | Naver Cloud | KR | Dynamic | ✅ |
| JOB_GPU_CLORE | clore | Clore AI | Global | Public API | ✅ |
| JOB_GPU_TENSORDOCK | tensordock | TensorDock | US/Global | API (Key) | ⚠️ API키 필요 |
| JOB_GPU_LATITUDE | latitude | Latitude.sh | US/Global | API (Key) | ⚠️ API키 필요 |
| JOB_GPU_LAMBDA | lambda | Lambda Labs | US | API (Key) | ⚠️ API키 필요 |
| JOB_GPU_IONET | ionet | io.net | Global DePIN | Public API | ✅ |
| JOB_GPU_AKASH | akash | Akash Network | Global DePIN | Static HTML | ✅ |
| JOB_GPU_OCI | oci | Oracle OCI | Global | Static HTML | ✅ |
| JOB_GPU_E2E | e2enetworks | E2E Networks | IN | Custom | ✅ |
| JOB_COREWEAVE | coreweave | CoreWeave | US | Playwright | ✅ |
| JOB_NEBIUS | nebius | Nebius AI Cloud | Global | Playwright | ✅ |
| JOB_DEEPINFRA | deepinfra | DeepInfra | Global | REST API | ✅ |
| JOB_NOVITA | novita | Novita AI | Global | REST API | ✅ |
| JOB_GPU_PAPERSPACE | paperspace | Paperspace | US | API (Key) | ⚠️ API키 필요 |
| JOB_GPU_FLUIDSTACK | fluidstack | FluidStack | Global | API (Key) | ⚠️ API키 필요 |
| JOB_GPU_SCALEWAY | scaleway | Scaleway | EU(FR) | API (Key) | ⚠️ API키 필요 |

### DTL 전체 목록 — 항상 실패 (use_yn=Y but Raise)

| job_id | slug | 서비스명 | 국가/리전 | 실패 이유 |
|--------|------|---------|-----------|----------|
| JOB_GPU_IBM | ibm_cloud | IBM Cloud | Global | B2B 전용 퍼블릭 접근 불가 |
| JOB_GPU_ALIBABA | alibaba | Alibaba Cloud | CN | 중국 본토 접근 차단 + 인증 |
| JOB_GPU_TENCENT | tencent | Tencent Cloud | CN | 중국 본토 접근 차단 + 인증 |
| JOB_GPU_HUAWEI | huawei | Huawei Cloud | CN | 중국 본토 접근 차단 + 인증 |
| JOB_GPU_AETHIR | aethir | Aethir | Global DePIN | Mesh API Key 필요 |
| JOB_GPU_RENDER | render | Render GPU | Global DePIN | stub 미구현 |
| JOB_GPU_NOSANA | nosana | Nosana | Solana DePIN | 온체인 쿼리 필요 |
| JOB_GPU_GOLEM | golem | Golem Network | Global DePIN | stub 미구현 |
| JOB_GPU_SPHERON | spheron | Spheron | Global DePIN | stub 미구현 |
| JOB_GPU_FLUENCE | fluence | Fluence | Global DePIN | stub 미구현 |
| JOB_GPU_HYPERSTACK | hyperstack | Hyperstack | Global | stub 미구현 |
| JOB_GPU_MODAL | modal | Modal Labs | US | stub 미구현 |
| JOB_GPU_CIVO | civo | Civo Cloud | Global | stub 미구현 |
| JOB_GPU_CRUSOE | crusoe | Crusoe Energy | US | stub 미구현 |
| JOB_GPU_NHNCLOUD | nhncloud | NHN Cloud | KR | stub 미구현 |
| JOB_GPU_KAKAO | kakaocloud | Kakao Cloud | KR | stub 미구현 |
| JOB_GPU_SMILESERV | smileserv | SmileServ | KR | stub 미구현 |
| JOB_GPU_KINX | kinx | KINX IXcloud | KR | stub 미구현 |
| JOB_GPU_AIFACTORY | aifactory | AI Factory | KR | stub 미구현 |
| JOB_GPU_CUDO | cudo | Cudo Compute | Global | Cloudflare Turnstile 차단 |

### 비활성화(use_yn=N)

| job_id | slug | 비활성 사유 |
|--------|------|------------|
| JOB_GABIA | gabia | 2026-07-30 사이트 개편(가격 삭제) |
| JOB_GPU_GCP_STATIC | gcp | 미구현 |
| JOB_GPU_DKNYOU | dknyou | 가격 비공개(문의형) |
| JOB_GPU_HADA | hada | 블로그형 전환 |
| JOB_GPU_GPUNEX | gpunex | 블로그형 전환 |
| JOB_GPU_AIEEV | aieev | 구조 변경 |
| JOB_REBELLION | rebellion | 미구현 |
| JOB_APPLEPLAZA | appleplaza | 미구현 |

---

## 7. CPU 서버 렌트비 (Cloud CPU / Baremetal)

### CPU 클라우드 배치 BAS: CPU_DATA_CRAWLING

| job_id | slug | job_nm | use_yn | 국가/리전 | 방식 | 상태 |
|--------|------|--------|--------|-----------|------|------|
| JOB_AWS_CPU | aws_cpu | AWS CPU Crawler | Y | US/Global | JSON API | ✅ |
| JOB_CPU_GCP | gcp | GCP Compute CPU | Y | Global | JSON API | ✅ |
| JOB_CPU_AZURE | azure | Azure VM CPU | Y | Global | GenericCrawler | ✅ |
| JOB_CPU_ORACLE | oracle | Oracle OCI CPU | Y | Global | GenericCrawler | ✅ |
| JOB_CPU_HETZNER | hetzner | Hetzner Cloud CPU | Y | EU(DE) | GenericCrawler | ✅ |
| JOB_CPU_VULTR | vultr | Vultr Cloud CPU | Y | Global | GenericCrawler | ✅ |
| JOB_CPU_LINODE | linode | Linode Cloud CPU | Y | Global | GenericCrawler | ✅ |
| JOB_CPU_DIGITALOCEAN | digitalocean | DigitalOcean Droplet | Y | Global | GenericCrawler | ✅ |
| JOB_CPU_RAM (aws) | aws | CPU Crawling | N | 중복비활성 | - | ❌ |

### RAM 클라우드 배치 BAS: RAM_DATA_CRAWLING

| job_id | slug | job_nm | use_yn | 국가/리전 | 상태 |
|--------|------|--------|--------|-----------|------|
| JOB_AWS_RAM | aws_ram | AWS RAM Crawler | Y | US/Global | ✅ |
| JOB_RAM_GCP | gcp | GCP Compute RAM | Y | Global | ✅ |
| JOB_RAM_AZURE | azure | Azure VM RAM | Y | Global | ✅ |
| JOB_RAM_ORACLE | oracle | Oracle OCI RAM | Y | Global | ✅ |
| JOB_RAM_HETZNER | hetzner | Hetzner Cloud RAM | Y | EU(DE) | ✅ |
| JOB_RAM_VULTR | vultr | Vultr Cloud RAM | Y | Global | ✅ |

### Baremetal 배치 BAS: BAREMETAL_DATA_CRAWLING

| job_id | slug | job_nm | use_yn | 국가/리전 | 방식 | 상태 |
|--------|------|--------|--------|-----------|------|------|
| JOB_HOSTINGKR | hostingkr | HostingKR | Y | KR | HTML파싱 | ✅ |
| JOB_KTCLOUD | ktcloud | KTCloud BM | Y | KR | HTML파싱 | ✅ |
| JOB_IWINV | iwinv | iwinv BM | Y | KR | HTML파싱 | ✅ |
| JOB_CAFE24 | cafe24 | Cafe24 BM | Y | KR | HTML파싱 | ✅ |
| JOB_KTCLOUD_BM | ktcloud_bm | KT Cloud BM | Y | KR | HTML파싱 | ✅ |
| JOB_LATITUDE | latitude | Latitude.sh BM | Y | US/Global | API | ✅ |
| JOB_HETZNER | hetzner | Hetzner BM | Y | EU(DE) | API | ✅ |
| JOB_VULTR | vultr | Vultr BM | Y | Global | API | ✅ |
| JOB_CHERRY_SERVERS | cherry_servers | Cherry Servers | Y | EU(LT) | API | ✅ |
| JOB_PHOENIXNAP | phoenixnap | phoenixNAP | Y | US | API | ✅ |
| JOB_EQUINIX | equinix_metal | Equinix Metal | Y | US/Global | API | ✅ |
| JOB_HIVELOCITY | hivelocity | Hivelocity | Y | US | API | ✅ |

---

## 8. 클라우드 스토리지 렌트비

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | STORAGE_DATA_CRAWLING |
| 서비스 경로 | apps/batch/services/market/crawler_storage_global.py |
| 저장 테이블 | storage_price_history |

### DTL 상세

| job_id | slug | job_nm | use_yn | 국가/리전 | 상태 |
|--------|------|--------|--------|-----------|------|
| JOB_AWS_STORAGE | aws_storage | AWS Storage | Y | US/Global | ✅ |
| JOB_STORAGE_GLOBAL | global | Storage Global | Y | Global | ⚠️ 하드코딩 |
| JOB_STORAGE_GCP | gcp | GCP Storage | Y | Global | ✅ |
| JOB_STORAGE_CLOUDFLARE | cloudflare | Cloudflare R2 | Y | Global | ✅ |
| JOB_STORAGE_BACKBLAZE | backblaze | Backblaze B2 | Y | Global | ✅ |
| JOB_STORAGE_WASABI | wasabi | Wasabi | Y | Global | ✅ |
| JOB_STORAGE_AZURE | azure | Azure Blob & Disk | Y | Global | ✅ |
| JOB_STORAGE_IDRIVE | idrive | IDrive e2 | Y | Global | ✅ |
| JOB_STORAGE_AWS | aws | AWS S3 | N | 비활성 | ❌ |

### 스토리지 가격 수집 현황 (GLOBAL_STORAGE_PROVIDERS — 전부 하드코딩!)

| 제공사 | 제품명 | 가격 (USD/GB/월) | 유형 | 리전 | 국가 |
|--------|--------|----------------|------|------|------|
| AWS | EBS gp3 | $0.08 | Block SSD | us-east-1 | US |
| AWS | EBS io2 | $0.125 | Block SSD | us-east-1 | US |
| AWS | S3 Standard | $0.023 | Object | us-east-1 | US |
| GCP | Persistent Disk Standard | $0.04 | Block HDD | us-central1 | US |
| Azure | Managed Disk Standard | $0.05 | Block HDD | us-east | US |
| Wasabi | Hot Cloud | $0.0069 | Object | us-east-1 | US |
| Backblaze | B2 | $0.006 | Object | US | US |
| Cloudflare | R2 | $0.015 | Object | Global | Global |
| DigitalOcean | Spaces | $0.02 | Object | nyc3 | US |
| Vultr | Block NVMe | $0.08 | Block SSD | New Jersey | US |
| Hetzner | Storage Box 10TB | $0.0033 | HDD | EU | DE |
| Hetzner | Volume Block SSD | $0.052 | Block SSD | EU | DE |
| Linode (Akamai) | Block Storage | $0.10 | Block SSD | us-east | US |
| OVH Cloud | Object Storage | $0.011 | Object | EU | FR |
| NCloud (Naver) | Object Storage | 25 KRW/GB/월 | Object | Korea | KR |
| KT Cloud | Object Storage | 22 KRW/GB/월 | Object | Korea | KR |
| Kakao Cloud | Object Storage | 20 KRW/GB/월 | Object | Korea | KR |

> **[CAUTION]** 위 가격 전체가 2024년 기준 코드 내 상수값. 실시간 크롤링 없음. 환율만 실시간.

---

## 9. 뉴스

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | NEWS_DATA_CRAWLING |
| 서비스 경로 | apps/batch/services/news/ |
| 저장 테이블 | news_article |

### DTL 상세

| job_id | slug | job_nm | use_yn | 수집 소스 | 국가 | 상태 |
|--------|------|--------|--------|-----------|------|------|
| JOB_NEWS_TIER | news | News Tier Crawling | Y | Tier1+2+3 통합 | Global | ✅ |
| JOB_NEWS_TIER1 | tier1 | Tier 1 RSS | Y | Bloomberg/Reuters/HN | Global | ✅ |
| JOB_NEWS_TIER2 | tier2 | Tier 2 API | Y | 뉴스 API | Global | ✅ |
| JOB_NEWS_TIER3 | tier3 | Tier 3 Browser | Y | Playwright 헤드리스 | Global | ✅ |
| JOB_NEWS_YOUTUBE | youtube | YouTube AI News | Y | youtube-search-python | Global | ✅ |
| JOB_PAPER_ARXIV | arxiv | arXiv 논문 수집 | Y | arXiv API | Global | ✅ |
| JOB_NEWS_HISTORICAL | historical | 과거 뉴스 이력 | Y | 다중소스 | Global | ✅ |

### 뉴스 RSS 소스 (하드코딩)

| Tier | 소스명 | URL | 언어 |
|------|--------|-----|------|
| Tier 1 | Bloomberg Tech | feeds.bloomberg.com/technology/news.xml | EN |
| Tier 1 | Reuters Tech | reutersagency.com/feed | EN |
| Tier 1 | Hacker News | hnrss.org/frontpage | EN |

> **[WARNING]** 한국 뉴스(조선비즈, 디일렉, 전자신문 등) 완전 미포함. RSS URL 하드코딩.

---

## 10. 유튜브

### 배치 기본정보

| 항목 | 값 |
|------|-----|
| 배치 BAS | NEWS_DATA_CRAWLING |
| 서비스 경로 | apps/batch/services/news/crawler_youtube.py |
| 저장 테이블 | news_article (content_type='youtube') |
| 수집 라이브러리 | youtube-search-python (API Key 불필요) |

### DTL 상세

| job_id | slug | job_nm | use_yn | 국가 | 상태 |
|--------|------|--------|--------|------|------|
| JOB_NEWS_YOUTUBE | youtube | YouTube AI & Infra News | Y | Global | ✅ |

### YouTube 검색 키워드 (하드코딩)

| 검색어 | 분류 |
|--------|------|
| "NVIDIA H100" | GPU 하드웨어 |
| "Semiconductor Market" | 반도체 시장 |
| "DRAM Price" | 메모리 가격 |
| "Data Center AI" | AI 인프라 |

> **[WARNING]** 상대시간("2 days ago") → ISO 날짜 변환 실패. except: 절에서 현재시간으로 덮어씀 → 날짜 오염.
> 한국어 키워드 없음. 검색어 4개만 하드코딩.

---

## 11. 취약점 / 목데이터 / 하드코딩 / 풀백 종합

### CRITICAL — 데이터 신뢰성 직접 훼손

| 번호 | 파일 경로 | 유형 | 내용 | 영향 범위 |
|------|-----------|------|------|----------|
| C-001 | adapters/macro/memory_crawler.py | 목데이터 잔존 | DDR5=$320, HBM3E=$4500 하드코딩 반환 | DRAM/메모리 가격 |
| C-002 | adapters/macro/news_crawler.py | 목데이터 잔존 | mock_news 하드코딩 반환 | 뉴스 수집 |
| C-003 | adapters/macro/power_crawler.py | 목데이터 잔존 | mock_power_data 하드코딩 반환 | 전력 가격 |
| C-004 | crawler_youtube.py L81-83 | bare except/빈칸리턴 | except: dt = datetime.now() — 날짜 오염 | YouTube 날짜 |
| C-005 | crawler_storage_global.py | 전체 하드코딩 | 17개 스토리지 가격 전부 2024년 정적 상수 | 스토리지 렌트비 |
| C-006 | crawler_stock.py | 심볼 하드코딩 | SYMBOLS = ["NVDA","AMD","005930.KS","000660.KS","WDC"] | 주식 수집 |

### HIGH — 항상 실패 크롤러 (use_yn=Y이지만 raise)

| 번호 | 크롤러 | 실패 이유 | use_yn |
|------|--------|----------|--------|
| H-001 | IBM Cloud | 엔터프라이즈 B2B 전용 | Y |
| H-002 | Alibaba Cloud | 중국 접근 차단 | Y |
| H-003 | Tencent Cloud | 중국 접근 차단 | Y |
| H-004 | Huawei Cloud | 중국 접근 차단 | Y |
| H-005 | Aethir | Mesh API Key 필요 | Y |
| H-006 | Render GPU | stub 미구현 | Y |
| H-007 | Nosana | Solana 온체인 미구현 | Y |
| H-008 | Golem | stub 미구현 | Y |
| H-009 | Spheron | stub 미구현 | Y |
| H-010 | Fluence | DePIN 미구현 | Y |
| H-011 | Hyperstack | stub 미구현 | Y |
| H-012 | Modal Labs | stub 미구현 | Y |
| H-013 | Civo | stub 미구현 | Y |
| H-014 | Crusoe Energy | stub 미구현 | Y |
| H-015 | NHN Cloud | stub 미구현 | Y |
| H-016 | Kakao Cloud | stub 미구현 | Y |
| H-017 | SmileServ | stub 미구현 | Y |
| H-018 | KINX | stub 미구현 | Y |
| H-019 | AI Factory | stub 미구현 | Y |
| H-020 | Cudo Compute | Cloudflare Turnstile 차단 | Y |

### MEDIUM — API 키 미설정시 실패

| 번호 | 크롤러 | 필요 환경변수 | 미설정시 |
|------|--------|------------|---------|
| M-001 | TensorDock | TENSORDOCK_API_KEY | RuntimeError |
| M-002 | Lambda Labs | LAMBDA_API_KEY | RuntimeError |
| M-003 | Latitude.sh | LATITUDE_API_KEY | RuntimeError |
| M-004 | Paperspace | PAPERSPACE_API_KEY | RuntimeError |
| M-005 | FluidStack | FLUIDSTACK_API_KEY | RuntimeError |
| M-006 | Scaleway | SCALEWAY_SECRET_KEY | RuntimeError |
| M-007 | Naver Shopping | NAVER_SHOPPING_CLIENT_ID + _SECRET | RuntimeError |

### LOW — 코드 품질 / 구조적 문제

| 번호 | 위치 | 유형 | 내용 |
|------|------|------|------|
| L-001 | batch_runner.py L79-80 | 데드코드 | else: logger.warning Unknown bat_id — 도달불가 |
| L-002 | orchestrator.py L271 | 빈집합 하드코딩 | NOT_IMPLEMENTED_PROVIDERS = set() 항상 비어있음 |
| L-003 | scratch_job_mapping.json | 중복 job_id | JOB_CPU_RAM, JOB_CPU_AWS 동일 슬러그 중복 |
| L-004 | crawler_storage_global.py L240 | 폴백 환율 | 환율API 실패시 1380.0 하드코딩 |
| L-005 | crawler_youtube.py L81 | bare except | 모든 예외 무시하고 현재시간 반환 |
| L-006 | news/crawler_tier1_rss.py | 하드코딩 URL | Bloomberg/Reuters RSS URL 상수 |
| L-007 | financial/crawler_dram.py | 이름 오해 | DramFuturesCrawler — 실제로는 주가프록시 |
| L-008 | scratch_job_mapping.json | 중복 등록 다수 | sugarcube/akash/cudo 2회씩 중복 |

---

## 종합 커버리지 요약표

| 데이터 카테고리 | 구현 | 방식 | 하드코딩 | 목데이터 | 즉시 가동 |
|---------------|------|------|---------|---------|---------|
| AI 토큰 가격 | ✅ | OpenRouter API | 일부 | 없음 | ✅ |
| CPU 리테일 | ✅ | Naver/Coupang | 키워드 | 없음 | ⚠️ API키 |
| GPU 리테일 | ✅ | Naver/Coupang | 키워드 | 없음 | ⚠️ API키 |
| DRAM 현물가 | ✅ | DRAMeXchange | 없음 | 없음 | ✅ |
| DRAM 프록시 주가 | ✅ | yfinance | 없음 | 없음 | ✅ |
| HBM/DDR5 서버용 | ❌ | (목데이터) | 전체 | **있음** | ❌ |
| 반도체 주식 NVDA/AMD | ✅ | yfinance | 심볼 | 없음 | ✅ |
| 반도체 주식 Intel | ❌ | 미구현 | - | - | ❌ |
| 반도체 주식 Micron | ⚠️ | yfinance(DRAM만) | - | 없음 | ✅ |
| 반도체 주식 TSMC | ❌ | 미구현 | - | - | ❌ |
| 창신메모리 CXMT | ❌ | 수집불가(비상장) | - | - | ❌ |
| GPU 서버렌트 (국내) | ✅ | HTML/API | 없음 | 없음 | ✅ |
| GPU 서버렌트 (글로벌) | ⚠️ | API/Playwright | 없음 | 없음 | ⚠️ |
| GPU 서버렌트 DePIN | ❌ | Stub(raise) | - | 없음 | ❌ |
| CPU 서버렌트 클라우드 | ✅ | JSON API | 없음 | 없음 | ✅ |
| Baremetal 서버렌트 | ✅ | API/HTML | 없음 | 없음 | ✅ |
| 클라우드 스토리지 | ⚠️ | 정적상수 | **전체** | 없음 | ⚠️ |
| 뉴스 글로벌 | ✅ | RSS/API/Playwright | 일부 URL | 없음 | ✅ |
| 뉴스 한국 | ❌ | 미포함 | - | - | ❌ |
| 유튜브 | ✅ | youtube-search-python | 키워드 | 없음 | ⚠️ 날짜버그 |

---

## 긴급 개선 권고 (Priority순)

### P1 — 즉시 수정 (데이터 오염)
1. adapters/macro/memory_crawler.py → 목데이터 삭제 또는 파이프라인 제거
2. crawler_youtube.py → except: 절 구체화 + 상대시간 절대시간 변환 구현
3. DramFuturesCrawler → DramProxyCrawler 이름 오해 방지 수정

### P2 — 단기 개선 (데이터 공백)
4. StockMarketCrawler.SYMBOLS에 INTC, MU, TSM, QCOM, AVGO 추가
5. crawler_storage_global.py 하드코딩 가격을 DB테이블화 또는 실시간 크롤링 교체
6. 한국 뉴스 RSS 추가 (조선비즈, 디일렉, ZDNet Korea)

### P3 — 중기 개선 (커버리지)
7. IBM/Alibaba/Tencent/Huawei → use_yn=N 비활성화 (현재 Y이지만 항상 실패)
8. Stub 크롤러 20개 → 구현 또는 use_yn=N 처리
9. 스토리지 가격 실시간 크롤링 구현 (현재 2024년 정적값)
10. 유튜브 검색 키워드 DB화 + 한국어 키워드 추가

---
*보고서 끝 — 조사 기준일: 2026-07-31 09:50 KST*
