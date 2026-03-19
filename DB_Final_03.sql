USE db4;

DROP TABLE IF EXISTS 판단;
DROP TABLE IF EXISTS 구성;
DROP TABLE IF EXISTS 구상;
DROP TABLE IF EXISTS 작성;
DROP TABLE IF EXISTS 호환성;
DROP TABLE IF EXISTS 부품;
DROP TABLE IF EXISTS 공유;
DROP TABLE IF EXISTS 견적;
DROP TABLE IF EXISTS 게시글;
DROP TABLE IF EXISTS 사용자;


-- 사용자 테이블
CREATE TABLE 사용자 (
    사용자ID     VARCHAR(20) NOT NULL,
    비밀번호     VARCHAR(50) NOT NULL,
    이름         VARCHAR(10) NOT NULL,
    나이         INT         NOT NULL,
    번호         VARCHAR(15),
    사용자유형    VARCHAR(10) DEFAULT '일반',
    PRIMARY KEY (사용자ID)
);

-- 게시글 테이블
CREATE TABLE 게시글 (
    게시글ID    CHAR(5)       NOT NULL,
    게시글유형  VARCHAR(30),
    작성자      VARCHAR(20)   NOT NULL,
    제목        VARCHAR(100)  NOT NULL,
    내용        TEXT,
    조회수      INT,
    좋아요수    INT,
    PRIMARY KEY (게시글ID),
    FOREIGN KEY (작성자) REFERENCES 사용자(사용자ID) 
);

-- 견적 테이블
CREATE TABLE 견적 (
    견적ID     CHAR(5)    NOT NULL,
    작성자     VARCHAR(20),
    총가격     INT,
    작성날짜   DATE,
    설명       TEXT,
    PRIMARY KEY(견적ID),
    FOREIGN KEY(작성자) REFERENCES 사용자(사용자ID)
);

-- 부품 테이블
CREATE TABLE 부품(
    부품ID     CHAR(5)      NOT NULL,
    카테고리   VARCHAR(10)  NOT NULL,
    제조사     VARCHAR(20)  NOT NULL,
    품명       VARCHAR(50)  NOT NULL,
    가격       DECIMAL(10,2),
    소켓타입   VARCHAR(20),
    RAM타입    VARCHAR(20),
    전력요구량 INT,
    PRIMARY KEY(부품ID)
);

-- 호환성 테이블
CREATE TABLE 호환성(
    호환성ID  CHAR(5)   NOT NULL,
    부품1     CHAR(5)   NOT NULL,
    부품2     CHAR(5)   NOT NULL,
    호환여부   BOOLEAN,
    설명       TEXT,
    PRIMARY KEY(호환성ID),
    FOREIGN KEY(부품1) REFERENCES 부품(부품ID),
    FOREIGN KEY(부품2) REFERENCES 부품(부품ID)
);

-- 작성 테이블
CREATE TABLE 작성(
    작성자    VARCHAR(20) NOT NULL,
    게시글    CHAR(5)     NOT NULL,
    작성IP    INT         NOT NULL,
    작성일자  DATE,
    FOREIGN KEY(작성자) REFERENCES 사용자(사용자ID),
    FOREIGN KEY(게시글) REFERENCES 게시글(게시글ID)
);

CREATE TABLE 공유 (
    공유ID    CHAR(5)     NOT NULL,
    공유자    VARCHAR(20) NOT NULL,
    수신자    VARCHAR(20) NOT NULL,
    견적      CHAR(5)     NOT NULL,
    공유일자  DATE,
    PRIMARY KEY(공유ID),
    FOREIGN KEY(공유자) REFERENCES 사용자(사용자ID),
    FOREIGN KEY(수신자) REFERENCES 사용자(사용자ID),
    FOREIGN KEY(견적)   REFERENCES 견적(견적ID)
);

-- 구상 테이블
CREATE TABLE 구상(
    구상ID    CHAR(5)     NOT NULL,
    작성자    VARCHAR(20) NOT NULL,
    견적      CHAR(5)     NOT NULL,
    PRIMARY KEY (구상ID),
    FOREIGN KEY(작성자) REFERENCES 사용자(사용자ID),
    FOREIGN KEY(견적) REFERENCES 견적(견적ID)
);

-- 구성 테이블
CREATE TABLE 구성(
    구성ID   CHAR(5)     NOT NULL,
    견적     CHAR(5)     NOT NULL,
    구성부품 CHAR(5)     NOT NULL,
    부품수량 INT,
    PRIMARY KEY (구성ID),
    FOREIGN KEY(견적) REFERENCES 견적(견적ID),
    FOREIGN KEY(구성부품) REFERENCES 부품(부품ID)
);

-- 판단 테이블
CREATE TABLE 판단(
    판단ID     CHAR(5)     NOT NULL,
    호환성ID   CHAR(5)     NOT NULL,
    부품1      CHAR(5)     NOT NULL,
    부품2      CHAR(5)     NOT NULL,
    호환상태    VARCHAR(10) NOT NULL,
    판단기준    VARCHAR(30),
    부품1값     VARCHAR(20),
    부품2값     VARCHAR(20),
    판단이유     TEXT,
    PRIMARY KEY (판단ID),
    FOREIGN KEY(호환성ID) REFERENCES 호환성(호환성ID),
    FOREIGN KEY(부품1) REFERENCES 부품(부품ID),
    FOREIGN KEY(부품2) REFERENCES 부품(부품ID)
);

--------------------------------------------
-- 데이터 삽입
--------------------------------------------

-- 사용자
INSERT INTO 사용자(사용자ID, 비밀번호, 이름, 나이, 번호, 사용자유형) VALUES
('use01','pw_use01','성현우',20,'db_001','관리자'),
('use02','pw_use02','서은현',20,'db_002','관리자'),
('use03','pw_use03','이재은',20,'db_003','일반'),
('use04','pw_use04','이효정',15,'db_004','일반'),
('use05','pw_use05','김혜윤',28,'db_005','일반'),
('use06','pw_use06','김가영',22,'db_006','일반'),
('use07','pw_use07','박영준',26,'db_007','일반'),
('use08','pw_use08','최우준',20,'db_008','일반'),
('use09','pw_use09','박지연',37,'db_009','일반'),
('use10','pw_use10','김광희',27,'db_010','일반');

-- 게시글
INSERT INTO 게시글 VALUES
('P01', '공지사항', 'use01', '서버 점검 안내', '내일 새벽 2시부터 5시까지 서버 점검이 진행됩니다.', 110, 60),
('P02', '자유게시판', 'use03', 'CPU 온도 문제 해결 방법', '게임 중 CPU 온도가 90도를 넘습니다.', 85, 15),
('P03', '자유게시판', 'use05', '파워 서플라이 추천', 'RTX 4090에 적합한 파워 서플라이?', 77, 12),
('P04', '자유게시판', 'use04', '최신 GPU 성능 리뷰', 'RTX 4090과 RX 7900 XTX 성능 비교', 55, 20),
('P05', '자유게시판', 'use05', '조립 PC 구성 후기', '새로 조립한 게이밍 PC입니다. 최고예요!', 25, 11),
('P06', '질문', 'use07', 'PC 전원 문제', '컴퓨터 전원이 가끔 안 켜집니다. 원인이 뭘까요?', 13, 2),
('P07', '질문', 'use07', 'SSD 인식 오류', '새 SSD를 설치했는데 BIOS에서 인식이 안 됩니다.', 11, 1),
('P08', '질문', 'use08', '게이밍 메인보드 추천', '고급형 메인보드 중에서 어떤 걸 사야 할까요?', 21, 3),
('P09', '질문', 'use09', '부팅 속도 느림', '윈도우 부팅 속도가 너무 느려요. 해결 방법 있을까요?', 9, 0),
('P10', '자유게시판', 'use10', '가성비 메모리 추천', 'Corsair Vengeance 메모리 사용 후기입니다.', 25, 5);

-- 견적
INSERT INTO 견적(견적ID, 작성자, 총가격, 작성날짜, 설명) VALUES
('E001', 'use03', 1500000, '2024-12-01', '게이밍 PC 구성'),
('E002', 'use03', 980000,  '2024-12-02', '사무용	 PC 구성'),
('E003', 'use04', 2100000, '2024-12-03', '전문 디자인용 PC 구성'),
('E004', 'use05', 1250000, '2024-12-03', '영상편집용 PC 구성'),
('E005', 'use07', 1180000, '2024-12-04', '게이밍 PC 구성'),
('E006', 'use07', 2500000, '2024-12-05', '게이밍 PC 구성'),
('E007', 'use07', 1590000, '2024-12-06', '방송용 PC 구성'),
('E008', 'use08',  880000, '2024-12-01', '개발용 PC 구성'),
('E009', 'use10', 1080000, '2024-12-02', '영상편집용 PC 구성'),
('E010', 'use10',  780000, '2024-12-03', '사무용 PC 구성');

-- 부품
INSERT INTO 부품 VALUES
('PA01','CPU', 'Intel', 'Intel Core i5-13600K', 300.00, 'LGA1700', NULL, 125),
('PA02','CPU', 'AMD',   'AMD Ryzen 7 5800X',    290.00, 'AM4',     NULL, 105),
('PA03','CPU', 'Intel', 'Intel Core i9-13900K', 649.00, 'LGA1700', NULL, 125),
('PA04','CPU', 'AMD',   'AMD Ryzen 9 7900X',    599.00, 'AM5',     NULL, 170),
('PA05','GPU', 'ASUS',  'NVIDIA RTX 4090',     1600.00, NULL,      NULL, 450),
('PA06','GPU', 'AMD',   'AMD Radeon RX 6700 XT',700.00, NULL,      NULL, 230),
('PA07','GPU', 'MSI',   'MSI GeForce RTX 4070 Ti',799.00,NULL,      NULL, 285),
('PA08','GPU', 'Gigabyte','Gigabyte RX 7900 XTX',999.00,NULL,      NULL, 355),
('PA09','메인보드','ASUS','ASUS ROG STRIX Z790-E',400.00,'LGA1700','DDR5',NULL),
('PA10','메인보드','MSI','MSI B450 TOMAHAWK MAX',150.00,'AM4','DDR4',NULL),
('PA11','메인보드','MSI','MSI B650 TOMAHAWK',    250.00,'AM5','DDR5',NULL),
('PA12','RAM','OLOy','OLOy DDR5-6000 CL32 BLADE RGB',200.00,NULL,'DDR5',NULL),
('PA13','RAM','SK하이닉스','SK하이닉스 DDR5-5600 16GB',88.00,NULL,'DDR5',NULL),
('PA14','RAM','ESSENCORE','ESSENCORE KLEVV DDR5-6000 32GB',166.00,NULL,'DDR5',NULL),
('PA15','RAM','Samsung','Samsung DDR4-3200 16GB',43.00,NULL,'DDR4',NULL);

-- 호환성(소켓 타입 / RAM 타입 / 전력 요구량) 
-- 소켓 호환 (Co001~Co012)
INSERT INTO 호환성 VALUES ('Co001','PA01','PA09',TRUE ,'소켓 타입 호환(LGA1700)');
INSERT INTO 호환성 VALUES ('Co002','PA01','PA10',FALSE,'소켓 타입 불일치(LGA1700 vs AM4)');
INSERT INTO 호환성 VALUES ('Co003','PA01','PA11',FALSE,'소켓 타입 불일치(LGA1700 vs AM5)');
INSERT INTO 호환성 VALUES ('Co004','PA02','PA09',FALSE,'소켓 타입 불일치(AM4 vs LGA1700)');
INSERT INTO 호환성 VALUES ('Co005','PA02','PA10',TRUE ,'소켓 타입 호환(AM4)');
INSERT INTO 호환성 VALUES ('Co006','PA02','PA11',FALSE,'소켓 타입 불일치(AM4 vs AM5)');
INSERT INTO 호환성 VALUES ('Co007','PA03','PA09',TRUE ,'소켓 타입 호환(LGA1700)');
INSERT INTO 호환성 VALUES ('Co008','PA03','PA10',FALSE,'소켓 타입 불일치(LGA1700 vs AM4)');
INSERT INTO 호환성 VALUES ('Co009','PA03','PA11',FALSE,'소켓 타입 불일치(LGA1700 vs AM5)');
INSERT INTO 호환성 VALUES ('Co010','PA04','PA09',FALSE,'소켓 타입 불일치(AM5 vs LGA1700)');
INSERT INTO 호환성 VALUES ('Co011','PA04','PA10',FALSE,'소켓 타입 불일치(AM5 vs AM4)');
INSERT INTO 호환성 VALUES ('Co012','PA04','PA11',TRUE ,'소켓 타입 호환(AM5)');

-- RAM 타입 호환 (Co013~Co024)
INSERT INTO 호환성 VALUES ('Co013','PA12','PA09',TRUE ,'RAM 타입 호환(DDR5)');
INSERT INTO 호환성 VALUES ('Co014','PA12','PA10',FALSE,'RAM 타입 불일치(DDR5 vs DDR4)');
INSERT INTO 호환성 VALUES ('Co015','PA12','PA11',TRUE ,'RAM 타입 호환(DDR5)');
INSERT INTO 호환성 VALUES ('Co016','PA13','PA09',TRUE ,'RAM 타입 호환(DDR5)');
INSERT INTO 호환성 VALUES ('Co017','PA13','PA10',FALSE,'RAM 타입 불일치(DDR5 vs DDR4)');
INSERT INTO 호환성 VALUES ('Co018','PA13','PA11',TRUE ,'RAM 타입 호환(DDR5)');
INSERT INTO 호환성 VALUES ('Co019','PA14','PA09',TRUE ,'RAM 타입 호환(DDR5)');
INSERT INTO 호환성 VALUES ('Co020','PA14','PA10',FALSE,'RAM 타입 불일치(DDR5 vs DDR4)');
INSERT INTO 호환성 VALUES ('Co021','PA14','PA11',TRUE ,'RAM 타입 호환(DDR5)');
INSERT INTO 호환성 VALUES ('Co022','PA15','PA09',FALSE,'RAM 타입 불일치(DDR4 vs DDR5)');
INSERT INTO 호환성 VALUES ('Co023','PA15','PA10',TRUE ,'RAM 타입 호환(DDR4)');
INSERT INTO 호환성 VALUES ('Co024','PA15','PA11',FALSE,'RAM 타입 불일치(DDR4 vs DDR5)');

-- 전력 요구량 호환 (Co025~Co036)
INSERT INTO 호환성 VALUES ('Co025','PA01','PA09',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co026','PA01','PA10',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co027','PA01','PA11',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co028','PA02','PA09',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co029','PA02','PA10',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co030','PA02','PA11',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co031','PA03','PA09',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co032','PA03','PA10',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co033','PA03','PA11',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co034','PA04','PA09',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co035','PA04','PA10',TRUE ,'전력 요구량 호환');
INSERT INTO 호환성 VALUES ('Co036','PA04','PA11',TRUE ,'전력 요구량 호환');

-- 작성
INSERT INTO 작성 (작성자, 게시글, 작성IP, 작성일자) VALUES
('use01','P01', 123456, '2024-12-01'),
('use03','P02', 234567, '2024-12-02'),
('use05','P03', 345678, '2024-12-03'),
('use04','P04', 456789, '2024-12-04'),
('use05','P05', 567890, '2024-12-05'),
('use07','P06', 678901, '2024-12-06'),
('use07','P07', 789012, '2024-12-07'),
('use08','P08', 890123, '2024-12-08'),
('use09','P09', 901234, '2024-12-09'),
('use10','P10', 123450, '2024-12-10');

-- 공유 테이블에 10개의 데이터 삽입
INSERT INTO 공유 VALUES
('S001', 'use03', 'use05', 'E001', '2024-12-10'),
('S002', 'use03', 'use01', 'E002', '2024-12-11'),
('S003', 'use04', 'use02', 'E003', '2024-12-12'),
('S004', 'use05', 'use10', 'E004', '2024-12-13'),
('S005', 'use07', 'use09', 'E005', '2024-12-14'),
('S006', 'use07', 'use03', 'E006', '2024-12-15'),
('S007', 'use07', 'use08', 'E007', '2024-12-16'),
('S008', 'use08', 'use04', 'E008', '2024-12-17'),
('S009', 'use10', 'use07', 'E009', '2024-12-18'),
('S010', 'use10', 'use06', 'E010', '2024-12-19');

-- 구상
INSERT INTO 구상 VALUES
('I001', 'use03', 'E001'),
('I002', 'use03', 'E002'),
('I003', 'use04', 'E003'),
('I004', 'use05', 'E004'),
('I005', 'use07', 'E005'),
('I006', 'use07', 'E006'),
('I007', 'use07', 'E007'),
('I008', 'use08', 'E008'),
('I009', 'use10', 'E009'),
('I010', 'use10', 'E010');

-- 구성 (각 견적마다 CPU, GPU, MB, RAM 구성을 모두 삽입)
-- E001: CPU:PA01(LGA1700), MB:PA09(LGA1700,DDR5), RAM:PA12(DDR5), GPU:PA07
INSERT INTO 구성 VALUES
('C001', 'E001', 'PA01', 1),
('C002', 'E001', 'PA07', 1),
('C003', 'E001', 'PA09', 1),
('C004', 'E001', 'PA12', 2);

-- E002: CPU:PA02(AM4), MB:PA10(AM4,DDR4), RAM:PA15(DDR4), GPU:PA06
INSERT INTO 구성 VALUES
('C005','E002','PA02',1),
('C006','E002','PA06',1),
('C007','E002','PA10',1),
('C008','E002','PA15',2);

-- E003: CPU:PA04(AM5), MB:PA11(AM5,DDR5), RAM:PA13(DDR5), GPU:PA08
INSERT INTO 구성 VALUES
('C009','E003','PA04',1),
('C010','E003','PA08',1),
('C011','E003','PA11',1),
('C012','E003','PA13',2);

-- E004: CPU:PA01(LGA1700), MB:PA09(DDR5), RAM:PA14(DDR5), GPU:PA07
INSERT INTO 구성 VALUES
('C013','E004','PA01',1),
('C014','E004','PA07',1),
('C015','E004','PA09',1),
('C016','E004','PA14',2);

-- E005: CPU:PA03(LGA1700), MB:PA09(DDR5), RAM:PA12(DDR5), GPU:PA05
INSERT INTO 구성 VALUES
('C017','E005','PA03',1),
('C018','E005','PA05',1),
('C019','E005','PA09',1),
('C020','E005','PA12',2);

-- E006: CPU:PA03(LGA1700), MB:PA09(DDR5), RAM:PA14(DDR5), GPU:PA07
INSERT INTO 구성 VALUES
('C021','E006','PA03',1),
('C022','E006','PA07',1),
('C023','E006','PA09',1),
('C024','E006','PA14',4);

-- E007: CPU:PA04(AM5), MB:PA11(DDR5), RAM:PA13(DDR5), GPU:PA08
INSERT INTO 구성 VALUES
('C025','E007','PA04',1),
('C026','E007','PA08',1),
('C027','E007','PA11',1),
('C028','E007','PA13',2);

-- E008: CPU:PA02(AM4), MB:PA10(DDR4), RAM:PA15(DDR4), GPU:PA06
INSERT INTO 구성 VALUES
('C029','E008','PA02',1),
('C030','E008','PA06',1),
('C031','E008','PA10',1),
('C032','E008','PA15',2);

-- E009: CPU:PA04(AM5), MB:PA11(DDR5), RAM:PA12(DDR5), GPU:PA08
INSERT INTO 구성 VALUES
('C033','E009','PA04',1),
('C034','E009','PA08',1),
('C035','E009','PA11',1),
('C036','E009','PA12',2);

-- E010: CPU:PA01(LGA1700), MB:PA09(DDR5), RAM:PA13(DDR5), GPU:PA05
INSERT INTO 구성 VALUES
('C037','E010','PA01',1),
('C038','E010','PA05',1),
('C039','E010','PA09',1),
('C040','E010','PA13',2);

-- 소켓 타입 판단
INSERT INTO 판단 VALUES
('J001','Co001','PA01','PA09','호환','소켓_타입','LGA1700','LGA1700','소켓 타입 일치'),
('J002','Co002','PA01','PA10','호환 불가','소켓_타입','LGA1700','AM4','소켓 타입 불일치'),
('J003','Co003','PA01','PA11','호환 불가','소켓_타입','LGA1700','AM5','소켓 타입 불일치'),
('J004','Co004','PA02','PA09','호환 불가','소켓_타입','AM4','LGA1700','소켓 타입 불일치'),
('J005','Co005','PA02','PA10','호환','소켓_타입','AM4','AM4','소켓 타입 일치'),
('J006','Co006','PA02','PA11','호환 불가','소켓_타입','AM4','AM5','소켓 타입 불일치'),
('J007','Co007','PA03','PA09','호환','소켓_타입','LGA1700','LGA1700','소켓 타입 일치'),
('J008','Co008','PA03','PA10','호환 불가','소켓_타입','LGA1700','AM4','소켓 타입 불일치'),
('J009','Co009','PA03','PA11','호환 불가','소켓_타입','LGA1700','AM5','소켓 타입 불일치'),
('J010','Co010','PA04','PA09','호환 불가','소켓_타입','AM5','LGA1700','소켓 타입 불일치'),
('J011','Co011','PA04','PA10','호환 불가','소켓_타입','AM5','AM4','소켓 타입 불일치'),
('J012','Co012','PA04','PA11','호환','소켓_타입','AM5','AM5','소켓 타입 일치');

-- RAM 타입 판단 
INSERT INTO 판단 VALUES
('J013','Co013','PA12','PA09','호환','RAM_타입','DDR5','DDR5','RAM 타입 일치'),
('J014','Co014','PA12','PA10','호환 불가','RAM_타입','DDR5','DDR4','RAM 타입 불일치'),
('J015','Co015','PA12','PA11','호환','RAM_타입','DDR5','DDR5','RAM 타입 일치'),
('J016','Co016','PA13','PA09','호환','RAM_타입','DDR5','DDR5','RAM 타입 일치'),
('J017','Co017','PA13','PA10','호환 불가','RAM_타입','DDR5','DDR4','RAM 타입 불일치'),
('J018','Co018','PA13','PA11','호환','RAM_타입','DDR5','DDR5','RAM 타입 일치'),
('J019','Co019','PA14','PA09','호환','RAM_타입','DDR5','DDR5','RAM 타입 일치'),
('J020','Co020','PA14','PA10','호환 불가','RAM_타입','DDR5','DDR4','RAM 타입 불일치'),
('J021','Co021','PA14','PA11','호환','RAM_타입','DDR5','DDR5','RAM 타입 일치'),
('J022','Co022','PA15','PA09','호환 불가','RAM_타입','DDR4','DDR5','RAM 타입 불일치'),
('J023','Co023','PA15','PA10','호환','RAM_타입','DDR4','DDR4','RAM 타입 일치'),
('J024','Co024','PA15','PA11','호환 불가','RAM_타입','DDR4','DDR5','RAM 타입 불일치');

-- 전력 요구량 판단 (Co025~Co036) 모두 호환
INSERT INTO 판단 VALUES
('J025','Co025','PA01','PA09','호환','전력_요구량','125W','OK','전력 요구량 만족'),
('J026','Co026','PA01','PA10','호환','전력_요구량','125W','OK','전력 요구량 만족'),
('J027','Co027','PA01','PA11','호환','전력_요구량','125W','OK','전력 요구량 만족'),
('J028','Co028','PA02','PA09','호환','전력_요구량','105W','OK','전력 요구량 만족'),
('J029','Co029','PA02','PA10','호환','전력_요구량','105W','OK','전력 요구량 만족'),
('J030','Co030','PA02','PA11','호환','전력_요구량','105W','OK','전력 요구량 만족'),
('J031','Co031','PA03','PA09','호환','전력_요구량','125W','OK','전력 요구량 만족'),
('J032','Co032','PA03','PA10','호환','전력_요구량','125W','OK','전력 요구량 만족'),
('J033','Co033','PA03','PA11','호환','전력_요구량','125W','OK','전력 요구량 만족'),
('J034','Co034','PA04','PA09','호환','전력_요구량','170W','OK','전력 요구량 만족'),
('J035','Co035','PA04','PA10','호환','전력_요구량','170W','OK','전력 요구량 만족'),
('J036','Co036','PA04','PA11','호환','전력_요구량','170W','OK','전력 요구량 만족');
