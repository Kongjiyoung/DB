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



#함수 이름은 res1 정수값 4를 리턴하는 값
