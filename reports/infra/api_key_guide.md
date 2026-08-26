# 🔑 논문 및 쇼핑 API 키 발급 총정리 가이드

현재 수집(크롤링) 배치가 막혀 있는 핵심 학술/논문 및 쇼핑 플랫폼들의 API 키 발급 방법과 사이트 주소를 정리했습니다. 아래 가이드에 따라 API 키를 발급받으신 후, `.env` 파일에 기입해 주시면 해당 크롤러들의 락(Lock)을 해제하고 연동을 진행할 수 있습니다.

---

## 🛒 1. 쇼핑 / 소매 (Retail) API

### 네이버 쇼핑 (Naver Shopping)
*   **용도:** B2C(기업-소비자) 기업용 랩탑, 하드웨어 소매가 수집
*   **사이트 주소:** [네이버 개발자 센터 (Naver Developers)](https://developers.naver.com/main/)
*   **API 종류:** `검색 API` -> `쇼핑`
*   **발급 방법:**
    1. 네이버 개발자 센터 로그인
    2. 상단 메뉴 [Application] -> [애플리케이션 등록]
    3. 사용 API에서 '검색' 선택, 비로그인 오픈 API로 등록
    4. 발급된 `Client ID`와 `Client Secret` 확인
*   **필요 환경변수명:** `NAVER_SHOPPING_CLIENT_ID`, `NAVER_SHOPPING_CLIENT_SECRET`

---

## 🎓 2. 학술 / 논문 (Academic Papers) API

### 구글 학술검색 (Google Scholar / SerpApi)
*   **용도:** 글로벌 논문 동향 분석 (Google Scholar는 공식 API가 없어 SerpApi 우회 사용)
*   **사이트 주소:** [SerpApi 계정 페이지](https://serpapi.com/)
*   **발급 방법:**
    1. SerpApi 접속 후 회원가입
    2. 이메일 인증 후 대시보드(Dashboard) 진입
    3. 화면 중앙에 있는 `Your Private API Key` 복사 (매월 100건 무료)
*   **필요 환경변수명:** `SERPAPI_API_KEY` (또는 `GOOGLE_SCHOLAR_API_KEY`)

### CiNii (일본 학술 정보 API)
*   **용도:** 일본 논문 및 연구 동향 데이터 수집
*   **사이트 주소:** [CiNii API 개발자 페이지](https://support.nii.ac.jp/en/cinii/api/api_outline)
*   **발급 방법:**
    1. CiNii Articles API 사용을 위해 Application ID (AppID) 등록 신청 페이지 접속
    2. 소속, 이메일, 사용 목적(비영리 연구/학술 등)을 영문 또는 일어로 작성하여 제출
    3. 이메일로 발급된 `AppID` 확인 (며칠 소요될 수 있음)
*   **필요 환경변수명:** `CINII_APP_ID` (또는 `CINII_API_KEY`)

### RISS (한국교육학술정보원 논문 API)
*   **용도:** 국내 학술지 및 학위논문 데이터 수집
*   **사이트 주소:** [RISS OpenAPI 신청 페이지](http://www.riss.kr/openapi/openApiReg.do)
*   **발급 방법:**
    1. RISS 로그인 (또는 KERIS 통합회원 가입)
    2. RISS OpenAPI 신청 페이지 접속 (또는 하단 푸터 'OpenAPI' 메뉴 클릭)
    3. 사용 목적, 도메인 등을 기입하고 신청
    4. 자동 승인 또는 심사 후 발급된 `API Key` 복사
*   **필요 환경변수명:** `RISS_API_KEY`

### CORE (세계 최대 Open Access 논문 제공)
*   **용도:** 영국 등 전 세계 오픈액세스 기반 논문 메타데이터 수집
*   **사이트 주소:** [CORE API Dashboard](https://core.ac.uk/services/api/)
*   **발급 방법:**
    1. CORE 홈페이지 접속 후 `Register` (회원가입)
    2. 로그인 후 API Dashboard 진입
    3. 기본적으로 즉시 발급된 API Key 확인 (제한적 호출 무료)
*   **필요 환경변수명:** `CORE_API_KEY`

### Semantic Scholar
*   **용도:** 글로벌 AI 및 컴퓨터 공학 특화 논문 데이터 수집
*   **사이트 주소:** [Semantic Scholar API 신청](https://www.semanticscholar.org/product/api)
*   **발급 방법:**
    1. 홈페이지 접속 후 `Request API Key` 폼 작성
    2. 학술/연구 목적(Research)으로 신청하면 이메일로 키가 발송됨 (API Key가 없어도 제한된 속도로 호출은 가능하나, 대량 배치(Batch) 구동 시 차단 방지를 위해 필수)
*   **필요 환경변수명:** `SEMANTIC_SCHOLAR_API_KEY`

---

## 📌 다음 단계 (Action)
위 발급 링크들을 참조하시어 필요한 API Key들을 확보해 주시면, 논문 크롤러들이 더 이상 멈추지 않고 데이터를 정상적으로 수집할 수 있습니다. 

**(준비가 완료되셨다면, 이어서 바로 "글로벌 미구현 크롤러 전면 개발 계획서"를 띄워드리겠습니다.)**
