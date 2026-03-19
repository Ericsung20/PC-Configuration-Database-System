use my_database;

CREATE TABLE 사용자 (
	사용자ID VARCHAR(20) NOT NULL,
    사용자이름 VARCHAR(20) NOT NULL,
    이메일 VARCHAR(100) NOT NULL,
    비밀번호 VARCHAR(255) NOT NULL,
    나이 INT,
    가입날짜 DATE,
    역할 VARCHAR(20) DEFAULT '일반',
    PRIMARY KEY(사용자ID)
);


CREATE TABLE 부품 (
	부품ID CHAR(3) NOT NULL,
    카테고리 VARCHAR(20),
	제조업체 VARCHAR(20),
	부품명 VARCHAR(50),
    PRIMARY KEY(부품ID)
);

CREATE TABLE 리뷰 (
	리뷰ID CHAR(3) NOT NULL,
	부품 CHAR(3),
    작성인 VARCHAR(20),
    작성날짜 DATE,
    평점 INT,
    PRIMARY KEY(리뷰ID),
    FOREIGN KEY(작성인) REFERENCES 사용자(사용자ID),
    FOREIGN KEY(부품) REFERENCES 부품(부품ID)
);


CREATE TABLE 가격(
	가격ID CHAR(3) NOT NULL,
    가격값 INT,
    해당부품 VARCHAR(50),
    가격적용날짜 DATE,
    PRIMARY KEY(가격ID),
	FOREIGN KEY(해당부품) REFERENCES 부품(부품ID)
);

CREATE TABLE 사양(
	사양ID CHAR(3) NOT NULL,
    해당부품 VARCHAR(50),
    사양명 VARCHAR(20),
    사양설명 VARCHAR(100),
    PRIMARY KEY(사양ID),
	FOREIGN KEY(해당부품) REFERENCES 부품(부품ID)
);

CREATE TABLE 요청(
	요청ID CHAR(3) NOT NULL,
    요청인 VARCHAR(20),
	요청예산 INT,
    요청부품 VARCHAR(50),
    요청용도 VARCHAR(20),
    PRIMARY KEY(요청ID),
	FOREIGN KEY(요청인) REFERENCES 사용자(사용자ID),
	FOREIGN KEY(요청부품) REFERENCES 부품(부품ID)
);

CREATE TABLE 추천PC(
	추천ID CHAR(3) NOT NULL,
    세부사양 VARCHAR(100),
    PC가격 INT,
    PRIMARY KEY(추천ID)
);

INSERT INTO 사용자 VALUES ('CAU001', '서은현', 'CAU001@cau.ac.kr', 'cau001', '20', '2022-08-10', '관리자');
INSERT INTO 사용자 VALUES ('CAU002', '박지연', 'CAU002@cau.ac.kr', 'cau002', '24', '2022-10-19', '일반');
INSERT INTO 사용자 VALUES ('CAU003', '성현우', 'CAU003@cau.ac.kr', 'cau003', '20', '2022-08-08', '관리자');
INSERT INTO 사용자 VALUES ('CAU004', '박영준', 'CAU004@cau.ac.kr', 'cau004', '23', '2022-09-21', '일반');
INSERT INTO 사용자 VALUES ('CAU005', '김혜윤', 'CAU005@cau.ac.kr', 'cau005', '28', '2022-11-02', '일반');
INSERT INTO 사용자 VALUES ('CAU006', '김광희', 'CAU006@cau.ac.kr', 'cau006', '33', '2022-11-22', '일반');
INSERT INTO 사용자 VALUES ('CAU007', '이재은', 'CAU007@cau.ac.kr', 'cau007', '21', '2022-12-01', '일반');
INSERT INTO 사용자 VALUES ('CAU008', '이효정', 'CAU008@cau.ac.kr', 'cau008', '21', '2022-12-11', '일반');
INSERT INTO 사용자 VALUES ('CAU009', '최우준', 'CAU009@cau.ac.kr', 'cau009', '23', '2023-01-01', '일반');
INSERT INTO 사용자 VALUES ('CAU010', '강찬식', 'CAU010@cau.ac.kr', 'cau010', '23', '2022-01-18', '일반');

INSERT INTO 부품 VALUES ('B00', 'CPU', 'AMD 라이젠', '5-5세대 7500F');
INSERT INTO 부품 VALUES ('B01', 'CPU', 'AMD 라이젠', '7-6세대 9700X');
INSERT INTO 부품 VALUES ('B02', 'CPU', 'AMD 라이젠', '7-4세대 5700X3D');
INSERT INTO 부품 VALUES ('B03', 'CPU', 'AMD 라이젠', '7-6세대 9800X3D');
INSERT INTO 부품 VALUES ('B04', 'CPU', 'AMD 라이젠', '7-5세대 7800X3D');
INSERT INTO 부품 VALUES ('B05', 'CPU', 'AMD 라이젠', '5-6세대 9600X');
INSERT INTO 부품 VALUES ('B06', 'CPU', 'AMD 라이젠', '5-4세대 5500GT');
INSERT INTO 부품 VALUES ('B07', 'CPU', 'AMD 라이젠', '5-4세대 5600G');
INSERT INTO 부품 VALUES ('B08', 'CPU', 'AMD 라이젠', '5-5세대 8600G');
INSERT INTO 부품 VALUES ('B09', 'CPU', 'AMD 라이젠', '7-4세대 5700X');
INSERT INTO 부품 VALUES ('B10', 'CPU', 'AMD 라이젠', '9-5세대 7900');

INSERT INTO 부품 VALUES ('B11', 'CPU', 'INTEL', 'i5-14세대 14400F');
INSERT INTO 부품 VALUES ('B12', 'CPU', 'INTEL', 'i7-14세대 14700K');
INSERT INTO 부품 VALUES ('B13', 'CPU', 'INTEL', 'i5-12세대 12400F');
INSERT INTO 부품 VALUES ('B14', 'CPU', 'INTEL', 'i5-14세대 14600KF');
INSERT INTO 부품 VALUES ('B15', 'CPU', 'INTEL', 'i9-14세대 14900K');
INSERT INTO 부품 VALUES ('B16', 'CPU', 'INTEL', 'i3-12세대 12100F');
INSERT INTO 부품 VALUES ('B17', 'CPU', 'INTEL', 'i7-14세대 14600KF');
INSERT INTO 부품 VALUES ('B18', 'CPU', 'INTEL', 'i9-14세대 14900KF');
INSERT INTO 부품 VALUES ('B19', 'CPU', 'INTEL', 'i5-13세대 13400F');
INSERT INTO 부품 VALUES ('B20', 'CPU', 'INTEL', 'i3-14세대 14100');

INSERT INTO 부품 VALUES ('B21', '쿨러', 'Darkflash', 'Nebula DN-360D ARGB');
INSERT INTO 부품 VALUES ('B22', '쿨러', 'Darkflash', 'C7A 120 ARGB');
INSERT INTO 부품 VALUES ('B23', '쿨러', 'Darkflash', 'DM12 PRO 120 PWm ARGB');
INSERT INTO 부품 VALUES ('B24', '쿨러', 'PCCOoler', 'PALADIN 400');
INSERT INTO 부품 VALUES ('B25', '쿨러', 'PCCOoler', 'PALADIN EX400 ARGB');
INSERT INTO 부품 VALUES ('B26', '쿨러', 'PCCOoler', 'CPS DE360');
INSERT INTO 부품 VALUES ('B27', '쿨러', 'PCCOoler', 'G6');
INSERT INTO 부품 VALUES ('B28', '쿨러', '잘만', 'CNPS9X PERFORMA');
INSERT INTO 부품 VALUES ('B29', '쿨러', '잘만', 'Alpha II A36');
INSERT INTO 부품 VALUES ('B30', '쿨러', '3RSYS', 'Socoool RC1900 ARGB');
INSERT INTO 부품 VALUES ('B31', '쿨러', '3RSYS', 'Socoool RC1050 ARGB');
INSERT INTO 부품 VALUES ('B32', '쿨러', '3RSYS', 'Socoool RC1900N ARGB');
INSERT INTO 부품 VALUES ('B33', '쿨러', 'DEEPCOOL', 'AG400');
INSERT INTO 부품 VALUES ('B34', '쿨러', 'DEEPCOOL', 'AG620');
INSERT INTO 부품 VALUES ('B35', '쿨러', 'DEEPCOOL', 'MYSTIQUE 360');
INSERT INTO 부품 VALUES ('B36', '쿨러', '리안리', 'Hydroshift LCD 360S');
INSERT INTO 부품 VALUES ('B37', '쿨러', '리안리', 'GALAHAD II LCD SL-INF 360');
INSERT INTO 부품 VALUES ('B38', '쿨러', '리안리', 'UNI FAN SL120 V2 리버스');
INSERT INTO 부품 VALUES ('B39', '쿨러', '앱코', 'LP360 레이어드 ARGB');
INSERT INTO 부품 VALUES ('B40', '쿨러', '앱코', '타이폰 120X5 PRO');