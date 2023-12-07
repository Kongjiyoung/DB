#GROUP BY 항목명 : 항목명대로 그룹화한다.
#SELECT 항목명 FROM 테이블명 GROUP BY 항목명;
#SELECT 항목명 FROM 테이블명 WHERE 조건 GROUP BY 항목명; GROUP BY을 쓸떄에는 WHERE 조건절 뒤에 쓴다
SELECT grade, SUM(kor_score) FROM tb1_students where grade =3 GROUP BY grade;

#HAVING 그룹화한 데이터에 조건을 걸어준다
#SELECT 항목명 FROM 테이블명 GROUP BY 항목명 HAVING 조건;
SELECT gender, count(gender) FROM employees GROUP BY gender HAVING COUNT(gender)>130000;



DROP table student;

#특정 열에 제약조건 걸고 싶을 떄
#CHECK(항목명 IN (특정 문자,숫자))
#CHECK(조건식)
#DEFAULT 0 
CREATE TABLE student(
stu_no CHAR(9) PRIMARY KEY,
stu_name VARCHAR(20) NOT NULL,
stu_dept VARCHAR(20) NOT NULL,
stu_grade CHAR(1) CHECK(stu_grade IN (1,2,3)),
stu_class CHAR(1),
stu_gender CHAR(1) CHECK(stu_gender IN ('M', 'F')),
stu_height INT DEFAULT 0 CHECK(stu_height <300),
stu_weight INT DEFAULT 0
);
DELETE FROM student;

INSERT INTO student VALUES('20153075', '옥한빛', '기계', '1', 'C', 'M', 177, 80);
INSERT INTO student VALUES
('20153088', '이태연', '기계', '1', 'C', 'F', 162, 50),
('20143054', '유가인', '기계', '2', 'C', 'F', 154, 47), 
('20152088', '조민우', '전기전자', '1', 'C', 'M', 188, 90), 
('20142021', '심수정', '전기전자', '2', 'A', 'F', 168, 45), 
('20132003', '박희철', '전기전자', '3', 'B', 'M', NULL, 63),
('20151062', '김인중', '컴퓨터정보', '1', 'B', 'M', 166, 67),
('20141007', '진현무', '컴퓨터정보', '2', 'A', 'M', 174, 64),
('20131001', '김종헌', '컴퓨터정보', '3', 'C', 'M', NULL, 72),
('20131025', '옥성우', '컴퓨터정보', '3', 'A', 'F', 172, 63);
SELECT*FROM student;

#DISTINCT 중복된 행을 제외시킴
SELECT distinct stu_dept FROM student;

#1. 학생테이블에서 학과명을 조회하시오. (단, 중복된 자료는 제외합니다.)
SELECT stu_dept FROM student GROUP BY stu_dept;
#2. 학생테이블에서 이름, 학과, 학년, 반을 조회할 때, 학과가 컴퓨터정보이고 학년이 2인 학생을 검색하시오
SELECT stu_name, stu_dept, stu_grade, stu_class FROM student WHERE stu_dept='컴퓨터정보' and stu_grade='2'; 
#3. 몸무게가 60이상 70이하인 학생의 정보를 검색하시오
select*FROM student WHERE stu_weight BETWEEN 60 AND 70;
#4. 학생테이블에서 학번, 이름을 조회할 떄 조회결과 열의 제목이 ID, NAME으로 표시되도록 하시오
SELECT stu_no AS ID, stu_name AS NAME FROM student;
#5. 2014학번 학생의 정보를 검색하시오
SELECT*FROM student WHERE stu_no LIKE '2014%';
#6. 성이 김씨인 학생들의 정보를 검색하시오
SELECT*FROM student WHERE stu_name LIKE '김%';
#7. 학생 중 이름의 두번쨰 문자가 '수'인 학생의 이름을 검색하시오
SELECT*FROM student WHERE stu_name LIKE '_수%';
#8. 학과가 컴퓨터 정보이거나 기계과인 학생의 학번과 이름을 검색하시오
SELECT stu_no, stu_name, stu_dept FROM student WHERE stu_dept='컴퓨터정보' OR stu_dept='기계';
SELECT stu_no, stu_name, stu_dept FROM student WHERE stu_dept IN ('컴퓨터정보', '기계');
#9. 학생의 기 정보가 null인 학생의 학번, 이름, 키 정보를 조회하시오.
SELECT stu_no, stu_name, stu_height FROM student WHERE stu_height IS NULL;
#10. 학생의 기 정보가 null이 아닌  학생의 학번, 이름, 키 정보를 조회하시오.
SELECT stu_no, stu_name, stu_height FROM student WHERE stu_height IS NOT NULL;
#11. 학과별 몸무게 평균을 구하시오.
SELECT stu_dept, AVG(stu_weight) AS '학과별 몸무게 평균' FROM student GROUP BY stu_dept; 

SELECT stu_dept, stu_grade, COUNT(stu_grade), AVG(stu_weight) FROM student GROUP BY stu_dept, stu_grade with ROLLUP; 
SELECT*FROM student;

#12. tb1_students 테이블에서 학년별 학생수를 구하시오.
SELECT grade, COUNT(sname) FROM tb1_students GROUP BY grade;

#13. 학년, 반별 학생수를 조회하시오.
SELECT grade, class, COUNT(sname) FROM tb1_students GROUP BY grade, class;

#14. 학년, 반별 국어점수의 합계를 조회하시오.
SELECT grade, class, SUM(kor_score) FROM tb1_students GROUP BY grade, class;

#15. 학년, 반별 국어점수, 영어점수, sql점수를 합한 총점을 내림차순으로 조회하시오.
SELECT grade, class, SUM(kor_score+eng_score+sql_score) AS 총합 FROM tb1_students  GROUP BY grade, class ORDER BY 총합 DESC;
#GROUP BY에서 조건을 걸고 싶을 때   HAVING절을 써준다.
SELECT grade, class, SUM(kor_score+eng_score+sql_score) AS 총합 FROM tb1_students  GROUP BY grade, class HAVING SUM(kor_score+eng_score+sql_score)> 1000;

#16. sql점수가 최저점인 학생의 이름과 학년, 반을 조회하시오.(서브쿼리가 막힐 때는 일단 여러줄 쓰기)
SELECT sname, grade, class FROM tb1_students WHERE sql_score=(SELECT MIN(sql_score) FROM tb1_students);

CREATE TABLE tbl_users(
	mem_id CHAR(10) PRIMARY KEY,
	mem_pw CHAR(10) NOT NULL,
	mem_num CHAR(11) DEFAULT 0,
	mem_gen CHAR(1) CHECK(mem_gen IN ('M', 'F'))
);
SELECT*FROM tbl_users;
DROP table tbl_users;
INSERT into tbl_users(mem_id, mem_pw, mem_num, mem_gen) VALUES('i','p','01012345678','M');

CREATE TABLE tbl_boards(
	bno INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(1000) NOT NULL,
	writter VARCHAR(20),
	regdate DATETIME DEFAULT CURTIME(),
	FOREIGN KEY (writter) REFERENCES tbl_users(mem_id) #tbl_boards테이블 writer tbl_users 중 mem_id후보키설정해준다
);
SELECT*FROM tbl_boards;

INSERT into tbl_boards(title, content, writter) VALUES('뀨','뀨뀨','i');

SELECT u.mem_id, u.mem_pw, u.mem_num, u.mem_gen, b.title, b.content FROM  tbl_users u, tbl_boards b WHERE u.mem_id = b.writter;
SELECT mem_id, writter,title FROM tbl_users, tbl_boards WHERE mem_pw='p';


DROP TABLE tbl_boards;
SELECT*FROM tbl_users;



CREATE TABLE employees1(
	empno INT PRIMARY KEY AUTO_INCREMENT,
	ename VARCHAR(20),
	phone VARCHAR(13),
	dept CHAR(4)
);

CREATE TABLE eboard1(
	bno INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50),
	content VARCHAR(100),
	empno INT,
	FOREIGN KEY(empno) REFERENCES employees1(empno) ON DELETE SET NULL ON UPDATE CASCADE
);
#외래키 변화에 대해서 반영
#FOREIGN (지금 작성할 테이블의 항목이름) references 참조할 테이블이름(참조할 테이블의 항목이름) ON 권한의 줄 기능(update, delete) CASCADE 


#독립적인 테이블 employees 테이블은 eboard테이블을 지워도 상관없지만 그 반대의 경우 eboard에서 employees테이블을 참조하고 있기 떄문에 지울 수 없다.
#on delete set null employees테이블에서 외래키를 지우면  references한 테이블에서 null로 바뀐다.
DROP TABLE eboard1;
DROP TABLE employees1;

INSERT INTO employees1(ename, phone, dept,empno) VALUE('홍길동', '01012345678', '부서1',1);
INSERT INTO employees1(ename, phone, dept,empno) VALUE('김길동', '0105558484', '부서2',2);
INSERT INTO eboard1(title, content, empno) VALUE('a', '네넨', 1);
INSERT INTO eboard1(title, content, empno) VALUE('c', '안녕', 2);

UPDATE employees1 SET empno=100 where empno=1;

DELETE FROM employees1 WHERE empno =100; 


SELECT*FROM employees1;
SELECT*FROM eboard1;

#테이블을 구조를 수정해주기
#컬럼 추가
ALTER TABLE employees ADD COLUMN address VARCHAR(100);
#데이터가 없을 때 지정값 넣어주기
ALTER TABLE employees ADD ninkname VARCHAR(50) DEFAULT '없음';
#컬럼 원하는 위치에 넣기
ALTER TABLE employees ADD COLUMN birth DATE AFTER phone;
#컬럼 수정
ALTER TABLE employees ADD COLUMN gender INT AFTER birth;
ALTER TABLE employees MODIFY COLUMN birth INT, MODIFY COLUMN gender CHAR(1);
ALTER TABLE employees MODIFY ninkname VARCHAR(50) AFTER birth;
#컬럼 이름 수정
ALTER TABLE employees CHANGE birth birthDate DATE;
#컬럼 삭제
ALTER TABLE employees DROP COLUMN ninkname;
#테이블 이름 수정
ALTER TABLE eboard RENAME tb1_eboard;

SELECT*FROM tb1_eboard;
DESC employees;

CREATE TABLE test (
	id VARCHAR(10),
	pw VARCHAR(10)
);

#기본키 입력
ALTER TABLE test ADD PRIMARY KEY  (id);
ALTER TABLE test DROP PRIMARY KEY;
#외래키 입력
ALTER TABLE test ADD COLUMN empno INT;
ALTER TABLE test ADD FOREIGN KEY (empno) REFERENCES employees(empno);
#외래키 이름 알아내기
SELECT*FROM information_schema.table_constraints WHERE TABLE_NAME = 'test';
#외래키 삭제
ALTER TABLE test01.test DROP FOREIGN KEY test_ibfk_1;

DESC test;

CREATE TABLE tbl_oder(
	orderNo INT AUTO_INCREMENT UNIQUE,
	mno INT,
	pname VARCHAR(100),
	ea INT,
	price INT,
	PRIMARY KEY(orderNo, mno, panme)
);


SET @myVal1 = 160;
SET @myVal2 = 170;

#prepare : 미완성쿼리 (실행전에 미리 쿼리문에 저장하는 거)
PREPARE myQuery
	FROM 'SELECT * FROM student WHERE stu_height BETWEEN ? AND ?';


EXECUTE myQuery USING @myVal1, @myVal2;

#limit : 3명만 보고 싶다
SELECT*FROM student ORDER BY stu_height DESC LIMIT 3;

#limit 1,3 : 시작하는 행 첫번째, 보여줄 행 갯수
SELECT*FROM student LIMIT 1,3;

#제어흐름함수
#if(조건문, 참일떄 결과값, 거짓일때 결과값) AS 컬럼명이름붙이기;
#매개변수, 인수 함수준비자료에 대한 얘기
SELECT if(100>200, 'True', 'False') AS tf;

#IFNULL(인수(쿼리), 결과값) 
#인수가 null일때 결과값이 반환 null이 아니면 인수값출력
SELECT IFNULL(NULL, '널이군요');

#NULLIF(첫번째인수, 두번째인수); 
#두 인수가 값이 같으면 null반환 다르면 첫번째인수 반환
SELECT NULLIF(50, 10);

#case 인수 when 조건 then 결과값 else 조건에 해당되지 않는거
SELECT case 10
		 when 1 then '일'
		 when 5 then '오'
		 when 10 then '삼'
		 ELSE '모름'
END;

#문자열
SELECT ASCII('A');
SELECT ASCII('B');

SELECT CHAR(65);

SELECT BIT_LENGTH('abc'); #할당된 bit 수 : 24개
SELECT CHAR_LENGTH('abc'); #글자 수 : 3개
SELECT LENGTH('abc'); #할당된 byte 수 : 3byte/ 1글자 1바이트

#한글과 영문은 사이즈가 다르다.
SELECT BIT_LENGTH('가');
SELECT CHAR_LENGTH('가');
SELECT LENGTH('가');

#문자열을 이어서 한문장으로 만들어준다.
SELECT CONCAT('abc', '가', 'def', '나');

#문자열 사이에 이어줄 문자를 넣어준다
SELECT CONCAT_WS('-', '010', '1111', '2222');
SELECT CONCAT_WS('/', '2013', '12', '05');

#인자에 해당되는 순서의 문자를 출력한다
SELECT ELT(2, 'a', 'b', 'c');

#인자에 해당되는 순서를 출력한다
SELECT FIELD('b', 'a', 'b', 'c');

#인자가 있는지 판별하여 1,0을 출력해준다.
SELECT FIND_IN_SET('a', 'a,b,c');

#인자가 있는 위치를 반환한다(없으면 0)
SELECT LOCATE('나', '하나둘셋');

#LOCATE 기능은 같지만 인자 받는 위치가 다름
SELECT INSTR('하나둘셋', '셋');

#소수점자리 몇번째까지 출력하는지  인자를 받음, 콤마도 넣을 수 있음
SELECT FORMAT(123456.123456, 3);

#십진수를 이진수로 바꿔줌
SELECT BIN(8);
SELECT BIN(4);
SELECT BIN(2);
SELECT BIN(1);

#8진수
SELECT OCT(9);
SELECT OCT(8);
SELECT OCT(7);
SELECT OCT(6);

#16진수
SELECT HEX(17); #11
SELECT HEX(16); #10
SELECT HEX(15); #F
SELECT HEX(14); #E
SELECT HEX(13); #D
SELECT HEX(12); #C
SELECT HEX(11); #B
SELECT HEX(10); #A
SELECT HEX(9); #9
SELECT HEX(8); #8

#5번째자리부터 시작해 1를 없애고 @넣기
#insert('삽입할 글자입력', 시작할 숫자, 얼마나 없앨건지, 넣을 문자)
SELECT INSERT('abcdefghi', 5, 1, '@@@@');

#왼쪽에서부터 3번째글자까지출력
SELECT LEFT('abcdefg', 3);
#오른쪽에서부터 3번째글자까지 출력
SELECT RIGHT('abcdefg', 3);
#중간글자 가져오기
SELECT  RIGHT(LEFT('abcdefg', 5), 2);
#시작할 글자 자릿수, 원하는 글자갯수
SELECT MID('abcdefg', 4, 2);
SELECT SUBSTRING('abcdefg', 4, 2);
SELECT SUBSTRING('abcdefg', FROM 4 FOR 2);
SELECT SUBSTR('abcdefg', 4, 2);

#SPACE(숫자) 공백을 임의로 넣어줄 수 있다.
SELECT CONCAT('이것이', SPACE(100), 'MariaDB다');

#앞뒤 순서를 바꾼다
SELECT REVERSE('abcde');

#REPLACE : 해당하는 글자를 바꾼다
#REPLACE(글자,해당글자,바꿀글자)
SELECT REPLACE('이것이 MariaDB다', '이것이', 'This is');


#왼쪽공백제거
SELECT  LTRIM('   abc');
#오른쪽공백제거
SELECT RTRIM('abc        ');
#공백제거
SELECT TRIM('     abc     ');

#글자반복
#repeat(문자, 반복횟수)
SELECT repeat('abc', 3);



CREATE TABLE userTBL(
	userID CHAR(8) PRIMARY KEY,
	NAME VARCHAR(10),
	birthYear INT CHECK(birthYear>=1900 AND birthYear<=2023),
	email VARCHAR(50) UNIQUE,
	addr CHAR(2) NOT NULL DEFAULT '서울',
	CONSTRAINT ck_name CHECK(NAME IS NOT NULL)
);

#constraint 제약조건을 걸어줌
CREATE TABLE buyTBL(
	num INT AUTO_INCREMENT PRIMARY KEY,
	userID CHAR(8) NOT NULL,
	prodName CHAR(6) NOT NULL,
	CONSTRAINT Fk_userTBL_buyTBL FOREIGN KEY(userID) REFERENCES userTBL(userID)
);

#수정 해주기


#스토이드 함수 (Stored Function)
#1. 스토이드 함수의 파라미터는 모두 입력 파라미터(매개변수)로 사용한다.
#2. 스토이드 함수는 RETURNS문으로 반환할 값의 데이터형식을 지정한다.
#3. 본문 안에서는 RETURN문으로 하나의 값을 반환해야 한다.
#4. 스토이드 함수를 호출할 때는 SELECT 문장으로 호출한다.

DROP FUNCTION if EXISTS userFunc; #userFunc이 있으면 없애라

DELIMITER $$
CREATE FUNCTION userFunc(VALUE1 INT, VALUE2 INT)
	RETURNS INT
BEGIN 
	RETURN VALUE1 + VALUE2;
END $$
DELIMITER ;

SELECT userFunc(10, 20) AS 합계;

#출생년도를 입력하면 나이가 출력되는 함수 만들기
#함수명 : getAgeFunc(int)

DELIMITER $$
CREATE FUNCTION getAgeFunc(bYear INT)
	RETURNS INT
BEGIN
	DECLARE age INT; #선언
	SET age = YEAR(CURDATE()) - bYear; #age 값 입력
	RETURN age;
END $$
DELIMITER ;

SELECT getAgeFunc(2003) AS 나이;


#프로시저
#쿼리문의 집합.. 일괄처리용

DELIMITER $$
CREATE PROCEDURE userProc()
BEGIN 
	SELECT * FROM student;
END $$
DELIMITER ;

CALL userProc();

#매개변수가 있는 프로시저
DELIMITER $$
CREATE PROCEDURE stuProc1(IN stuName VARCHAR(20))
BEGIN 
	SELECT * FROM student WHERE stu_name=stuName;
END $$
DELIMITER ;

CALL stuProc1('유가인');


DELIMITER $$
CREATE PROCEDURE userProc2(IN height INT, IN weight INT)
BEGIN
	SELECT * FROM student WHERE stu_height>height AND stu_weight < weight;	
END $$
DELIMITER ;

CALL userProc2(170, 100);



CREATE TABLE if not exists testTBL(
	id INT AUTO_INCREMENT PRIMARY KEY,
	txt CHAR(10)
);

DELIMITER %%
#IN 입력매개변수 OUT 출력매개변수
CREATE PROCEDURE userProc3(IN txtValue CHAR(10), OUT outValue INT)
BEGIN
	INSERT INTO testTBL VALUES(NULL, txtValue);
	SELECT MAX(id) INTO outValue FROM testTBL;
END%%
DELIMITER ;

CALL userProc3('테스트값', @myValue);
SELECT CONCAT('현재 입력된 id값 ==>', @myValue);


DROP TABLE testtbl;
DROP PROCEDURE userProc3;

#if~,  else
DELIMITER $$
CREATE PROCEDURE ifelseProc(IN userName VARCHAR(20))
BEGIN 
	DECLARE height INT; #변수선언
	SELECT stu_height INTO height FROM student WHERE stu_name=userName;
	
	if(height >= 170) then 
		SELECT '키가 크군요';
	else
		SELECT '키가 크진 않군요';
	END if;
END $$
DELIMITER ;

DROP PROCEDURE ifelseProc;

CALL ifelseProc('옥성우');

#트리거
#연달아 사용할때 사용한다.
CREATE TABLE if not exists testTBL(
	id INT ,
	txt CHAR(10)
);

DROP TABLE testtbl;

INSERT INTO testtbl VALUES (1, 'aaaa'), (2, 'bbbb'), (3, 'cccc');

SELECT * FROM testtbl;

DELIMITER //
CREATE  TRIGGER testTrg
	AFTER DELETE #삭제된 후에
	ON testtbl #testtbl테이블에서
	FOR EACH ROW #각행마다 실행시켜라
BEGIN
	SET @msg= '삭제가 되었어요..'; #트리거 실행 시 작동되는 코드
END //
DELIMITER ;

SET @msg='';
INSERT INTO testtbl VALUES(4, 'dddd');
SELECT @msg;

UPDATE testtbl SET txt='xxxx' WHERE id=4;
SELECT @msg;

DELETE FROM testtbl WHERE  id=4;
SELECT * FROM testtbl;
SELECT @msg; #트리거에서 지정한 메시지인 삭제가 되었다는 메시지가 뜸


#회원테이블에 update나 delete를 시도하면, 수정/삭제된 데이터를 별도의 테이블에 보관하고 변경된 일자와 변경한 사람을 기록하자.

DROP TABLE usertbl;

CREATE  TABLE usertbl(
	userID CHAR(8) PRIMARY KEY,
	NAME VARCHAR(10) NOT NULL,
	birthYear INT NOT NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height SMALLINT,
	mDate DATE
);

INSERT INTO usertbl VALUES ('HGD', '홍길동', 1980, '서울', '010', '11112222', 173, '2023-01-23');
SELECT*FROM usertbl;

CREATE  TABLE backupUsertbl(
	userID CHAR(8) , 
	NAME VARCHAR(10) NOT NULL,
	birthYear INT NOT NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3),
	mobile2 CHAR(8),
	height SMALLINT,
	mDate DATE,
	modType CHAR(2), #변경된 타입(수정 또는 삭제)
	modDate DATE, #변경된 날짜
	modUser VARCHAR(256) #변경된 사용자
);

DROP TABLE backupUsertbl;
DROP TRIGGER backUserTbl_UpdateTrag;

DELIMITER $$
CREATE TRIGGER backUserTbl_UpdateTrag
	AFTER UPDATE ON usertbl FOR EACH ROW
BEGIN
	INSERT INTO backUpusertbl VALUES(OLD.userID, OLD.name, OLD.birthYear, OLD.addr, OLD.mobile1,
	OLD.mobile2, OLD.height, OLD.mDate, '수정', CURDATE(), CURRENT_USER());
END $$
DELIMITER ;

UPDATE usertbl SET height = 198 WHERE userID='HGD';
SELECT*FROM usertbl;
SELECT*FROM backupUserTbl;

UPDATE usertbl SET addr = '부산' WHERE userID='HGD';
SELECT*FROM usertbl;
SELECT*FROM backupUserTbl;

DELIMITER $$
CREATE TRIGGER backUpUserTbl_DeleteTrag
	AFTER DELETE ON usertbl FOR EACH ROW 
BEGIN
	INSERT INTO backUpusertbl VALUES(OLD.userID, OLD.name, OLD.birthYear, OLD.addr, OLD.mobile1,
	OLD.mobile2, OLD.height, OLD.mDate, '삭제', CURDATE(), CURRENT_USER());
END $$
delimiter ;

DELETE FROM usertbl WHERE userID='HGD';
SELECT*FROM usertbl;
SELECT*FROM backupUserTbl;

#데이터가 테이블에 입력될 때 출생년도를 검사해서 데이터에 문제가 있
#값을 변경해서 입력시키는 Before Insert 트리거를 작성해보자.
#출생년도는 1900년 이상이어야 한다.
#출생년도가 현재 년도 보다 크면 현재 년도로 변경한다.

DROP TRIGGER birthChecktrg;

DELIMITER %%
CREATE TRIGGER birthChecktrg
	BEFORE INSERT ON usertbl FOR EACH row
BEGIN #데이터가 입력될 때 임시테이블이 있음 new, old
	if NEW.birthyear < 1900 then
		SET NEW.birthYear=0;
	ELSEIF NEW.birthyear > YEAR(CURDATE()) then
		SET NEW.birthYear=YEAR(CURDATE());
	END if;
	#Update usertbl set birYear=0 where birthYear<1900;
END %%
DELIMITER ;

/*
DELIMITER %%
CREATE TRIGGER birthChecktrg2
	BEFORE INSERT ON usertbl FOR EACH row
BEGIN #데이터가 입력될 때 임시테이블이 있음 new, old
	Update usertbl set birYear=0 where birthYear<1900;
END %%
DELIMITER ;
*/

DROP TRIGGER birthChecktrg2;

INSERT INTO usertbl VALUES ('Hdd3', '고길동', 1800, '서울', '010', '11112222', 173, '2023-01-23');
SELECT*FROM usertbl;
UPDATE usertbl SET birthYear =1800 WHERE userID='Hdddddd';
SELECT*FROM usertbl;
SELECT*FROM backupUserTbl;



#commit 영구적으로 데이터베이스에 저장한다.
#rollback 데이터베이스가 저장되기전으로 돌아간다.
#savepoint 변수 롤백할 수 있는 지점을 정할 수 있다
#transaction (트랜잭션)
START TRANSACTION;
INSERT INTO usertbl VALUES('xxx', 'xxx', 1998, '경기', '010', '66667777', 156, '2022-08-20');

SAVEPOINT a;

INSERT INTO usertbl VALUES('zzz', 'zzz', 1998, '경기', '010', '66667777', 156, '2022-08-20');

SAVEPOINT b;

DELETE FROM usertbl WHERE userID='Hdd';

SELECT*FROM usertbl;

ROLLBACK TO a;

ROLLBACK TO b; #세이브포인트 a지점까지올라가서 b지점은 없어진다.

SELECT*FROM usertbl;

COMMIT;











