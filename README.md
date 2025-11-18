# be22-1st-team4-project

# 🎥 시네파이브 (CINEFIVE)

<div align="center">
  <img src="./img/cinefive_wh_logo.png" alt="시네파이브 로고" width="300" />
</div>

---

## 🧑‍💻 팀원 소개 (Team Members)

<!-- 1행 1열 표를 사용하여 팀원들을 가로로 배치하고 중앙 정렬 -->
<table align="center">
  <tr>
    <td align="center">
      <img src="./img/JJH.png" alt="정진호" width="150" height="432" /><br>
      <b>정진호</b><br>
      팀장 (Leader)
    </td>
    <td align="center">
      <img src="./img/PCJ.png" alt="박찬진" width="150" height="432" /><br>
      <b>박찬진</b><br>
      서기 (Secretary)
    </td>
    <td align="center">
      <img src="./img/CYH.png" alt="최연후" width="150" height="432" /><br>
      <b>최연후</b><br>
      조원 (Member)
    </td>
    <td align="center">
      <img src="./img/IWS.png" alt="임원석" width="130" height="432" /><br>
      <b>임원석</b><br>
      조원 (Member)
    </td>
    <td align="center">
      <img src="./img/SCW.png" alt="손창우" width="150" /><br>
      <b>손창우</b><br>
      조원 (Member)
    </td>
  </tr>
</table>

---

## 💡 1. 프로젝트 개요

**시네파이브**(CINEFIVE)는 사용자의 취향을 분석하여 영화를 추천하고, 예매 연계 및 관련 상품 구매까지 한 번에 해결할 수 있는 **영화 중심 통합 플랫폼**입니다. 기존의 분산된 영화 관련 활동의 불편함을 해소하고, 사용자 편의성과 몰입도를 높이는 것을 목표로 합니다.

### 🎯 1-1. 프로젝트 주제

영화 추천, 예매 연계, 굿즈 주문, 커뮤니티 기능을 결합한 **통합 영화 커뮤니티 플랫폼 개발**

### 📌 1-2. 프로젝트 배경 및 필요성

영화 정보, 예매, 후기 공유, 굿즈 구매 등의 기능이 서로 다른 플랫폼에 **분산되어 있는 불편함**을 해소하고, 영화와 관련된 모든 활동을 하나의 서비스에서 통합적으로 제공하여 사용자 편의성과 몰입도를 높이기 위해 씨네파이브가 기획되었습니다.

---

## 🛠️ 2. 기술 스택

| 영역 (Category) | 기술 (Technology) | 설명 (Description) |
| :--- | :--- | :--- |
| **Database** | `MariaDB` | 영화 정보, 사용자 데이터, 게시물 등 핵심 데이터 관리 |
| **Server OS** | `Linux` | 서버 운영 및 배포 환경 구축 |
| **DB Tool** | `DataGrip` | 데이터베이스 모델링, 개발 및 관리 도구 |


---

## ✨ 3. 씨네파이브 주요 기능

### 🎯 3-1. 추천 시스템
- 사용자 선호도, 시청 이력, 평가 데이터를 기반으로 한 **AI 개인화 영화 추천**

### 🎟️ 3-2. 예매 기능
- 여러 극장과 연동된 **영화 예매 통합 관리**

### 🛒 3-3. 주문 기능
- 영화 관련 **굿즈·티켓·콜라보 상품** 구매 기능
- 포인트 및 쿠폰을 통한 간편 결제 시스템

### 💬 3-4. 게시판 / 커뮤니티
- 영화 후기, 정보 공유, 자유 게시판 운영
- 좋아요, 댓글, 레벨로 활발한 참여 유도

---

## 🌟 4. 차별화 전략

| 항목 | 기존 서비스 | 씨네파이브 차별점 |
| :--- | :--- | :--- |
| **영화 추천** | 단순 인기순/장르 기반 | **AI 기반 개인 맞춤 추천** |
| **예매 연계** | 단일 극장 중심 | **통합 예매 연계 시스템** |
| **커뮤니티** | 제한된 후기 작성 | **자유로운 주제의 게시판, 실시간 소통** |
| **굿즈 판매** | 별도 사이트 이동 필요 | **내부 연동된 굿즈 스토어** |
| **데이터 활용** | 제한적 | **사용자 행동 기반 피드백 시스템** |

---

## 📈 5. 기대 효과

- **원스톱 영화 서비스 구현:** 영화 추천, 예매, 굿즈, 커뮤니티 활동을 한 플랫폼에서 통합 제공하여 편의성 및 몰입도 증대.
- **개인 맞춤형 경험 제공:** 사용자 선호 기반 알고리즘을 통해 이용자에게 맞는 영화를 빠르게 발견 가능.
- **커뮤니티 중심의 영화 생태계 형성:** 활발한 소통을 통해 영화 소비 문화 활성화.
- **국내 영화 산업 발전 기여:** 독립 영화 등 노출 기회 확대 및 시장 활성화.

---

## 🏗️ 6. 프로젝트 구조

📂 be22-1st-team4-project/   
├── 📂 img/ (로고 및 팀원 이미지)   
├── 📂 test/ (테스트 관련 파일)   
├── 📄 .gitignore (버전 관리 제외 목록)   
├── 📄 README.md (현재 문서)   
└── 📄 createtable.sql (데이터베이스 테이블 생성 스크립트)   

---

## 📄 7. 요구사항 명세서

[요구사항 명세서 링크](https://docs.google.com/spreadsheets/d/1Dzsq76gKhSPuUmJWd8vvfGTF1MSGJRGIXNhX9SVIqMY/edit?gid=1378379683#gid=1378379683)

---

## 🗺️ 8. 유스케이스
유스케이스 다이어그램 또는 주요 유스케이스 목록을 여기에 넣어주세요.
### 8-1. 유스케이스 다이어그램
<!-- 유스케이스 다이어그램 이미지 삽입 (예: img/usecase.png) -->
<div align="center">
<img src="./img/usecase.png" alt="유스케이스 다이어그램" width="700" />
</div>

[유스케이스 다이어그램 링크](https://drive.google.com/file/d/1kIo6SOqdB-oSVYlT01-yCAPYiYR3gZuV/view?usp=drive_link)

---

## 🗃️ 9. 데이터 모델링 (Data Modeling)
### 9-1. 논리 모델링 (Logical Data Model)
<!-- 논리 모델링 이미지 또는 다이어그램을 여기에 삽입 (예: img/logical_model.png) -->
<div align="center">
<img src="./img/logical_model.png" alt="논리 모델링 다이어그램" width="700" />
</div>

### 9-2. 물리 모델링 (Physical Data Model)
<!-- 물리 모델링 이미지 또는 다이어그램을 여기에 삽입 (예: img/physical_model.png) -->
<div align="center">
<img src="./img/physical_model.png" alt="물리 모델링 다이어그램" width="700" />
</div>

---

## 📋 10. 테이블 구조 (Table Structure)
프로젝트에서 사용되는 전체 테이블의 상세 구조입니다.

### 10-1. 회원 및 권한
#### TBL_USERS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| USER_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 회원 코드 (PK) |
| USER_ID | VARCHAR(50) | NOT NULL | 회원 아이디 |
| USER_PW | VARCHAR(255) | NULL | 비밀번호 (해싱 저장, 소셜로그인 시 NULL) |
| USER_NICK_NM | VARCHAR(50) | NOT NULL | 닉네임 |
| USER_EMAIL | VARCHAR(100) | NOT NULL | 이메일 |
| USER_LV | INT | NOT NULL, DEFAULT 1 | 회원 레벨 (1-4=일반, 5=관리자) |
| USER_ST | VARCHAR(20) | NOT NULL, DEFAULT 'ACTIVE' | 계정 상태 (ACTIVE, DORMANT, BANNED, DELETED) |
| USER_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 가입일시 |
| USER_MOD_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 마지막 정보 수정일시 |
| USER_NM | VARCHAR(50) | NULL | 실명 |
| USER_TEL | VARCHAR(20) | NULL | 전화번호 |
| USER_BIRTH_DT | DATE | NULL | 생년월일 |
| USER_SEX_GB | CHAR(1) | NULL | 성별 구분 (M,F) |
| USER_JUSO | VARCHAR(255) | NULL | 주소 |
| USER_JUSO_D | VARCHAR(255) | NULL | 상세주소 |

#### TBL_USER_SOCIAL_ACCOUNTS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| SOCIAL_ACCOUNT_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 소셜 계정 연동 코드 (PK) |
| USER_CD | INT | FK, NOT NULL | 회원 코드 (FK) |
| PROVIDER_CD | VARCHAR(20) | NOT NULL | 소셜 제공자 코드 (KAKAO, NAVER) |
| PROVIDER_ID | VARCHAR(255) | NOT NULL | 소셜 제공자가 발급한 고유 ID |

### 10-2. 상품
#### TBL_PRODUCT_CATEGORIES
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PRODUCT_CTGRY_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 상품 카테고리 코드 (PK) |
| PRODUCT_CTGRY_NM | VARCHAR(100) | NOT NULL | 상품 카테고리명 (한글, 음식/음료/굿즈/패키지) |

#### TBL_PRODUCT_TYPE
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PRODUCT_TYPE_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 상품 타입 코드 (PK) |
| PRODUCT_TYPE_NM | VARCHAR(100) | NOT NULL | 상품 타입명 (한글, 실물/기프티콘) |

#### TBL_PRODUCTS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PRODUCT_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 상품 코드 (PK) |
| PRODUCT_TYPE_CD | INT | FK, NOT NULL | 상품 타입 코드 (FK) |
| PRODUCT_CTGRY_CD | INT | FK, NOT NULL | 상품 카테고리 코드 (FK) |
| PRODUCT_NM | VARCHAR(255) | NOT NULL | 상품명 |
| PRODUCT_PRICE_AMT | INT | NOT NULL | 기본 가격 |
| PRODUCT_IMG_URL | VARCHAR(255) | NULL | 대표 이미지 URL |
| PRODUCT_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 등록일시 |
| PRODUCT_MOD_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 수정일시 |

#### TBL_PRODUCTS_PACKAGE_SPECS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PRODUCT_CD | INT | PFK, NOT NULL | 상품 코드 (PFK) |
| PRODUCT_LIST | VARCHAR(500) | NULL | 패키지 구성 |

#### TBL_PRODUCTS_DRINK_SPECS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PRODUCT_CD | INT | PFK, NOT NULL | 상품 코드 (PFK) |
| DRINK_SIZE | VARCHAR(50) | NULL | 용량(355ml) |
| IS_ZERO | BOOLEAN | NULL | 제로 여부 |
| DRINK_CONTAINER | VARCHAR(50) | NULL | CUP/CAN/PET |
| DRINK_MEMO | VARCHAR(50) | NULL | 비고 |

#### TBL_PRODUCTS_FOOD_SPECS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PRODUCT_CD | INT | PFK, NOT NULL | 상품 코드 (PFK) |
| FOOD_TASTE | VARCHAR(50) | NULL | 맛 |
| FOOD_SIZE | VARCHAR(50) | NULL | 사이즈 |
| FOOD_WEIGHT | VARCHAR(50) | NULL | 중량/용량 |

#### TBL_PRODUCTS_GOODS_SPECS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PRODUCT_CD | INT | PFK, NOT NULL | 상품 코드 (PFK) |
| GOODS_COMPS | VARCHAR(255) | NULL | 구성품 |
| GOODS_MATS | VARCHAR(255) | NULL | 재질 |
| GOODS_SIZE | VARCHAR(255) | NULL | 크기 |
| GOODS_REG_DTTM | DATETIME | NULL | 출시일 |

#### TBL_VARIANT_SALE_GB
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| VARIANT_SALE_GB | INT | PK, NOT NULL, AUTO_INCREMENT | 판매 구분 |
| VARIANT_SALE_GB_NM | VARCHAR(255) | NOT NULL | 판매 구분 이름(판매중/품절/판매종료) |

#### TBL_PRODUCT_VARIANTS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| VARIANT_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 상품 옵션 코드 (PK) |
| PRODUCT_CD | INT | FK, NOT NULL | 상품 코드 (FK) |
| VARIANT_SALE_GB | INT | FK, NOT NULL | 판매 구분(FK) |
| VARIANT_NM | VARCHAR(255) | NOT NULL | 옵션 조합명 |
| VARIANT_ADD_PRICE_AMT | INT | NOT NULL, DEFAULT 0 | 추가 가격 |
| VARIANT_STOCK_CNT | INT | NOT NULL, DEFAULT 0 | 옵션별 재고 수량 |
| VARIANT_GUMAE_LIMIT | INT | NULL, DEFAULT 1 | 1인당 구매 가능 수 |

### 10-3. 주문 및 결제
#### TBL_ORDERS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| ORDER_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 주문 코드(PK) |
| USER_CD | INT | FK, NOT NULL | 회원 코드 (FK) |
| PRODUCT_TYPE_CD | INT | FK, NOT NULL | 상품 타입 코드 (FK) |
| COUPON_CD | INT | FK, NULL | 적용된 쿠폰 코드 (FK) |
| ORDER_TOTAL_PRICE_AMT | INT | NOT NULL | 총 결제금액 |
| ORDER_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 주문일시 |

#### TBL_ORDER_DETAILS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| ORDER_CD | INT | PFK, NOT NULL | 주문 코드 (PFK) |
| VARIANT_CD | INT | FK, NOT NULL | 상품 옵션 코드 (FK) |
| ORD_DETL_QTY_CNT | INT | NOT NULL | 주문 수량 |
| ORD_DETL_PRICE_AMT | INT | NOT NULL | 개당 가격 |

#### TBL_ORDER_HISTORY
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| ORD_HIST_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 주문 이력 코드 (PK) |
| ORDER_CD | INT | FK, NOT NULL | 주문 코드(FK) |
| ORD_HIST_ST | VARCHAR(30) | NOT NULL | 변경된 주문 상태 |
| ORD_HIST_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 상태 변경일시 |
| ORD_HIST_REASON | VARCHAR(255) | NULL | 변경 사유 |

#### TBL_ST_PHY
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| ST_PHY_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 실물 배송 상태 코드(PK) |
| ST_PHY_NM | VARCHAR(50) | NOT NULL, DEFAULT '결제완료' | 결제완료/준비중/배송출발/배송중/배송완료 |

#### TBL_DELIVERY_PHY
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| DELIVERY_PHY_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 실물 배송 코드(PK) |
| ST_PHY_CD | INT | FK, NOT NULL, DEFAULT 1 | 실물 주문 상태 코드(FK) |
| SHIPPING_CO_NM | VARCHAR(50) | NULL | 배송사명 |
| TRACKING_NO | VARCHAR(100) | NULL | 운송장 번호 |

#### TBL_ORDER_PHY
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| ORDER_CD | INT | PFK, NOT NULL | 주문 코드(PFK) |
| DELIVERY_PHY_CD | INT | FK, NOT NULL | 실물 배송 코드(FK) |
| RECIPIENT_NM | VARCHAR(50) | NULL | 수취인 이름 |
| RECIPIENT_TEL_NO | VARCHAR(20) | NULL | 수취인 연락처 |
| SHIPPING_UPYEON | VARCHAR(10) | NULL | 배송 우편번호 |
| SHIPPING_JUSO | VARCHAR(255) | NULL | 배송 주소 |
| SHIPPING_JUSO_D | VARCHAR(255) | NULL | 배송 상세주소 |

#### TBL_GFC_SEND_ST
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| GFC_SEND_ST_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 기프티콘 발송 상태 코드(PK) |
| GFC_SEND_ST_NM | VARCHAR(50) | NOT NULL, DEFAULT '결제완료' | 결제완료/발송대기/발송완료/발송실패 |

#### TBL_GFC_SEND_TYPE
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| GFC_SEND_TYPE_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 기프티콘 발송 방법 코드(PK) |
| GFC_SEND_TYPE_NM | VARCHAR(50) | NOT NULL | SMS/MMS/EMAIL |

#### TBL_GFC_SEND
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| GFC_SEND_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 기프티콘 발송 코드 (PK) |
| GFC_SEND_ST_CD | INT | FK, NULL | 기프티콘 발송 상태 코드(FK) |
| GFC_SEND_TYPE_CD | INT | FK, NOT NULL | 기프티콘 발송 타입 코드(FK) |
| SEND_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 생성일시 |
| FAIL_REASON | VARCHAR(255) | NULL | 실패 사유 |
| SENT_DTTM | DATETIME | NULL | 발송 완료 일시 |

#### TBL_GFC_ORDER
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| ORDER_CD | INT | PFK, NOT NULL | 주문 코드(PFK) |
| GFC_SEND_CD | INT | FK, NOT NULL | 기프티콘 발송 코드 (FK) |
| RECIPT_TEL | VARCHAR(20) | NULL | 수령자 연락처 |
| RECIPT_EMAIL | VARCHAR(50) | NULL | 수령자 이메일 |

#### TBL_CARTS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| USER_CD | INT | PFK, NOT NULL | 회원 코드 (PFK) |
| VARIANT_CD | INT | PFK, NOT NULL | 상품 옵션 코드 (PFK) |
| CART_QTY_CNT | INT | NOT NULL | 수량 |
| CART_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 추가된 일시 |

### 10-4. 커뮤니티
#### TBL_POST_CATEGORIES
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| POST_CTGRY_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 게시글 카테고리 코드 (PK) |
| POST_CTGRY_NM | VARCHAR(50) | NOT NULL | 게시글 카테고리명 (한글) |

#### TBL_POSTS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| POST_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 게시글 코드 (PK) |
| USER_CD | INT | FK, NULL | 회원 코드 (FK), 탈퇴 시 NULL |
| POST_CTGRY_CD | INT | FK, NOT NULL | 게시글 카테고리 코드 (FK) |
| POST_TT | VARCHAR(255) | NOT NULL | 게시글 제목 |
| POST_CONT | VARCHAR(1000) | NOT NULL | 게시글 내용 |
| POST_VIEW_CNT | INT | NOT NULL, DEFAULT 0 | 게시글 조회수 |
| POST_LIKE_CNT | INT | NOT NULL, DEFAULT 0 | 게시글 추천 수 |
| POST_DISLIKE_CNT | INT | NOT NULL, DEFAULT 0 | 게시글 비추천 수 |
| POST_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 게시글 작성일시 |
| POST_MOD_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 게시글 수정일시 |

#### TBL_COMMENT
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| COMMENT_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 댓글 코드 (PK) |
| USER_CD | INT | FK, NULL | 회원 코드 (FK), 탈퇴 시 NULL |
| POST_CD | INT | FK, NOT NULL | 게시글 코드 (FK) |
| COMMENT_CONT | VARCHAR(1000) | NOT NULL | 댓글내용 |
| COMMENT_ST | INT | NOT NULL, DEFAULT 1 | 댓글 상태(1= ACTIVE, 0=DELTED) |
| COMMENT_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 댓글 작성일시 |
| COMMENT_MOD_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 댓글 수정일시 |

#### TBL_POST_IMAGES
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| POST_IMAGE_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 게시글 이미지 코드 (PK) |
| POST_CD | INT | FK, NOT NULL | 게시글 코드 (FK) |
| IMG_URL | VARCHAR(255) | NOT NULL | 이미지 저장 URL |
| UPLOAD_ORD | INT | NOT NULL | 이미지 표시 순서 |

### 10-5. 프로모션 및 CS
#### TBL_COUPON_DISCOUNT_GB
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| DISCOUNT_GB | INT | PK, NOT NULL, AUTO_INCREMENT | 할인 구분 |
| DISCOUNT_VAL | INT | NOT NULL | 할인 데이터 |

#### TBL_COUPONS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| COUPON_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 쿠폰 코드 (PK) |
| DISCOUNT_GB | INT | FK, NULL | 할인 구분 코드 (FK) |
| COUPON_NM | VARCHAR(100) | NOT NULL | 쿠폰 이름 |
| VALID_START_DTTM | DATETIME | NOT NULL | 유효 시작일시 |
| VALID_END_DTTM | DATETIME | NOT NULL | 유효 종료일시 |
| ACTIVE_FG | INT | NOT NULL, DEFAULT 1 | 활성 여부 플래그 |

#### TBL_USER_COUPONS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| USER_COUPON_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 회원 보유 쿠폰 코드 (PK) |
| USER_CD | INT | FK, NOT NULL | 회원 코드 (FK) |
| COUPON_CD | INT | FK, NOT NULL | 쿠폰 코드 (FK) |
| COUPON_ST | VARCHAR(20) | NOT NULL, DEFAULT 'AVAILABLE' | 쿠폰 상태 (AVAILABLE, USED, EXPIRED) |
| ISSUE_DTTM | DATETIME | NOT NULL | 발급일시 |
| EXPIRE_DTTM | DATETIME | NOT NULL | 만료일시 |

#### TBL_NOTIFICATIONS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| NOTI_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 알림 코드 (PK) |
| USER_CD | INT | FK, NOT NULL | 수신자 회원 코드 (FK) |
| NOTI_CONT | VARCHAR(1000) | NOT NULL | 알림 내용 |
| READ_FG | INT | NOT NULL, DEFAULT 0 | 읽음 여부 플래그 (0/1) |
| NOTI_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 생성일시 |

#### TBL_INQUIRIES
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| INQUIRY_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 문의 코드 (PK) |
| USER_CD | INT | FK, NULL | 작성자 회원 코드 (FK), 탈퇴 시 NULL |
| INQUIRY_TT | VARCHAR(255) | NOT NULL | 문의 제목 |
| INQUIRY_CONT | VARCHAR(1000) | NOT NULL | 문의 내용 |
| ANSWER_FG | INT | NOT NULL, DEFAULT 0 | 답변 상태 (0, 1) |
| INQUIRY_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 문의 등록일시 |
| INQUIRY_MOD_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 문의 수정일시 |
| ANSWER_CONT | VARCHAR(1000) | NULL | 관리자 답변 내용 |
| ANSWERED_DTTM | DATETIME | NULL | 답변 완료일시 |

#### TBL_REPORT_GB
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| REPORT_GB | INT | PK, NOT NULL, AUTO_INCREMENT | 신고 구분 코드 (PK) |
| REPORT_GB_NM | VARCHAR(50) | NOT NULL | 신고 구분명 (한글) 게시글/댓글/리뷰 |

#### TBL_REPORTS
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| REPORT_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 신고 코드 (PK) |
| REPORT_GB | INT | FK, NOT NULL | 신고 구분 코드 (FK) |
| REPORT_USER_CD | INT | FK, NULL | 신고자 코드, 탈퇴 시 NULL |
| TARGET_USER_CD | INT | FK, NULL | 신고 대상자 코드, 탈퇴 시 NULL |
| REPORT_REASON | VARCHAR(255) | NOT NULL | 신고 사유 |
| REPORT_ST | INT | NOT NULL, DEFAULT 0 | 처리 상태 |
| REPORT_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 신고일시 |

### 10-6. 영화 정보
#### TBL_MOVIES
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| MOVIE_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 영화 코드 (PK) |
| MOVIE_NM | VARCHAR(255) | NOT NULL | 영화 제목 |
| MOVIE_REG_DTTM | DATETIME | NOT NULL, DEFAULT NOW() | 데이터 등록일시 |
| MOVIE_OVERVIEW | VARCHAR(1000) | NOT NULL | 줄거리 |
| RELEASE_DT | DATE | NULL | 개봉일 |
| RUNTIME | INT | NULL | 런타임 (분 단위) |
| POSTER_URL | VARCHAR(255) | NULL | 포스터 이미지 URL |

#### TBL_GENRES
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| GENRE_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 장르 코드 (PK) |
| GENRE_NM | VARCHAR(50) | NOT NULL | 장르명 (한글) |

#### TBL_MOVIE_GENRES
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| GENRE_CD | INT | PFK, NOT NULL | 장르 코드 (PK, FK) |
| MOVIE_CD | INT | PFK, NOT NULL | 영화 코드 (PK, FK) |

#### TBL_PEOPLE
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PERSON_CD | INT | PK, NOT NULL, AUTO_INCREMENT | 인물 코드 (PK) |
| PERSON_NM | VARCHAR(100) | NOT NULL | 인물명 |
| PROFILE_URL | VARCHAR(255) | NULL | 프로필 이미지 URL |

#### TBL_MOVIE_CAST
| 컬럼명 | 데이터 타입 | 제약 조건 | 설명 |
|---|---|---|---|
| PERSON_CD | INT | PFK, NOT NULL | 인물 코드 (PK, FK) |
| MOVIE_CD | INT | PFK, NOT NULL | 영화 코드 (PK, FK) |
| ROLE_NM | VARCHAR(50) | NOT NULL | 역할 (감독, 주연, 조연) |
| CHARACTER_NM | VARCHAR(50) | NOT NULL | 극중 배역 이름 |

---

## ✅ 11. 테스트 케이스 (Test Cases)
주요 기능에 대한 테스트 케이스를 명시합니다.

---

<div align="center">
  <img src="./img/cinefive_bgx.png" alt="시네파이브 투명배경 로고" width="300" />
  <br>
  <p>© 2025 CINEFIVE Project. All Rights Reserved.</p>
</div>
