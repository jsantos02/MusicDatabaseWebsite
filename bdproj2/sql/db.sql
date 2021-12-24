CREATE DATABASE IF NOT EXISTS SPOTIFY;

USE SPOTIFY;

DROP TABLE IF EXISTS FOLLOW_PLAYLIST,LIKE_ALBUM,FOLLOW_ARTIST,FOLLOWER,PLAYLIST_TEST,PLAYLIST,GENRE_TRACK,TRACK,GENRE_ALBUM,ALBUM,GENRE_ARTIST,ARTIST,USER;

CREATE TABLE
USER
(
    Num       INT AUTO_INCREMENT,                                   -- Identificador único do número de users
    Login     VARCHAR(16) UNIQUE NOT NULL,                          -- Login único por user
    Joined    DATETIME DEFAULT NOW() NOT NULL,                      -- Data e hora de inscrição na plataforma
    Name      VARCHAR(128) NOT NULL,                                -- Nome do utilizador
    BirthDate DATE NOT NULL,                                        -- Data de nascimento do utilizador
    Sex       ENUM('M', 'F','NB') NULL,                         -- Sexo do utilizador
    Phone     INT UNIQUE NOT NULL,                                  -- Número do telefone do utilizador, obrigatório para confirmar a unicidade da conta
    Email     VARCHAR(64) UNIQUE NOT NULL,                          -- Email único para confirmar unicidade da conta
    Plan      ENUM('Free', 'Premium', 'Premium Family') NOT NULL,   -- Plano utilizado pelo utilizador
    PRIMARY KEY(Num, Login)
);

INSERT INTO USER(Login, Joined, Name, BirthDate, Sex, Phone, Email, Plan)
VALUES 
    ('jsantos', '2016-01-26 15:35:23', 'José Santos', '2002-07-02', 'M', '913234179', 'up202007059@up.pt', 'Premium'),
    ('tteixeira', '2016-04-22 11:23:00', 'Tiago Teixeira', '2001-05-12', 'M', '927543018' , 'up202006089@up.pt', 'Premium'),
    ('bigt01', NOW(), 'Tiago Guerra', '2001-07-25', 'M', '913452412', 'bigfattiago@gmail.com', 'Free'),
    ('kanyewest', '2009-05-07 23:59:59', 'Kanye West', '1977-06-08','M', '999777245', 'kanyeomariwest@hotmail.com', 'Premium Family'),
    ('abel1973','2019-05-23 15:22:52','Abel José','1987-08-17', 'M', '925647137', 'zeabel33@gmail.com','Premium'),
    ('manel_htv', '2020-11-08 10:00:00', 'Manuel Fernandes', '1988-08-16','M', '936527810', 'manelbarreiro@hotmail.pt', 'Free'),
    ('xChica3', '2021-01-20 17:35:23', 'Maria Francisca Gregório','1998-10-14','F', '968524317', 'gregorioch@edu.fl.pt', 'Premium'),
    ('cambresCity', '2019-03-30 08:24:56', 'João Cambres Fonseca','2000-12-05' ,'NB', '936879200', 'cambresjonas@cmtv.com', 'Free'),
    ('leoxX12', '2019-10-10 12:56:42', 'Leonardo Maria Morais','1987-03-22','M', '926803114', 'mmleo12@gmail.pt','Free'),
    ('gui_fer', '2019-12-09 22:58:10', 'Guilherme Ferreira', '1999-06-21',NULL, '926800132', 'gamer37@hotmail.com','Premium Family'),
    ('mar_al', '2020-07-15 10:52:26', 'Mara Alves', '2000-08-27','F', '936207785', 'alvesmaraaa@gmail.com','Free'),
    ('malucoze','2021-05-15 14:10:46','Fernando José Pereira', '1995-11-05','NB', '916803346', 'zemaluco33@edu.fr', 'Premium Family'),
    ('xanaRosa', NOW(),'Alexandra Loureiro','1999-12-26','F', '931255710', 'xanafcp1@outlook.com', 'Free'),
    ('mccLíder','2018-03-29 02:59:44', 'Fernando Madureira','1997-05-19','M', '965107632', 'sd1893@gmail.com', 'Premium'),
    ('escarlos4', '2021-04-12 10:45:10', 'Carlos Moura', '2001-10-17','M', '917003258', 'carlinhos10@fdlt.com','Free'),
    ('gamergirl39', NOW(),'Beatriz Guedes', '1999-08-16','F','928854100', 'gamingbea@hotmail.com', 'Premium Family'),
    ('sandeIlidio', NOW(), 'Ilídio Monteiro','1995-02-26', 'M', '932556017', 'montilid@cambres.pt', 'Free'),
    ('vanACC', '2018-06-30 23:59:10', 'Vania Albino','2000-06-28' ,NULL, '968530017', 'albinovan97@gmail.com', 'Premium'),
    ('estev_88', '2021-10-10 00:51:10','Miguel Esteves','1988-11-21', 'M', '938025517', 'migas88@fcup.pt', 'Free');

CREATE TABLE
ARTIST
(
    Num           INT AUTO_INCREMENT,               -- Identificador numérico dos artistas
    Art_ID        VARCHAR(32) UNIQUE NOT NULL,      -- Identificador único do artista
    Art_Name      VARCHAR(128) NOT NULL,            -- Nome do artista
    Art_BirthDate DATE NOT NULL,                    -- Data de nascimento/Criação do grupo do artista
    Art_Sex       ENUM('M', 'F','NB') NULL,     -- Sexo do artista
    Art_Country   VARCHAR(32) NOT NULL,             -- País de origem do artista
    PRIMARY KEY(Num,Art_ID)
);

INSERT INTO ARTIST(Art_ID, Art_Name, Art_BirthDate, Art_Sex, Art_Country)
VALUES
    ('PT500001','Chico da Tina', '1996-08-12', 'M', 'Portugal'),
    ('US100001','Kanye West', '1977-06-08','M', 'United States'),
    ('UK300001','FKA Twigs', '1988-01-17','F', 'United Kingdom'),
    ('US450101','Freddie Gibbs', '1982-06-14', 'M', 'United States'),
    ('US450102','Future', '1983-11-20', 'M', 'United States'),
    ('US450103','Kendrick Lamar','1987-06-17', 'M', 'United States'),
    ('US450104','Nas', '1973-09-14', 'M', 'United States'),
    ('US450105','Tay-K', '2000-06-16', 'M', 'United States'),
    ('US450106','Young Thug','1991-08-16', 'M', 'United States'),
    ('US450107','A$AP Rocky', '1988-10-03', 'M', 'United States'),
    ('US450108','Playboi Carti', '1996-09-13', 'M', 'United States'),
    ('US450109','Vince Staples', '1993-07-02', 'M', 'United States'),
    ('US450110','Kid Cudi', '1984-01-30', 'M', 'United States'),
    ('UK450111','Skepta', '1982-09-19', 'M', 'United Kingdom'),
    ('US450112','Tyler The Creator', '1991-03-06', 'M', 'United States'),
    ('UK450113','slowthai', '1994-12-18', 'M', 'United Kingdom'),
    ('UK450114','MF DOOM', '1971-07-13', 'M', 'United Kingdom'),
    ('US501235','Mac Miller', '1992-01-19', 'M', 'United States'),
    ('PT123009','José Afonso', '1929-08-02', 'M', 'Portugal'),
    ('PT123583','José Mário Branco', '1942-05-25', 'M', 'Portugal'),
    ('US424089','Led Zeppelin','1968-10-04', NULL, 'United States'),
    ('UK142104','IDLES', '2012-01-01', NULL, 'United Kingdom'),
    ('AUS123491','Julia Jacklin','1990-08-30','F','Australia'),
    ('US123041','Twenty One Pilots', '2009-01-01',NULL, 'United States'),
    ('PT125612','Ana Bacalhau', '1978-11-05', 'F', 'Portugal'),
    ('CA100000','The Weeknd', '1990-02-16','M', 'Canada'),
    ('US450115','Isaiah Rashad', '1991-05-16', 'M', 'United States');

CREATE TABLE
GENRE_ARTIST
(
  Artist INT NOT NULL,
  Genre VARCHAR(32) NOT NULL,
  PRIMARY KEY(Artist,Genre),
  FOREIGN KEY(Artist) REFERENCES ARTIST(Num) ON DELETE CASCADE
);

INSERT INTO GENRE_ARTIST(Artist, Genre) 
VALUES
    (1,'Trap'),(1,'Música Portuguesa'),(1,'Hip-Hop'),
    (2,'Hip-Hop'), (2,'Experimental Hip-Hop'),
    (3,'R&B'),(3,'Eletronic R&B'),
    (4,'Hip-Hop'),(4,'Jazz Hip-Hop'),
    (5,'Trap'),(5,'Toxic Hip-Hop'),
    (6,'Hip-Hop'),(6,'Conscious Hip-Hop'),
    (7,'Hip-Hop'),(7,'Conscious Hip-Hop'),
    (8,'Trap'),
    (9,'Hip-Hop'),
    (10,'Cloud Rap'),
    (11,'Hip-Hop'),(11,'Cloud Rap'),
    (12,'Experimental Hip-Hop'),(12,'Trap Hip-Hop'),
    (13,'Hip-Hop'),(13,'Conscious Hip-Hop'),(13,'Depressive'),
    (14,'Grime'),(14,'UK Music'),
    (15,'Hip-Hop'),(15,'Conscious Hip-Hop'),(15,'LGBTQ+ Friendly'),
    (16,'Grime'),(16,'UK Music'),(16,'Conscious Hip-Hop'),
    (17,'Hip-Hop'),(17,'Boom-Bap Hip-Hop'),
    (18,'Singing'),(18,'Hip-Hop'),(18,'Backpack Rap'),
    (19,'Protest Song'),(19,'Fado'), (19,'Música Portuguesa'),
    (20,'Protest Song'),(20,'Fado'), (20,'Música Portuguesa'),
    (21,'Rock'),(21,'Progressive Rock'),(21,'Hard Rock'),
    (22,'Rock'),(22,'Punk'), (22,'Punk Rock'),(22,'UK Rock'),
    (23,'Folk'),(23,'Singing'),
    (24,'Indie'),(24,'Rock'),(24,'Alt-Rock'),
    (25,'Música Portuguesa'),(25,'Fado'),
    (26,'R&B'), (26,'Pop R&B'),
    (27,'Hip-Hop'),(27,'Abstract Hip-Hop');

CREATE TABLE
ALBUM
(
    Num          INT AUTO_INCREMENT,
    Album_ID     VARCHAR(32) UNIQUE NOT NULL,       -- ID do álbum  
    Album_Title  VARCHAR(64) NOT NULL,              -- Título do álbum
    AlbumArt_ID  VARCHAR(32) NOT NULL,              -- ID do artista do álbum
    Album_RD     DATE NOT NULL,                     -- Data de lançamento do álbum
    PRIMARY KEY(Num,Album_ID),
    FOREIGN KEY(AlbumArt_ID) REFERENCES ARTIST(Art_ID) ON DELETE CASCADE
);

INSERT INTO ALBUM(Album_ID, Album_Title, AlbumArt_ID, Album_RD) 
VALUES
    ('AL100000', 'Minho Trapstar', 'PT500001', '2019-11-20'),
    ('AL200040', 'My Beautiful Dark Twisted Fantasy', 'US100001', '2010-11-22'),
    ('AL300050', 'MAGDALENE', 'UK300001', '2019-11-08'),
    ('AL411100', 'Man On The Moon: The End of Day', 'US450110','2009-09-15'),
    ('AL411200', 'ALFREDO','US450101', '2020-05-29'),
    ('AL411300', 'IGOR','US450112', '2019-05-17'),
    ('AL411400', 'SLIME SEASON 3', 'US450106',  '2016-03-25'),
    ('AL411500', '#SantanaWorld (+)','US450105',  '2017-07-29'),
    ('AL411600', 'untitled unmastered.','US450103','2016-03-04'),
    ('AL411700', 'Kings Disease','US450104', '2020-08-21'),
    ('AL411800', 'FM!', 'US450109','2018-11-02'),
    ('AL411900', 'TYRON', 'UK450113', '2021-02-12'),
    ('AL411000', 'HNDRXX', 'US450102', '2017-02-24'),
    ('AL134911', 'TESTING', 'US450107',  '2018-05-25'),
    ('AL123499', 'Whole Lotta Red', 'US450108', '2020-12-25'),
    ('AL125912', 'Konnichiwa', 'UK450111',  '2016-05-06'),
    ('AL123459', 'MM... FOOD', 'UK450114', '2004-11-16'),
    ('AL180923', 'Circles', 'US501235', '2020-01-17'),
    ('AL581723', 'Cantares do Andarilho', 'PT123009',  '1968-12-13'),
    ('AL961234', 'Mudam-se os Tempos, Mudam-se as Vontades', 'PT123583',  '1974-12-14'),
    ('AL123758', 'Houses of the Holy', 'US424089',  '1973-03-28'),
    ('AL124674', 'CRAWLER', 'UK142104',  '2021-11-12'),
    ('AL168346', 'Crushing', 'AUS123491', '2019-02-22'),
    ('AL578912', 'Scaled And Icy', 'US123041',  '2021-05-21'),
    ('AL123851', 'Nome Próprio', 'PT125612',  '2017-10-20'),
    ('AL411401', 'Punk', 'US450106',  '2021-10-15'),
    ('AL223499', 'Die Lit', 'US450108', '2018-05-11'),
    ('AL280923', 'Faces', 'US501235', '2014-05-11'),
    ('AL411601', 'DAMN.','US450103','2017-04-14'),
    ('AL711800', 'VINCE STAPLES', 'US450109','2021-07-21'),
    ('AL800000', 'House of Balloons', 'CA100000','2011-03-21'),
    ('AL900000', 'The House is Burning', 'US450115','2021-07-30');


CREATE TABLE
GENRE_ALBUM
(
  Album INT NOT NULL,
  Genre VARCHAR(32) NOT NULL,
  PRIMARY KEY(Album,Genre),
  FOREIGN KEY(Album) REFERENCES ALBUM(Num) ON DELETE CASCADE
);
INSERT INTO GENRE_ALBUM(Album, Genre) 
VALUES
    (1,'Trap'),(1,'Música Portuguesa'),(1,'Hip-Hop'),
    (2,'Hip-Hop'), (2,'Experimental Hip-Hop'),
    (3,'R&B'),(3,'Eletronic R&B'),
    (4,'Hip-Hop'),(4,'Jazz Hip-Hop'),
    (5,'Trap'),(5,'Toxic Hip-Hop'),
    (6,'Hip-Hop'),(6,'Conscious Hip-Hop'),
    (7,'Hip-Hop'),(7,'Conscious Hip-Hop'),
    (8,'Trap'), (8,'Hardcore Hip-Hop'),
    (9,'Hip-Hop'),(10,'Trap'),
    (11,'Hip-Hop'),(11,'Cloud Rap'),
    (12,'Experimental Hip-Hop'),(12,'Trap Hip-Hop'),
    (13,'Hip-Hop'),(13,'Conscious Hip-Hop'),
    (14,'Depressive'),(14,'Hip-Hop'),
    (15,'Grime'),(15,'UK Music'),
    (16,'Hip-Hop'),(16,'Conscious Hip-Hop'),
    (17,'Grime'),(17,'UK Music'),(17,'Conscious Hip-Hop'),
    (18,'Hip-Hop'),(18,'Boom-Bap Hip-Hop'),
    (19,'Singing'),(19,'Hip-Hop'),(19,'Backpack Rap'),
    (20,'Fado'), (20,'Música Portuguesa'),
    (21,'Protest Song'),(21,'Fado'), (21,'Música Portuguesa'),
    (22,'Rock'),(22,'Progressive Rock'),
    (23,'Folk'),
    (24,'Indie'),(24,'Rock'),(24,'Alt-Rock'),
    (25,'Música Portuguesa'),(25,'Fado'),
    (26, 'Hip-Hop') , (26, 'Jazz Hip-Hop'),
    (27, 'Trap'), (28, 'R&B'),
    (28, 'Eletronic R&B'),
    (29,'Experimental Hip-Hop'), (29, 'Conscious Hip-Hop'),
    (30, 'Experimental Hip-Hop'),
    (31, 'Experimental R&B'), (31,'R&B'),
    (32,'Experimental Hip-Hop'), (32, 'Hip-Hop');


CREATE TABLE
TRACK
(
    Num          INT AUTO_INCREMENT,
    Track_ID     VARCHAR(32) UNIQUE NOT NULL,       -- ID da música
    Track_Title  VARCHAR(64) NOT NULL,              -- Título da música
    Artist_ID    VARCHAR(32) NOT NULL,              -- ID do artista da música
    TrAlbum_ID   VARCHAR(32) NULL,                  -- ID do álbum onde está a música. Pode ser NULL visto que existem singles que não estão inseridos em álbuns.
    Track_Plays  INT NOT NULL,                      -- Número de plays de uma música
    Track_RT     TIME NOT NULL,                     -- Duração de uma música
    PRIMARY KEY(Num,Track_ID),
    FOREIGN KEY(Artist_ID) REFERENCES ARTIST(Art_ID) ON DELETE CASCADE,    
    FOREIGN KEY(TrAlbum_ID) REFERENCES ALBUM(Album_ID) ON DELETE CASCADE
);

INSERT INTO TRACK(Track_ID, Track_Title, Artist_ID, TrAlbum_ID, Track_Plays, Track_RT)
VALUES
    ('TR100000', 'Apresentação Romarias', 'PT500001', 'AL100000',  '767913','00:01:39'),
    ('TR100001', 'Romarias', 'PT500001', 'AL100000',  '961031','00:02:15'),
    ('TR100002', 'Castolo', 'PT500001', 'AL100000',  '968371','00:02:42'),
    ('TR100003', 'Sou Rei', 'PT500001', 'AL100000',  '819363','00:02:49'),
    ('TR100004', 'Freicken', 'PT500001', 'AL100000',  '2389992','00:01:54'),
    ('TR100005', 'Deitei Tarde Acordei Late', 'PT500001', 'AL100000',  '1831792','00:02:37'),
    ('TR100006', 'Minho Trapstar', 'PT500001', 'AL100000',  '1002672','00:03:01'),
    ('TR100007', 'Baby - Remix LYP2', 'PT500001', 'AL100000',  '565238','00:03:19'),
    ('TR100008', 'Cabral Moncada', 'PT500001', 'AL100000',  '530770','00:02:01'),
    ('TR100009', 'Triangle Chest', 'PT500001', 'AL100000',  '485786','00:02:35'),
    ('TR200000', 'Dark Fantasy', 'US100001', 'AL200040',  '122042020', '00:04:40'),
    ('TR200001', 'Gorgeous', 'US100001', 'AL200040',  '120367847', '00:05:57'),
    ('TR200002', 'POWER', 'US100001', 'AL200040',  '640441080', '00:04:52'),
    ('TR200003', 'All of The Lights (Interlude)', 'US100001', 'AL200040',  '47666753', '00:01:02'),
    ('TR200004', 'All of The Lights', 'US100001', 'AL200040',  '390695657', '00:04:59'),
    ('TR200005', 'Monster', 'US100001', 'AL200040',  '235357221', '00:06:18'),
    ('TR200006', 'So Appalled', 'US100001', 'AL200040',  '56777290', '00:06:37'),
    ('TR200007', 'Devil In A New Dress', 'US100001', 'AL200040',  '149845195', '00:05:51'),
    ('TR200008', 'Runaway', 'US100001', 'AL200040',  '257065743', '00:09:07'),
    ('TR200009', 'Hell Of A Life', 'US100001', 'AL200040',  '52013608', '00:05:57'),
    ('TR200010', 'Blame Game', 'US100001', 'AL200040',  '59194177', '00:07:49'),
    ('TR200011', 'Lost In The World', 'US100001', 'AL200040',  '64306752', '00:04:16'),
    ('TR200012', 'Who Will Survive In America', 'US100001', 'AL200040',  '22872037', '00:01:38'),
    ('TR300000', 'thousand eyes', 'UK300001', 'AL300050',  '6768795', '00:05:00'),    
    ('TR300001', 'home with you', 'UK300001', 'AL300050',  '19512582', '00:03:44'),
    ('TR300002', 'sad day', 'UK300001', 'AL300050',  '14265127', '00:04:15'),
    ('TR300003', 'holy terrain', 'UK300001', 'AL300050',  '23542248', '00:04:03'),
    ('TR300004', 'mary magdalene', 'UK300001', 'AL300050',  '12360837', '00:05:21'),
    ('TR300005', 'fallen alien', 'UK300001', 'AL300050',  '8686828', '00:03:58'),
    ('TR300006', 'mirrored heart', 'UK300001', 'AL300050',  '8788902', '00:04:32'),
    ('TR300007', 'daybed', 'UK300001', 'AL300050',  '4272974', '00:04:31'),
    ('TR300008', 'cellophane', 'UK300001', 'AL300050',  '46974253', '00:03:24'),
    ('TR400000', 'Soundtrack 2 My Life', 'US450110', 'AL411100',  '188081667', '00:03:55'),
    ('TR400001', 'Solo Dolo (Nightmare)', 'US450110', 'AL411100',  '43855561', '00:04:26'),
    ('TR400002', 'Enter Galactic (Love Connection Part I)', 'US450110', 'AL411100',  '34631358', '00:04:20'),
    ('TR500000', '1985', 'US450101', 'AL411200',  '14032413', '00:02:32'),
    ('TR500001', 'Something to Rap About (feat. Tyler, The Creator)', 'US450101', 'AL411200',  '33393417', '00:04:42'),
    ('TR500002', 'All Glass', 'US450101', 'AL411200',  '3328214', '00:02:33'),
    ('TR600000', 'EARFQUAKE', 'US450112', 'AL411300',  '531822632', '00:03:10'),
    ('TR600001', 'A BOY IS A GUN*', 'US450112', 'AL411300',  '102214027', '00:03:30'),
    ('TR600002', 'I DONT LOVE YOU ANYMORE', 'US450112', 'AL411300',  '53411767', '00:02:41'),
    ('TR700000', 'With Them', 'US450106', 'AL411400',  '61147880', '00:03:17'),    
    ('TR700001', 'Drippin', 'US450106', 'AL411400',  '18260071', '00:03:06'),    
    ('TR700002', 'Digits', 'US450106', 'AL411400',  '187899147', '00:02:56'),
    ('TR800000', 'The Race', 'US450105', 'AL411500',  '280997458', '00:02:20'),
    ('TR800001', 'I <3 My Choppa', 'US450105', 'AL411500',  '64776382', '00:01:45'),
    ('TR800002', 'Lemonade', 'US450105', 'AL411500',  '54018302', '00:02:12'),
    ('TR900000', 'untitled 01 | 08.19.2014.','US450103', 'AL411600',  '24359044', '00:04:07'), 
    ('TR900001', 'untitled 02 | 06.23.2014.','US450103', 'AL411600',  '91019974', '00:04:18'),
    ('TR900002', 'untitled 03 | 05.28.2013.','US450103', 'AL411600',  '44088731', '00:02:34'),
    ('TR110000', 'Ultra Black (feat. Hit-Boy)' ,'US450104', 'AL411700',  '7833342', '00:03:18'),
    ('TR110001', 'Replace Me (feat. Big Sean & Don Toliver)' ,'US450104', 'AL411700',  '14035663', '00:02:50'),
    ('TR110002', 'All Bad (feat. Anderson .Paak)' ,'US450104', 'AL411700',  '7228537', '00:03:48'),
    ('TR120000', 'Feels Like Summer', 'US450109', 'AL411800',  '12898330','00:02:29'),
    ('TR120001', 'Outside!', 'US450109', 'AL411800',  '7887144','00:02:05'),
    ('TR120002', 'Dont Get Chipped', 'US450109', 'AL411800',  '10139044','00:02:28'),
    ('TR130000', 'CANCELLED (feat. Skepta)', 'UK450113', 'AL411900', '12237348','00:02:18'),     
    ('TR130001', 'i tried', 'UK450113', 'AL411900', '6590240','00:02:14'),     
    ('TR130002', 'nhs', 'UK450113', 'AL411900', '9586650','00:03:26'),
    ('TR140000', 'My Collection', 'US450102', 'AL411000', '31862722','00:04:15'),     
    ('TR140001', 'Keep Quiet', 'US450102', 'AL411000', '14240435','00:03:22'),     
    ('TR140002', 'Selfish (feat. Rihanna)', 'US450102', 'AL411000', '241756949','00:04:11'),
    ('TR150000', 'Fukk Sleep (feat. FKA Twigs)', 'US450107', 'AL134911', '143864900', '00:03:12'),     
    ('TR150001', 'CALLDROPS (feat. Kodak Black)', 'US450107', 'AL134911', '26307743','00:02:42'),     
    ('TR150002', 'Kids Turned Out Fine', 'US450107', 'AL134911', '47370966','00:03:03'),     
    ('TR160000', 'Rockstar Made', 'US450108', 'AL123499', '25078379','00:03:13'),     
    ('TR160001', 'Vamp Anthem', 'US450108', 'AL123499', '47925230','00:02:04'),     
    ('TR160002', 'F33l Lik3 Dyin', 'US450108', 'AL123499','11992560' , '00:03:24'),     
    ('TR170000', 'It Aint Safe', 'UK450111', 'AL125912', '33910346' , '00:03:43'),     
    ('TR170001', 'Numbers', 'UK450111', 'AL125912', '11771540', '00:03:18'),     
    ('TR170002', 'Shutdown', 'UK450111', 'AL125912','96450181' , '00:03:08'),
    ('TR180000', 'Beef Rap', 'UK450114', 'AL123459', '10104170' , '00:04:39'),     
    ('TR180001', 'One Beer', 'UK450114', 'AL123459', '29548845' , '00:04:18'),     
    ('TR180002', 'Kookies', 'UK450114', 'AL123459', '5924050' , '00:04:01'),     
    ('TR190000', 'Blue World', 'US501235', 'AL180923', '10104170' , '00:03:29'),     
    ('TR190001', 'I Can See', 'US501235', 'AL180923', '10104170' , '00:03:40'),     
    ('TR190002', 'Everybody', 'US501235', 'AL180923', '10104170' , '00:04:16'),   
    ('TR201000', 'Natal dos Simples', 'PT123009', 'AL581723', '10846' , '00:02:52'),
    ('TR201001', 'Balada do Sino', 'PT123009', 'AL581723', '3737' , '00:02:13'),     
    ('TR201002', 'Saudadinha', 'PT123009', 'AL581723', '3344' , '00:04:06'),     
    ('TR210000', 'Cantiga para Pedir Dois Tostões', 'PT123583', 'AL961234', '13781' , '00:02:24'),
    ('TR210001', 'Casa Conmigo Marta', 'PT123583', 'AL961234', '14414' , '00:04:14'),
    ('TR210002', 'Mudam-se os Tempos, Mudam-se as Vontades', 'PT123583', 'AL961234', '335344' , '00:02:50'),
    ('TR220000', 'The Rain Song', 'US424089', 'AL123758', '45304061' , '00:07:39'),     
    ('TR220001', 'Dancing Days', 'US424089', 'AL123758', '18223778' , '00:03:43'),     
    ('TR220002', 'The Ocean', 'US424089', 'AL123758', '37036145' , '00:04:31'),     
    ('TR230000', 'MTT 420 RR', 'UK142104', 'AL124674', '750483' , '00:05:30'),     
    ('TR230001', 'The Beachland Ballroom', 'UK142104', 'AL124674', '1140748' , '00:04:00'),     
    ('TR230002', 'Progress', 'UK142104', 'AL124674', '434487' , '00:03:46'),     
    ('TR240000', 'Body', 'AUS123491', 'AL168346', '10900365' , '00:05:07'),     
    ('TR240001', 'Pressure to Party', 'AUS123491', 'AL168346', '14348133' , '00:03:02'),     
    ('TR240002', 'Good Guy', 'AUS123491', 'AL168346', '3271631' , '00:04:11'),     
    ('TR250000', 'Shy Away', 'US123041', 'AL578912', '97495000' , '00:02:55'),     
    ('TR250001', 'The Outside', 'US123041', 'AL578912', '23427241' , '00:03:36'),     
    ('TR250002', 'Redecorate', 'US123041', 'AL578912', '19934449' , '00:04:05'),     
    ('TR260000', 'Cíume', 'PT125612', 'AL123851', '377680' , '00:03:38'),     
    ('TR260001', 'Maria Jorge', 'PT125612', 'AL123851', '49116' , '00:04:01'),     
    ('TR260002', 'A Bacalhau', 'PT125612', 'AL123851', '154950' , '00:03:04'),
    ('TR270000', 'Programs', 'US501235', NULL,  '65848701', '00:03:10'),
    ('TR280000', 'Life of The Party (with Andre 3000)','US100001', NULL,  '7207047', '00:06:31'),     
    ('TR400003', 'Cudi Zone', 'US450110', 'AL411100',  '63554505', '00:04:19'), 
    ('TR500003', 'Skinny Suge', 'US450101', 'AL411200',  '4957284', '00:02:52'),
    ('TR500004', 'Look At Me', 'US450101', 'AL411200',  '5270571', '00:02:33'),
    ('TR600003', 'PUPPET', 'US450112', 'AL411300',  '67468745', '00:02:59'),
    ('TR600004', 'WHATS GOOD', 'US450112', 'AL411300',  '63203726', '00:03:25'),
    ('TR600005', 'NEW MAGIC WAND', 'US450112', 'AL411300',  '123203348', '00:03:15'),
    ('TR700003', 'Memo', 'US450106', 'AL411400',  '54341091', '00:03:15'),
    ('TR700004', 'Drippin', 'US450106', 'AL411400',  '18327793', '00:03:15'),
    ('TR800003', 'Megamen', 'US450105', 'AL411500',  '45368503', '00:02:13'),
    ('TR900003', 'untitled 04 | 08.14.2014.','US450103', 'AL411600',  '23330584', '00:01:50'),
    ('TR900004', 'untitled 05 | 09.21.2013.','US450103', 'AL411600',  '30697009', '00:05:38'),
    ('TR120003', 'FUN!', 'US450109', 'AL411800',  '2699593','00:02:25'),
    ('TR120004', 'No Bleedin', 'US450109', 'AL411800',  '4590155','00:02:03'),
    ('TR120005', 'Run the Bands', 'US450109', 'AL411800',  '5591122','00:03:08'),
    ('TR130003', 'VEX', 'UK450113', 'AL411900', '3831113','00:02:18'),
    ('TR130004', 'WOT', 'UK450113', 'AL411900', '2941650','00:00:48'),
    ('TR150003', 'Buck Shots', 'US450107', 'AL134911', '34919163','00:02:47'),
    ('TR150004', 'Praise The Lord (feat. Skepta)', 'US450107', 'AL134911', '731687896','00:03:25'),
    ('TR150005', 'Tony Tone', 'US450107', 'AL134911', '51353598','00:03:28'),
    ('TR150006', 'OGBeeper', 'US450107', 'AL134911', '33087326','00:02:35'),
    ('TR160003', 'Beno!', 'US450108', 'AL123499', '215861230', '00:02:33'), 
    ('TR160004', 'Slay3r', 'US450108', 'AL123499', '32950637', '00:02:44'), 
    ('TR160005', 'JumpOutTheHouse', 'US450108', 'AL123499', '15338955', '00:01:33'),
    ('TR170003', 'Man', 'UK450111', 'AL125912','49848055' , '00:03:34'),
    ('TR170004', 'Detox', 'UK450111', 'AL125912','9089779' , '00:02:47'),
    ('TR170005', 'Text Me Back', 'UK450111', 'AL125912','7291572' , '00:04:24'),
    ('TR170006', 'Thats Not Me', 'UK450111', 'AL125912','81415434' , '00:03:05'),
    ('TR190003', 'WOODS', 'US501235', 'AL180923', '62362081' , '00:04:46'),
    ('TR190004', 'Good News', 'US501235', 'AL180923', '279710302' , '00:05:42'),
    ('TR220003', 'The Crung', 'US424089', 'AL123758', '9319707' , '00:03:17'), 
    ('TR220004', 'No Quarter', 'US424089', 'AL123758', '47208233' , '00:07:02'), 
    ('TR240003', 'Head Alone', 'AUS123491', 'AL168346', '6920199' , '00:02:58'),
    ('TR260003', 'Para Fora', 'PT125612', 'AL123851', '43741' , '00:03:20'),
    ('TR260004', 'Menina Rabina', 'PT125612', 'AL123851', '77753' , '00:02:28'),
    ('TR290000', 'Im Not Real','US501235', NULL,  '412207047', '00:03:31'),
    ('TR291000', 'Wesley Presley','US450102', NULL,  '612203017', '00:02:38'),
    ('TR123000', 'Contagious', 'US450106','AL411401','5691368','00:02:30'), 
    ('TR123001', 'YEA YEA YEA', 'US450106','AL411401','3329180','00:02:24'),  
    ('TR123002', 'Faces', 'US450106','AL411401','3230655','00:02:12'),  
    ('TR123003', 'Hate The Game', 'US450106','AL411401','4390120','00:02:44'),
    ('TR123004', 'Road Rage', 'US450106','AL411401','3681836','00:02:32'),
    ('TR141000', 'Long Time - Intro','US450108', 'AL223499','118034779', '00:03:31'),
    ('TR141001', 'R.I.P','US450108', 'AL223499','99258281', '00:03:12'),
    ('TR141002', 'Lean 4 Real','US450108', 'AL223499','47673949', '00:02:57'),
    ('TR141003', 'Old Money','US450108', 'AL223499','35093357', '00:02:15'),
    ('TR141004', 'FlatBed Fre3style','US450108', 'AL223499','99897826', '00:03:00'),
    ('TR141005', 'KOD','US450108', 'AL223499','388999371', '00:02:33'),
    ('TR141006', 'Pull Up','US450108', 'AL223499','31030979', '00:03:26'),
    ('TR820000', 'Inside Outside','US501235','AL280923','5917758','00:01:53'),
    ('TR820001', 'Here We Go','US501235','AL280923','8062056','00:02:47'),
    ('TR820002', 'Friends','US501235','AL280923','7918234','00:06:38'),
    ('TR820003', 'Angel Dust','US501235','AL280923','5322260','00:03:42'),
    ('TR923000', 'BLOOD.','US450103','AL411601', '93412062', '00:01:58'),
    ('TR923001', 'DNA.','US450103','AL411601', '796963991', '00:03:05'), 
    ('TR923002', 'ELEMENT.','US450103','AL411601', '93412062', '00:02:40'),
    ('TR444000', 'THE SHINNING','US450109','AL711800','5881704', '00:02:40'),
    ('TR444001', 'TAKING TRIPS','US450109','AL711800','5409391', '00:02:37'),
    ('TR444002', 'LIL FADE','US450109','AL711800','7261947', '00:02:46'),
    ('TR444003', 'MHM','US450109','AL711800','4475506', '00:02:11'),
    ('TR444004', 'TAKE ME HOME','US450109','AL711800','5715476', '00:02:12'),
    ('TR999999', 'RICH PROBLEMS','US450107',NULL, '24039922', '00:03:37'),
    ('TR888888', 'Gang Signs','US450101', NULL, '14833687', '00:02:46'),
    ('TR888885', 'High For This','CA100000','AL800000','196721991','00:04:09'),
    ('TR888886', 'The Morning', 'CA100000','AL800000','248700557','00:05:14'),
    ('TR888887', 'Wicked Games', 'CA100000','AL800000','374599439','00:05:25'),
    ('TR924000', 'RIP Young', 'US450115','AL900000','15914244','00:02:38'),
    ('TR924001', 'Headshots(4r Da Locals)','US450115','AL900000','26676933','00:03:13'),
    ('TR924002', '9-3 Freestyle','US450115','AL900000','4737866','00:01:45');
    

CREATE TABLE
GENRE_TRACK
(
  Track INT NOT NULL,
  Genre VARCHAR(32) NOT NULL,
  PRIMARY KEY(Track,Genre),
  FOREIGN KEY(Track) REFERENCES TRACK(Num) ON DELETE CASCADE
);

INSERT INTO GENRE_TRACK(Track, Genre)
VALUES
    (1,'Intro Track'), (1,'Música Portuguesa'), (1,'Trap'),
    (2,'Música Portuguesa'), (2,'Trap'),
    (3,'Música Portuguesa'), (3,'Trap'),
    (4,'Música Portuguesa'), (4,'Trap'),
    (5,'Música Portuguesa'), (5,'Trap'), (5,'Hit-Single'),
    (6,'Música Portuguesa'), (6,'Trap'),
    (7,'Música Portuguesa'), (7,'Trap'), (7,'Hit-Single'),
    (8,'Música Portuguesa'), (8,'Trap'),
    (9,'Música Portuguesa'), (9,'Trap'),
    (10,'Música Portuguesa'), (10,'Trap'),
    (11,'Intro Track'), (11,'Hip-Hop'), (11,'Conscious Hip-Hop'),
    (12,'Hip-Hop'), (12,'Conscious Hip-Hop'),
    (13,'Hip-Hop'), (13,'Conscious Hip-Hop'),
    (14,'Hip-Hop'), (14,'Conscious Hip-Hop'),
    (15,'Hip-Hop'), (15,'Conscious Hip-Hop'),
    (16,'Hip-Hop'), (16,'Conscious Hip-Hop'),
    (17,'Hip-Hop'), (17,'Conscious Hip-Hop'),
    (18,'Hip-Hop'), (18,'Conscious Hip-Hop'), (17,'Hit-Single'),
    (19,'Hip-Hop'), (19,'Conscious Hip-Hop'),
    (20,'Hip-Hop'), (20,'Conscious Hip-Hop'),
    (21,'Hip-Hop'), (21,'Conscious Hip-Hop'),
    (22,'Hip-Hop'), (22,'Conscious Hip-Hop'),
    (23,'Hip-Hop'), (23,'Conscious Hip-Hop'),
    (24,'R&B'), (24, 'Electronic R&B'),
    (25,'R&B'), (25, 'Electronic R&B'),
    (26,'R&B'), (26, 'Electronic R&B'),
    (27,'R&B'), (27, 'Electronic R&B'),
    (28,'R&B'), (28, 'Electronic R&B'),
    (29,'R&B'), (29, 'Electronic R&B'),
    (30,'R&B'), (30, 'Electronic R&B'),
    (31,'R&B'), (31, 'Electronic R&B'),
    (32,'R&B'), (32, 'Electronic R&B'),
    (33,'Hip-Hop'),(33,'Melodic Hip-Hop'),
    (34,'Hip-Hop'),(34,'Melodic Hip-Hop'), (34,'Depressive Hip-Hop'),
    (35,'Hip-Hop'),(35,'Melodic Hip-Hop'),
    (36,'Hip-Hop'),(36,'Jazz Hip-Hop'),
    (37,'Hip-Hop'),(37,'Melodic Hip-Hop'),(37,'Jazz Hip-Hop'),
    (38,'Hip-Hop'),(38,'Jazz Hip-Hop'),
    (39,'Hip-Hop'),(39,'Experimental Hip-Hop'),(39,'Hit-Single'),
    (40,'Hip-Hop'),(40,'Experimental Hip-Hop'),
    (41,'Hip-Hop'),(41,'Experimental Hip-Hop'),
    (42,'Trap'),(42,'Trap Hip-Hop'),
    (43,'Trap'),(43,'Trap Hip-Hop'),
    (44,'Trap'),(44,'Trap Hip-Hop'),
    (45,'Trap'),(45,'Trap Hip-Hop'),
    (46,'Trap'),(46,'Trap Hip-Hop'),
    (47,'Trap'),(47,'Trap Hip-Hop'),
    (48,'Hip-Hop'), (48,'Conscious Hip-Hop'),
    (49,'Hip-Hop'), (49,'Conscious Hip-Hop'),
    (50,'Hip-Hop'), (50,'Conscious Hip-Hop'),
    (51,'Hip-Hop'), (51,'Conscious Hip-Hop'),
    (52,'Hip-Hop'), (52,'Conscious Hip-Hop'),
    (53,'Hip-Hop'), (53,'Conscious Hip-Hop'),
    (54,'Hip-Hop'), (54,'Conscious Hip-Hop'), (54,'Southside Hip-Hop'),
    (55,'Hip-Hop'), (55,'Conscious Hip-Hop'), (55,'Southside Hip-Hop'),
    (56,'Hip-Hop'), (56,'Conscious Hip-Hop'), (56,'Southside Hip-Hop'),
    (57,'Hip-Hop'), (57,'Grime'),
    (58,'Hip-Hop'), (58,'Calm Hip-Hop'),
    (59,'Hip-Hop'), (59,'Calm Hip-Hop'),
    (60,'Hip-Hop'), (60,'Calm Hip-Hop'), (60,'Toxic Hip-Hop'), (60,'Melodic Hip-Hop'),
    (61,'Hip-Hop'), (61,'Calm Hip-Hop'), (61,'Toxic Hip-Hop'), (61,'Melodic Hip-Hop'),
    (62,'Hip-Hop'), (62,'Calm Hip-Hop'), (62,'Toxic Hip-Hop'), (62,'Melodic Hip-Hop'),
    (63,'Cloud Rap'), (63,'Experimental Hip-Hop'), (63,'Hip-Hop'),
    (64,'Cloud Rap'), (64,'Experimental Hip-Hop'), (64,'Hip-Hop'),
    (65,'Cloud Rap'), (65,'Experimental Hip-Hop'), (65,'Hip-Hop'),
    (66,'Experimental Hip-Hop'),(66,'Hardcore Hip-Hop'),
    (67,'Experimental Hip-Hop'),(67,'Hardcore Hip-Hop'),
    (68,'Experimental Hip-Hop'),(68,'Hardcore Hip-Hop'),(68,'Melodic Hip-Hop'),
    (69,'Grime'),(69,'UK Hip-Hop'),
    (70,'Grime'),(70,'UK Hip-Hop'),
    (71,'Grime'),(71,'UK Hip-Hop'),
    (72,'BoomBap'), (72,'Classic Hip-Hop'),
    (73,'BoomBap'), (73,'Classic Hip-Hop'),
    (74,'BoomBap'), (74,'Classic Hip-Hop'),
    (75,'Electronic Hip-Hop'), (75,'Melodic Hip-Hop'), 
    (76,'Melodic Hip-Hop'), (76,'Pop'),
    (77,'Melodic Hip-Hop'), (77,'Pop'), (77,'Cover'),
    (78,'Música Portuguesa'),(78,'Fado'),(78,'Christmas'),
    (79,'Música Portuguesa'),(79,'Fado'),
    (80,'Música Portuguesa'),(80,'Fado'),
    (81,'Música Portuguesa'),(81,'Fado'),
    (82,'Música Portuguesa'),(82,'Fado'),
    (83,'Música Portuguesa'),(83,'Fado'),(83,'Protest Song'),
    (84,'Rock'), (84,'Melodic Rock'),
    (85,'Rock'), (85,'Melodic Rock'),
    (86,'Rock'), (86,'Melodic Rock'),
    (87,'Rock'), (87,'Punk Rock'),
    (88,'Rock'), (88,'Punk Rock'),
    (89,'Rock'), (89,'Punk Rock'), (89,'Melodic Rock'),
    (90,'Folk'), (90,'Australian Music'),
    (91,'Folk'), (91,'Australian Music'),
    (92,'Folk'), (92,'Australian Music'),
    (93,'Indie'),(93,'Alt-Rock'),
    (94,'Indie'),(94,'Alt-Rock'),
    (95,'Indie'),(95,'Alt-Rock'),
    (96,'Música Portuguesa'), (96,'Fado'),
    (97,'Música Portuguesa'), (97,'Fado'),
    (98,'Música Portuguesa'), (98,'Fado'),
    (99,'Trap Hip-Hop'), (99,'Single'),
    (100,'Hip-Hop'),(100,'Conscious Hip-Hop'),(100,'Single'),
    (101,'Hip-Hop'),(101,'Melodic Hip-Hop'), 
    (102,'Hip-Hop'),(102,'Experimental Hip-Hop'),
    (103,'Hip-Hop'),(103,'Experimental Hip-Hop'),
    (104,'Hip-Hop'),(104,'Experimental Hip-Hop'),
    (105,'Hip-Hop'),(105,'Experimental Hip-Hop'),
    (106,'Hip-Hop'),(106,'Experimental Hip-Hop'),
    (107,'Trap'), (107,'Trap Hip-Hop'),
    (108,'Trap'), (108,'Trap Hip-Hop'),
    (109,'Trap'),(109,'Trap Hip-Hop'),
    (110,'Hip-Hop'), (110,'Calm Hip-Hop'), (110,'Toxic Hip-Hop'), (110,'Melodic Hip-Hop'),
    (111,'Hip-Hop'), (111,'Southside Hip-Hop'), (111,'Conscious Hip-Hop'), (111,'Melodic Hip-Hop'),
    (112,'Hip-Hop'), (112,'Conscious Hip-Hop'), (112,'Southside Hip-Hop'),
    (113,'Hip-Hop'), (113,'Conscious Hip-Hop'), (113,'Southside Hip-Hop'),
    (114,'Hip-Hop'), (114,'Conscious Hip-Hop'), (114,'Southside Hip-Hop'),
    (115,'Hip-Hop'), (115,'Hardcore Hip-Hop'),
    (116,'Hip-Hop'), (116,'Hardcore Hip-Hop'),
    (117,'Cloud Rap'), (117,'Experimental Hip-Hop'), (117,'Hip-Hop'),
    (118,'Cloud Rap'), (118,'Experimental Hip-Hop'), (118,'Hip-Hop'), 
    (119,'Cloud Rap'), (119,'Experimental Hip-Hop'), (119,'Hip-Hop'),
    (120,'Experimental Hip-Hop'),(120,'Hardcore Hip-Hop'),
    (121,'Experimental Hip-Hop'),(121,'Hardcore Hip-Hop'),
    (122,'Experimental Hip-Hop'),(122,'Hardcore Hip-Hop'),
    (123,'Experimental Hip-Hop'),(123,'Hardcore Hip-Hop'),
    (124,'Grime'),(124,'UK Hip-Hop'),
    (125,'Grime'),(125,'UK Hip-Hop'),
    (126,'Grime'),(126,'UK Hip-Hop'),
    (127,'Grime'), (127,'UK Hip-Hop'), 
    (128,'Electronic Hip-Hop'), (128,'Melodic Hip-Hop'), 
    (129,'Melodic'), (129,'Singing'),
    (130,'Rock'), (130,'Melodic Rock'),
    (131,'Rock'), (131,'Melodic Rock'),
    (132,'Folk'), (132,'Australian Music'),
    (133,'Música Portuguesa'), (133,'Fado'),
    (134,'Música Portuguesa'), (134,'Fado'),
    (135, 'Trap'), (135, 'Trap Hip-Hop'),
    (136,'Trap Hip-Hop'), (136,'Hip-Hop'),
    (137,'Trap Hip-Hop'), (137,'Hip-Hop'),
    (138,'Trap Hip-Hop'), (138,'Hip-Hop'),
    (139,'Trap Hip-Hop'), (139,'Hip-Hop'),
    (140,'Trap Hip-Hop'), (140,'Hip-Hop'),
    (141,'Intro Track'),
    (141,'Southside Hip-Hop'),(141,'Trap Hip-Hop'),
    (142,'Southside Hip-Hop'),(142,'Trap Hip-Hop'),
    (143,'Southside Hip-Hop'),(143,'Trap Hip-Hop'),
    (144,'Southside Hip-Hop'),(144,'Trap Hip-Hop'),
    (145,'Southside Hip-Hop'),(145,'Trap Hip-Hop'),
    (146,'Southside Hip-Hop'),(146,'Trap Hip-Hop'),
    (147,'Southside Hip-Hop'),(147,'Trap Hip-Hop'),
    (148, 'R&B'),(148, 'Eletronic R&B'),(148,'Experimental Hip-Hop'),
    (149, 'R&B'),(149, 'Eletronic R&B'),(149,'Experimental Hip-Hop'),
    (150, 'R&B'),(150, 'Eletronic R&B'),(150,'Experimental Hip-Hop'), 
    (151, 'R&B'),(151, 'Eletronic R&B'),(151,'Experimental Hip-Hop'),
    (152,'Experimental Hip-Hop'), (152, 'Conscious Hip-Hop'),
    (153,'Experimental Hip-Hop'), (153, 'Conscious Hip-Hop'),(153, 'Hip-Hop'),
    (154,'Experimental Hip-Hop'), (154, 'Conscious Hip-Hop'),
    (155, 'Experimental Hip-Hop'), (155,'Melodic Hip-Hop'),  
    (156, 'Experimental Hip-Hop'), (156,'Melodic Hip-Hop'),
    (157, 'Experimental Hip-Hop'), (157,'Melodic Hip-Hop'),
    (158, 'Experimental Hip-Hop'), (158,'Melodic Hip-Hop'),
    (159, 'Experimental Hip-Hop'), (159,'Melodic Hip-Hop'),
    (160, 'Conscious Hip-Hop'),(160, 'Hip-Hop'),
    (161, 'Melodic Hip-Hop'),
    (162, 'R&B'), (162, 'Melodic R&B'),
    (163, 'R&B'), (163, 'Melodic R&B'),
    (164, 'R&B'), (164, 'Melodic R&B'),
    (165, 'Hip-Hop'), (165, 'Melodic Hip-Hop'), (165, 'Experimental Hip-Hop'),
    (166, 'Hip-Hop'), (166, 'Melodic Hip-Hop'), (166, 'Experimental Hip-Hop'),
    (167, 'Hip-Hop'), (167, 'Melodic Hip-Hop'), (167, 'Experimental Hip-Hop');
   
CREATE TABLE
PLAYLIST
(
    Num          INT AUTO_INCREMENT,
    Play_ID      VARCHAR(32) UNIQUE NOT NULL,      -- ID da playlist
    Play_Title   VARCHAR(64) NOT NULL,             -- Título da playlist
    Play_Desc    VARCHAR(256) DEFAULT NULL,        -- Descrição da playlist
    Play_User    VARCHAR(16) NOT NULL,             -- User da playlist
    PRIMARY KEY(Num,Play_ID),
    FOREIGN KEY(Play_User) REFERENCES USER(Login) ON DELETE CASCADE
);

INSERT INTO PLAYLIST(Play_ID, Play_Title, Play_Desc, Play_User)
VALUES
    ('PL10000', 'Playlist1', 'Teste de Playlist', 'jsantos'),
    ('PL11000', 'Bangerzões', 'Apenas os melhores sonoros','sandeIlidio'),
    ('PL12000', 'Best Album Ever', 'Theres no one better than Kanye West','kanyewest'),
    ('PL13000', 'Gaming Songs', 'Songs to listen to while playing videogames.','gamergirl39'),
    ('PL14000', 'Músicas do Abel', NULL, 'abel1973'),
    ('PL15000', 'Trap', 'Trapalhadas', 'tteixeira'),
    ('PL16000', 'Study Session', 'Music that helps me study','malucoze'),
    ('PL17000', 'Cozy Tapes', 'Help to fall asleep','escarlos4');

CREATE TABLE
PLAYLIST_TEST                                       -- Relação entre músicas e playlist.
(
    IDPlaylist  VARCHAR(32) NOT NULL,               -- ID da Playlist 
    IDTrack     VARCHAR(32) NOT NULL,               -- ID da música
    PRIMARY KEY(IDPlaylist,IDTrack),
    FOREIGN KEY(IDPlaylist) REFERENCES PLAYLIST(Play_ID) ON DELETE CASCADE,
    FOREIGN KEY(IDTrack) REFERENCES TRACK(Track_ID) ON DELETE CASCADE
);  
INSERT INTO PLAYLIST_TEST(IDPlaylist,IDTrack)
VALUES
    ('PL10000','TR100005'),
    ('PL10000','TR200003'),
    ('PL10000','TR110002'),
    ('PL10000','TR180000'),
    ('PL11000','TR110001'),
    ('PL11000','TR160000'),
    ('PL11000','TR160001'),
    ('PL11000','TR160002'),
    ('PL11000','TR210002'),
    ('PL11000','TR120001'),
    ('PL11000','TR500001'),
    ('PL11000','TR200011'),
    ('PL12000','TR200000'),
    ('PL12000','TR200001'),
    ('PL12000','TR200002'),
    ('PL12000','TR200003'),
    ('PL12000','TR999999'), 
    ('PL12000','TR200004'),
    ('PL12000','TR200005'),
    ('PL12000','TR200006'),
    ('PL12000','TR200007'),
    ('PL12000','TR200008'),
    ('PL12000','TR200009'),
    ('PL12000','TR200010'),
    ('PL12000','TR200011'),
    ('PL12000','TR200012'),
    ('PL13000','TR300006'),
    ('PL13000','TR700001'),
    ('PL13000','TR110002'),
    ('PL13000','TR140001'),
    ('PL13000','TR160001'),
    ('PL13000','TR160002'),
    ('PL13000','TR180000'),
    ('PL14000', 'TR100004'),
    ('PL14000', 'TR888888'),
    ('PL14000', 'TR300003'),
    ('PL14000', 'TR200008'),
    ('PL14000', 'TR700002'),
    ('PL14000', 'TR130000'),
    ('PL14000', 'TR170001'),
    ('PL14000', 'TR230001'),
    ('PL14000', 'TR230002'),
    ('PL14000', 'TR201000'),
    ('PL14000', 'TR160002'),
    ('PL14000', 'TR160000'),
    ('PL14000', 'TR250000'),
    ('PL14000', 'TR260001'),
    ('PL14000', 'TR270000'),
    ('PL14000', 'TR280000'),
    ('PL15000', 'TR100001'),
    ('PL15000', 'TR100005'),
    ('PL15000', 'TR100006'),
    ('PL15000', 'TR100009'),
    ('PL15000', 'TR700000'),
    ('PL15000', 'TR700001'),
    ('PL15000', 'TR700002'),
    ('PL15000', 'TR800000'),
    ('PL15000', 'TR800002'),
    ('PL16000', 'TR444004'),
    ('PL16000', 'TR444000'),
    ('PL16000', 'TR140000'),
    ('PL16000', 'TR123003'),
    ('PL16000', 'TR220003'),
    ('PL16000', 'TR150005'),
    ('PL16000', 'TR291000'),
    ('PL16000', 'TR160004'),
    ('PL17000', 'TR140001'),
    ('PL17000', 'TR260002'),
    ('PL17000', 'TR600004'),
    ('PL17000', 'TR400003'),
    ('PL17000', 'TR700003'),
    ('PL17000', 'TR130003'), 
    ('PL17000', 'TR150004'),
    ('PL17000', 'TR160005'),
    ('PL17000', 'TR201001'),
    ('PL17000', 'TR130001'),
    ('PL17000', 'TR100002');

CREATE TABLE
FOLLOWER                        -- Relação de Utilizador segue outro Utilizador
(
  User INT NOT NULL,            -- ID numérico do utilizador que segue
  Follower INT NOT NULL,        -- ID numérico do utilizador seguido        
  PRIMARY KEY(User,Follower),
  FOREIGN KEY(User) REFERENCES USER(Num) ON DELETE CASCADE,
  FOREIGN KEY(Follower) REFERENCES USER(Num) ON DELETE CASCADE
);
INSERT INTO FOLLOWER(User, Follower)
VALUES
    (1,2),(2,1),(6,12),(13,17),(3,7),(4,9),(10,17),(1,17),(2,17),(9,10),(17,10),(7,3),(9,12),(1,10);

CREATE TABLE 
FOLLOW_ARTIST                       -- Relação de utilizador segue artista
(           
    User INT NOT NULL,              -- ID numérico do utilizador que segue
    Artista INT NOT NULL,           -- ID numérico do artista seguido
    PRIMARY KEY (User, Artista),
    FOREIGN KEY(User) REFERENCES USER(Num) ON DELETE CASCADE,
    FOREIGN KEY(Artista) REFERENCES ARTIST(Num) ON DELETE CASCADE
);
INSERT INTO FOLLOW_ARTIST(User, Artista)
VALUES
    (1,2), (2,6), (5,10), (10,12), (15,24), (17,10), (4,5),(1,15),(2,15),(7,22);

CREATE TABLE
LIKE_ALBUM                      -- Relação de utilizador gosta de um álbum
(
    User INT NOT NULL,          -- Id numérico do utilizador que gosta
    Album INT NOT NULL,         -- ID numérico do álbum gostado
    PRIMARY KEY (User, Album),
    FOREIGN KEY(User) REFERENCES USER(Num) ON DELETE CASCADE,
    FOREIGN KEY(Album) REFERENCES ALBUM(Num) ON DELETE CASCADE
);
INSERT INTO LIKE_ALBUM(User, Album)
VALUES
    (1,5),(2,7),(1,20),(5,21),(10,5),(15,2),(15,3),(15,10),(1,7),(2,9),(12,12),(12,20);

CREATE TABLE 
FOLLOW_PLAYLIST                 -- Relação entre utilizador que segue uma playlist
(
    User INT NOT NULL,          -- ID numérico do utilizador que segue
    Playlist INT NOT NULL,      -- ID numerico da playlist seguida.
    PRIMARY KEY (User, Playlist),
    FOREIGN KEY(User) REFERENCES USER(Num) ON DELETE CASCADE,
    FOREIGN KEY(Playlist) REFERENCES PLAYLIST(Num) ON DELETE CASCADE
);
INSERT INTO FOLLOW_PLAYLIST(User, Playlist)
VALUES
    (1,2), (2,2), (10,5),(10,4),(7,5),(7,6),(12,4), (18,5),(11,4),(19,5);

