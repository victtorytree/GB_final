CREATE DATABASE `Human_Friends`;
USE Human_Friends;
-- Задание 1.1. Создать таблицы с иерархией из диаграммы в БД
CREATE TABLE Animal 
( id INT PRIMARY KEY AUTO_INCREMENT,
animal_name VARCHAR(20),
animal_date_of_birth DATE
);
CREATE TABLE Pet_Animal 
( pet_id INT PRIMARY KEY AUTO_INCREMENT,
animal_name VARCHAR(20),
animal_date_of_birth DATE
);
CREATE TABLE pack_Animal 
( pack_id INT PRIMARY KEY AUTO_INCREMENT,
animal_name VARCHAR(20),
animal_date_of_birth DATE
);
-- Задание 1.2. Заполнить низкоуровневые таблицы именами(животных), командами которые они выполняют и датами рождения
CREATE TABLE `Cats` 
(id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20),
birth_date DATE NOT NULL,
commands VARCHAR(45)
);
INSERT INTO Cats (`name`, birth_date, commands)
VALUES 
('White', '2019-05-15', 'sit, pounce'),
('Elegant', '2022-06-08', 'jump, pounce'),
('Smudge', '2020-02-20', 'sit, pounce, scratch');

CREATE TABLE `Dogs` 
(id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20),
birth_date DATE NOT NULL,
commands VARCHAR(45)
);
INSERT INTO Dogs (`name`, birth_date, commands)
VALUES 
('Fido', '2020-01-01', 'sit, fetch'),
('Buddy', '2018-12-10', 'sit, paw, bark'),
('Bella', '2019-11-11', 'sit, stay, roll');
INSERT INTO Dogs (`name`, birth_date, commands)
VALUES 
('Zaya', '2022-01-01', 'sit, fetch');
CREATE TABLE `Donkeys` 
(id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20),
birth_date DATE NOT NULL,
commands VARCHAR(45)
);
INSERT INTO Donkeys (`name`, birth_date, commands)
VALUES 
('Eeyore', '2017-09-18', 'walk, carry load, bray'),
('Burro', '2018-06-17', 'walk, bray, kick'),
('Counce', '2019-10-13', 'bray, kick');

SELECT * FROM Cats
UNION ALL SELECT * FROM Donkeys;

CREATE TABLE `Camels` 
(id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20),
birth_date DATE NOT NULL,
commands VARCHAR(45)
);
INSERT INTO Camels (`name`, birth_date, commands)
VALUES 
('Sandy', '2016-11-03', 'walk, carry load'),
('Dune', '2018-12-23', 'walk, sit'),
('Sahara', '2015-08-13', 'walk, run');

CREATE TABLE `Horses` 
(id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20),
birth_date DATE NOT NULL,
commands VARCHAR(45)
);
INSERT INTO Horses (`name`, birth_date, commands)
VALUES 
('Thunder', '2015-07-21', 'trot, canter, gallop'),
('Storm', '2018-12-23', 'trot, canter'),
('Blaze', '2015-08-13', 'trot, jump, gallop');

SELECT * FROM `Camels`;
SELECT * FROM `Horses`;

-- Задание 2.
DELETE FROM Camels;  -- отключен безопасный режим
SELECT * FROM `Camels`;
SELECT * FROM `Horses`
UNION ALL
SELECT * FROM `Donkeys`;

/* Создать новую таблицу “молодые животные” в которую попадут все
животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
до месяца подсчитать возраст животных в новой таблице */
CREATE TABLE Young_animals
(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30),
date_birth Date,
commands VARCHAR(100)
);

ALTER TABLE Young_animals
ADD age VARCHAR(50);
TRUNCATE Young_animals;
INSERT INTO Young_animals (id, name, date_birth, commands, age)
SELECT id, name, birth_date, commands,
CONCAT(FLOOR(ABS(DATEDIFF(birth_date, NOW())/365)), ' years, and ', FLOOR(ABS(DATEDIFF(birth_date, NOW())/30%12)), ' months') AS age
FROM Cats
WHERE ABS(DATEDIFF(birth_date, NOW())/365) BETWEEN 1 AND 3
UNION ALL
SELECT id, name, birth_date, commands,
CONCAT(FLOOR(ABS(DATEDIFF(birth_date, NOW())/365)), ' years, and ', FLOOR(ABS(DATEDIFF(birth_date, NOW())/30%12)), ' months') AS age
FROM Dogs
WHERE ABS(DATEDIFF(birth_date, NOW())/365) BETWEEN 1 AND 3
UNION ALL
SELECT id, name, birth_date, commands,
CONCAT(FLOOR(ABS(DATEDIFF(birth_date, NOW())/365)), ' years, and ', FLOOR(ABS(DATEDIFF(birth_date, NOW())/30%12)), ' months') AS age
FROM Donkeys
WHERE ABS(DATEDIFF(birth_date, NOW())/365) BETWEEN 1 AND 3
UNION ALL
SELECT id, name, birth_date, commands,
CONCAT(FLOOR(ABS(DATEDIFF(birth_date, NOW())/365)), ' years, and ', FLOOR(ABS(DATEDIFF(birth_date, NOW())/30%12)), ' months') AS age
FROM Horses
WHERE ABS(DATEDIFF(birth_date, NOW())/365) BETWEEN 1 AND 3;

SELECT * FROM Young_animals;

-- Задание 4. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.
CREATE TABLE table_references 
(table_id INT PRIMARY KEY AUTO_INCREMENT,
type_animal VARCHAR(10)
);
INSERT INTO table_references (type_animal)
VALUES 
('Cats'),
('Dogs'),
('Donkeys'),
('Horses');
SELECT * 
FROM table_references;
ALTER TABLE Animal
ADD table_id INT,
ADD commands VARCHAR(100);
ALTER TABLE Cats
ADD table_id INT;
ALTER TABLE Dogs
ADD table_id INT;
ALTER TABLE Horses
ADD table_id INT;
ALTER TABLE Donkeys
ADD table_id INT;

INSERT INTO Animal(animal_name, animal_date_of_birth, table_id, commands)
SELECT name, birth_date, 1, commands
FROM Cats
UNION ALL
SELECT name, birth_date, 2, commands
FROM Dogs
UNION ALL
SELECT name, birth_date, 3, commands
FROM Donkeys
UNION ALL
SELECT name, birth_date, 4, commands
FROM Horses;

SELECT * FROM Animal;
SELECT * FROM Horses;
