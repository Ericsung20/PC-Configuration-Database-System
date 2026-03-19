USE DB2;

CREATE TABLE 사용자(
	사용자ID	VARCHAR(20)	NOT NULL,
    이름		VARCHAR(10)	NOT NULL,
    나이		INT			NOT NULL,
    사용자유형	VARCHAR(20)	DEFAULT '일반',
    비밀번호	VARCHAR(20)	NOT NULL,
    PRIMARY KEY (사용자ID)
);

CREATE TABLE 게시글 (
    게시글ID	CHAR(5)		NOT NULL,
	작성자	VARCHAR(20)	NOT NULL,
    제목		VARCHAR(100)	NOT NULL,
    내용 	TEXT,
    작성일자	DATE 	NOT NULL,
    좋아요수	INT	DEFAULT 0,
    PRIMARY KEY (게시글ID),
    FOREIGN KEY (작성자) REFERENCES 사용자(사용자ID) 
);

    
CREATE TABLE 견적(
	견적ID	CHAR(5)	NOT NULL,
    제작자	VARCHAR(20),
    총가격	INT,
    제작날짜	DATE,
	설명		TEXT,
    PRIMARY KEY(견적ID),
    FOREIGN KEY(제작자)	REFERENCES 사용자(사용자ID)
);

CREATE TABLE 제조사(
	제조사ID	CHAR(5)		NOT NULL,
    이름		VARCHAR(50)	NOT NULL,
    국가		VARCHAR(20),
    설명		TEXT,
    사이트	VARCHAR(100),
    PRIMARY KEY(제조사ID)
);

CREATE TABLE 카테고리(
	카테고리ID	CHAR(5)	NOT NULL,
	이름		VARCHAR(20)	NOT NULL,
    설명		TEXT,
    PRIMARY KEY(카테고리ID)
);


CREATE TABLE 부품(
	부품ID	CHAR(5)	NOT NULL,
    카테고리	CHAR(5)	NOT NULL,
    제조사	CHAR(5)	NOT NULL,
    품목		VARCHAR(100)	NOT NULL,
    가격		INT		NOT NULL,
    소켓타입	VARCHAR(50),
    RAM타입	VARCHAR(10),
    전력요구량	INT,
	PCIe버전 VARCHAR(10),
    PRIMARY KEY(부품ID),
	FOREIGN KEY(카테고리)	REFERENCES 카테고리(카테고리ID),
	FOREIGN KEY(제조사)	REFERENCES 제조사(제조사ID)
);

CREATE TABLE 호환성(
	호환성ID	CHAR(5)	NOT NULL,
    부품1	CHAR(5)	NOT NULL,
    부품2	CHAR(5)	NOT NULL,
    체크기준	VARCHAR(30)	NOT NULL,
    부품1값	VARCHAR(30)	NOT NULL,
    부품2값	VARCHAR(30)	NOT NULL,
    호환여부	BOOLEAN		NOT NULL,
    PRIMARY KEY (호환성ID),
    FOREIGN KEY (부품1)	REFERENCES 부품(부품ID),
    foreign KEY	(부품2)	REFERENCES 부품(부품ID)
);

INSERT INTO 사용자 VALUES ('use01', '성현우', 20, '관리자', 'db_001');
INSERT INTO 사용자 VALUES ('use02', '서은현', 20, '관리자', 'db_002');
INSERT INTO 사용자 VALUES ('use03', '이재은', 20, '일반', 'db_003');
INSERT INTO 사용자 VALUES ('use04', '이효정', 15, '일반', 'db_004');
INSERT INTO 사용자 VALUES ('use05', '김혜윤', 28, '일반', 'db_005');
INSERT INTO 사용자 VALUES ('use06', '김가영', 22, '일반', 'db_006');
INSERT INTO 사용자 VALUES ('use07', '박영준', 26, '일반', 'db_007');
INSERT INTO 사용자 VALUES ('use08', '최우준', 20, '일반', 'db_008');
INSERT INTO 사용자 VALUES ('use09', '박지연', 37, '일반', 'db_009');
INSERT INTO 사용자 VALUES ('use10', '김광희', 27, '일반', 'db_010');

INSERT INTO 게시글 VALUES ('Po01', 'use03', '최고의 게이밍 PC 추천', '이 PC 구성은 최상의 성능을 보장합니다.',	'2024-12-07', 15);
INSERT INTO 게시글 VALUES ('Po02', 'use03', 'CPU 온도 문제 해결 방법', '게임 중 CPU 온도가 90도를 넘습니다.', '2024-12-06', 8);
INSERT INTO 게시글 VALUES ('Po03', 'use05', '파워 서플라이 추천', 'RTX 4090에 적합한 파워 서플라이?', '2024-12-06', 12);
INSERT INTO 게시글 VALUES ('Po04', 'use04', '최신 GPU 성능 리뷰', 'RTX 4090과 RX 7900 XTX 성능 비교', '2024-12-04', 20);
INSERT INTO 게시글 VALUES ('Po05', 'use05', '조립 PC 구성 후기', '새로 조립한 게이밍 PC입니다. 최고예요!', '2024-12-03', 25);
INSERT INTO 게시글 VALUES ('Po06', 'use07', 'PC 전원 문제', '컴퓨터 전원이 가끔 안 켜집니다. 원인이 뭘까요?', '2024-12-04', 13);
INSERT INTO 게시글 VALUES ('Po07', 'use07', 'SSD 인식 오류', '새 SSD를 설치했는데 BIOS에서 인식이 안 됩니다.', '2024-12-03', 11);
INSERT INTO 게시글 VALUES ('Po08', 'use08', '게이밍 메인보드 추천', '고급형 메인보드 중에서 어떤 걸 사야 할까요?', '2024-12-01', 21);
INSERT INTO 게시글 VALUES ('Po09', 'use09', '부팅 속도 느림', '윈도우 부팅 속도가 너무 느려요. 해결 방법 있을까요?', '2024-12-02', 9);
INSERT INTO 게시글 VALUES ('Po10', 'use10', '가성비 메모리 추천', 'Corsair Vengeance 메모리 사용 후기를 공유합니다.', '2024-11-26', 25);

INSERT INTO 견적 VALUES ('E001', 'use03', '2024-12-10', '1,500,000', '게이밍 PC 구성');
INSERT INTO 견적 VALUES ('E002', 'use03', '2024-12-09', '980,000', '사무용 PC 구성');
INSERT INTO 견적 VALUES ('E003', 'use04', '2024-12-14', '2,100,000', '전문 디자인용 PC 구성');
INSERT INTO 견적 VALUES ('E004', 'use05', '2024-12-13', '1,250,000', '영상편집용 PC 구성');
INSERT INTO 견적 VALUES ('E005', 'use07', '2024-12-19', '1,180,000', '게이밍 PC 구성');
INSERT INTO 견적 VALUES ('E006', 'use07', '2024-11-29', '2,500,000', '게이밍 PC 구성');
INSERT INTO 견적 VALUES ('E007', 'use07', '2024-12-20', '1,590,000', '방송용 PC 구성');
INSERT INTO 견적 VALUES ('E008', 'use08', '2024-12-27', '880,000',  '개발용 PC 구성');
INSERT INTO 견적 VALUES ('E009', 'use10', '2024-11-21', '1,080,000', '영상편집용 PC 구성');
INSERT INTO 견적 VALUES ('E010', 'use10', '2024-12-13', '780,000', '사무용 PC 구성');


INSERT INTO 제조사 VALUES ('Ma01', 'Intel', 'USA', '반도체 및 CPU 제조사', 'https://www.intel.com');
INSERT INTO 제조사 VALUES ('Ma02', 'AMD', 'USA', 'GPU 및 CPU 제조사', 'https://www.amd.com');
INSERT INTO 제조사 VALUES ('Ma03', 'ASUS', 'Taiwan', '메인보드 및 GPU 제조사', 'https://www.asus.com');
INSERT INTO 제조사 VALUES ('Ma04', 'MSI', 'Taiwan', '메인보드 및 게이밍 하드웨어 제조사', 'https://www.msi.com');
INSERT INTO 제조사 VALUES ('Ma05', 'Cooler Master', 'Taiwan', '쿨러 및 케이스 제조사', 'https://www.coolermaster.com');
INSERT INTO 제조사 VALUES ('Ma06', 'Corsair', 'USA', 'RAM 및 파워 서플라이 제조사', 'https://www.corsair.com');
INSERT INTO 제조사 VALUES ('Ma07', 'Gigabyte', 'Taiwan', '메인보드 및 GPU 제조사', 'https://www.gigabyte.com');
INSERT INTO 제조사 VALUES ('Ma08', 'EVGA', 'USA', '파워 서플라이 및 GPU 제조사', 'https://www.evga.com');
INSERT INTO 제조사 VALUES ('Ma09', 'Samsung', 'South Korea', 'SSD 및 저장장치 제조사', 'https://www.samsung.com');
INSERT INTO 제조사 VALUES ('Ma10', 'Seagate', 'USA', 'SSD 및 스토리지 제조사', 'https://www.seagate.com');


INSERT INTO 카테고리 VALUES ('Ca01', 'CPU', '중앙 처리 장치');
INSERT INTO 카테고리 VALUES ('Ca02', 'GPU', '그래픽 처리 장치');
INSERT INTO 카테고리 VALUES ('Ca03', '메인보드', '컴퓨터의 주요 회로 기판');
INSERT INTO 카테고리 VALUES ('Ca04', 'RAM', '임시 데이터 저장 장치');
INSERT INTO 카테고리 VALUES ('Ca05', 'SSD', '고속 저장 장치');
INSERT INTO 카테고리 VALUES ('Ca06', '쿨러', '부품의 발열을 식히는 장치');
INSERT INTO 카테고리 VALUES ('Ca07', '파워 서플라이', '전원 공급 장치');
INSERT INTO 카테고리 VALUES ('Ca08', '케이스', 'PC 부품을 담는 외부 하드웨어');


INSERT INTO 부품 VALUES ('P001','Ca01', 'Ma01', 'Intel Core i5-13600K', 300.00, 'LGA1700', NULL, 125, NULL);
INSERT INTO 부품 VALUES ('P002','Ca01', 'Ma02', 'AMD Ryzen 7 5800X', 290.00, 'AM4', NULL, 105, NULL);
INSERT INTO 부품 VALUES ('P003','Ca01', 'Ma01', 'Intel Core i9-13900K', 649.00, 'LGA1700', NULL, 125, NULL);
INSERT INTO 부품 VALUES ('P004','Ca01', 'Ma02', 'AMD Ryzen 9 7900X', 599.00, 'AM5', NULL, 170, NULL);
INSERT INTO 부품 VALUES ('P005','Ca02', 'Ma03', 'NVIDIA RTX 4090', 1600.00, NULL, NULL, 450, '4.0');
INSERT INTO 부품 VALUES ('P006','Ca02', 'Ma02', 'AMD Radeon RX 6700 XT', 700.00, NULL, NULL, 230, '4.0');
INSERT INTO 부품 VALUES ('P007','Ca02', 'Ma04', 'MSI GeForce RTX 4070 Ti', 799.00, NULL, NULL, 285, '4.0');
INSERT INTO 부품 VALUES ('P008','Ca02', 'Ma07', 'Gigabyte RX 7900 XTX', 999.00, NULL, NULL, 355, '4.0');
INSERT INTO 부품 VALUES ('P009','Ca03', 'Ma03', 'ASUS ROG STRIX Z790-E', 400.00, 'LGA1700', 'DDR5', NULL, '5.0');
INSERT INTO 부품 VALUES ('P010','Ca03', 'Ma04', 'MSI B450 TOMAHAWK MAX', 150.00, 'AM4', 'DDR4', NULL, '3.0');
INSERT INTO 부품 VALUES ('P011','Ca03', 'Ma04', 'MSI B650 TOMAHAWK', 250.00, 'AM5', 'DDR5', NULL, '5.0');
INSERT INTO 부품 VALUES ('P012','Ca04', 'Ma06', 'Corsair Vengeance DDR5 32GB', 220.00, NULL, 'DDR5', NULL, NULL);
INSERT INTO 부품 VALUES ('P014','Ca04', 'Ma06', 'Corsair Dominator Platinum DDR5 64GB', 599.00, NULL, 'DDR5', NULL, NULL);
INSERT INTO 부품 VALUES ('P015','Ca04', 'Ma09', 'Samsung DDR4-3200 16GB', 43.00, NULL, 'DDR4', NULL, NULL);
INSERT INTO 부품 VALUES ('P015','Ca05', 'Ma09', 'Samsung 980 Pro 1TB NVMe', 169.00, NULL, NULL, NULL, '4.0');
INSERT INTO 부품 VALUES ('P016','Ca05', 'Ma09', 'Samsung 970 EVO Plus 2TB', 250.00, NULL, NULL, NULL, '3.0');
INSERT INTO 부품 VALUES ('P017','Ca05', 'Ma10', 'Seagate FireCuda 530 2TB', 350.00, NULL, NULL, NULL, '4.0');
INSERT INTO 부품 VALUES ('P018','Ca06', 'Ma05', 'Cooler Master Hyper 212', 50.00, 'LGA1700,AM4', NULL, NULL, NULL);
INSERT INTO 부품 VALUES ('P020','Ca06', 'Ma06', 'Corsair iCUE H150i Elite', 229.00, 'LGA1700,AM4,AM5', NULL, NULL, NULL);


