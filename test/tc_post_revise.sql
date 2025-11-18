/*
사용자 $\text{B}$가 다른 사용자 $\text{A}$가 작성한 게시글 $\text{X}$에 접근하여 수정 시도
*/

-- 1. TBL_USERS 데이터 삽입 (사용자 A, B 생성)
-- 사용자 A (게시글 원 작성자)
INSERT INTO TBL_USERS (USER_CD, USER_ID, USER_PW, USER_NICK_NM, USER_EMAIL) VALUES
(100, 'userA', 'hashed_pw_A', 'OriginalWriterA', 'a@test.com');

-- 사용자 B (게시글 수정 시도자)
INSERT INTO TBL_USERS (USER_CD, USER_ID, USER_PW, USER_NICK_NM, USER_EMAIL) VALUES
(200, 'userB', 'hashed_pw_B', 'AttempterB', 'b@test.com');

SELECT * FROM TBL_USERS;

-- 2. TBL_POST_CATEGORIES 데이터 삽입 (카테고리 생성) // 자유 게시판, 영화 리뷰, 스포일러
INSERT INTO TBL_POST_CATEGORIES (POST_CTGRY_CD, POST_CTGRY_NM) VALUES
(1, '자유 게시판'),
(2, '영화 리뷰'),
(3, '스포일러');

SELECT * FROM TBL_POST_CATEGORIES;

-- 3. TBL_POSTS 데이터 삽입 (userA가 게시글 X 생성)
INSERT INTO TBL_POSTS (POST_CD, USER_CD, POST_CTGRY_CD, POST_TT, POST_CONT, POST_REG_DTTM) VALUES
(500, 100, 1, '사용자 A의 제목입니다.', '이 게시글은 사용자 A만 수정할 수 있습니다.', NOW());

-- 시뮬레이션
-- 사용자 B가 사용자 A의 게시글 X를 수정하려는 쿼리 (실제 구현에서는 실행되지 않아야 함)
UPDATE TBL_POSTS
SET POST_CONT = '사용자 B가 무단으로 수정을 시도한 내용입니다.',
    POST_MOD_DTTM = NOW()
WHERE POST_CD = 500  -- 게시글 X
  AND USER_CD = 200; -- 요청자 B의 ID (이 조건 때문에 업데이트는 0행에 영향을 줌)

SELECT P.POST_CD, U.USER_NICK_NM, P.POST_TT, P.POST_CTGRY_CD, P.POST_REG_DTTM, P.POST_VIEW_CNT,
        (P.POST_LIKE_CNT - P.POST_DISLIKE_CNT) AS 'Like'
FROM TBL_POSTS P
INNER JOIN TBL_USERS U ON (P.USER_CD = U.USER_CD);

/*
사용자 $\text{A}$가 본인이 작성한 게시글 $\text{X}$에 접근하여 수정 시도.
*/
UPDATE TBL_POSTS
SET POST_CONT = '사용자 A가 수정을 시도하여 변경된 내용입니다.',
    POST_MOD_DTTM = NOW()
WHERE POST_CD = 500  -- 게시글 X
  AND USER_CD = 100; -- 요청자 A의 ID

-- 변경 내용 확인
-- 1. 게시글 상세 정보 (1건)
SELECT
    P.POST_CD,
    U.USER_NICK_NM,
    P.POST_TT,
    P.POST_CONT,         -- 게시글 내용을 출력하기 위해 추가
    P.POST_REG_DTTM,
    P.POST_VIEW_CNT,
    (P.POST_LIKE_CNT - P.POST_DISLIKE_CNT) AS `NetLike`
FROM
    TBL_POSTS P
INNER JOIN
    TBL_USERS U
    ON P.USER_CD = U.USER_CD
WHERE
    P.POST_CD = 500;


SELECT * FROM TBL_POST_CATEGORIES;

DELETE FROM TBL_POST_CATEGORIES;

