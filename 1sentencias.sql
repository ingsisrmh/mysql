--crear herramientas que hagan una sola cosa y que la hagan bien.

--ingreso
$ mysql -h localhost -u usuario -p

--salir
mysql> quit;

--consulta usuario, conexión, versión, base de datos
mysql> select user(), connection_id(), version(), database();

--consulta fecha y hora, usuario
select now(); select user();

--consulta fecha y hora
mysql> select now();

--cadenas de carácteres
mysql> select "Hola mundo", 'Felicidades';
mysql> select "Este es un texto
       "> en dos renglones'';

--cancelar un comando
mysql> select "Este es un texto
"> \c
"> " \c
mysql>

--expresiones y varaibles de sesión
mysql> select @x := 1;
mysql select @x, sqrt(@x), sin(@x), @x+10, @x>10;

mysql> select @hora_ingreso := now();
mysql select now() - @hora_ingreso;

--cargar un lotes de sentencias
$ mysql -u usuario -h localhost -p < demo.sql

--otra forma de cargarlos
mysql> source demo.sql

--comentar una línea con #
# create database demo;

--sentencias del archivo
#drop database demo;
create database demo;
use demo;

--estructura de la tabla productos

create table productos
(
	parte varchar(20),
	tipo varchar(20),
	especificación varchar(20),
	psugerido float(6,2),
	clave int(3) zerofill not null auto_increment,
	primary key(clave)
);

insert into productos
(
	parte, tipo, especificación, psugerido
)
values
	('Procesador', '2 GHz', '32 bits', null),
	('Procesador', '2.4 GHz', '32 bits', 35),
	('Procesador', '1.7 GHz', '64 bits', 205),
	('Procesador', '3 GHz', '64 bits', 560),
	('RAM', '128MB','333 MHz', 10),
	('RAM', '256MB', '400 MHz', 35),
	('Disco Duro', '80 GB', '7200 rpm', 60),
	('Disco Duro', '120 GB', '7200 rpm', 78),
	('Disco Duro', '200 GB', '7200 rpm' 110),
	('Disco Duro', '40 GB', '4200 rpm', null),
	('Monitor', '1024x876', '75 Hz', 80),
	('Monitor', '1024x876', '60 Hz', 67);
	
--estrucutra de la tabla 'proveedor'

create table proveedores
(
	empresa varchar(20) not null,
	pago set('crédito','efectivo'),
	primary key (empresa)
);

--valores de la tabla 'proveedor'

insert into proveedores (empresa, pago) values
	('Tecno-k', 'crédito'),
	('Patito', 'efectivo'),
	('Nacional', 'crédito, efectivo');

create table ganancia
(
	venta enum('Por mayor', 'Por menor'),
	factor decimal(2, 2)
);

insert into ganancia values
	('Por mayor', 1.05),
	('Por menor', 1.12);

create table precios
(
	empresa varchar(20) not null,
	clave int(3) zerofill not null,
	precio float(6,2),
	foreign key (empresa) references proveedores,
	foreign key (clave) references productos
);

insert into precios values
	('Nacional', 001, 30.82),
	('Nacional', 002, 32.73),
	('Nacional', 003, 202.25),
	('Nacional', 005, 9.76),
	('Nacional', 006, 31.52),
	('Nacional', 007, 58.41),
	('Nacional', 010, 64.38),
	('Patito', 001, 30.40),
	('Patito', 002, 33.63),
	('Patito', 003, 195.59),
	('Patito', 005, 9.78),
	('Patito', 006, 32.44),
	('Patito', 007, 59.99),
	('Patito', 010, 62.02),
	('Tecno-k', 003, 198.34),
	('Tecno-k', 005, 9.27),
	('Tecno-k', 006, 34.85),
	('Tecno-k', 007, 34.85),
	('Tecno-k', 010, 61.22),
	('Tecno-k', 012, 62.29);

--para guardar todos los comandos y resultados en un archivo
mysql> tee archivo_registro.txt

--para cancelar la captura
mysql> notes

--ver información sobre la base de datos actualmente en uso
mysql> select database();

--ver bases de datos existentes
mysql> show databases;

-- seleccionar una base de datos:
mysql> use demo;

--seleccionar la base de datos al iniciar la sesión en mysql
mysql> demo -u juan -p

--consultar las tablas
mysql> show tables;

--consultar las columnas cada tabla
mysql> describe productos;

--crear una base de datos
mysql> create database prueba;

--eliminar una base de datos
mysql> drop database prueba;

--crear la tabla personas
mysql> create table personas
->(
-> nombre char(30),
-> dirección char(40),
->teléfono char(15)
->);

-- eliminar la tabla pesonas
mysql> drop table personas;

--comprobar si existe, antes de eliminarla tabla
mysql> drop table if exists personas;

--atributos de columna
null --Se permiten valores nulos, atributo por omisión si no se especifica lo contrario.
not null --No se permiten valores nulos.
default valor --valor por omisión que se asigna a la columna.
auto_increment --El valor se asigna automáticamente incrementando en uno el máximo valor registrado hasta ahora. Se aplica sólo a las columnas marcadas como clave primaria
primary key --Señala al campo como clave primaria, implícitamente también lo declara como not null.

--creación de la tabla personas con diferentes atributos en las columnas
mysql> create table personas
-> (
-> nombre varchar(40) not null,
-> dirección varchar(50) null,
-> edo_civil char(13) default 'Soltero',
-> num_registro int primary key auto_increment,
-> );

--especificar restricciones sobre la tabla
mysql> create table personas
-> (
-> nombre varchar(40) not null,
-> nacimiento date not null,
-> pareja varchar(40),
-> preveedor int not null,
->
-> primary key (nombre, nacimiento),
-> unique (pareja),
-> foreign key (proveedor) references proveedores
-> );

primary key -- Defina las o las colunas que servirán como primaria.
			-- Las columnas que forman parte de la clave primaria deben
			-- de ser not null.

unique		-- Define las columnas en las que no pueden duplicarse valores.
			-- Serán las claves candidatas del modelo relacional
			
foreign key (columna)		--Define que los valores de columna se pemitiran sólo si existen
references tabla (columna2)	--en tabla(columna2). Es decir, columna hace referencia a los
							--registros de tabla, esto asegura que no se realicen referencias
							--a registros que no existen

--ejemplo de tabla universitario
create table universitario
(
id bigint(20) not null auto_increment,
cedula varchar(12) not null,
nombre varchar(60) default null,
paterno varchar(60) default null,
materno varchar(60) default null,
carrera varchar(100) default null,
primary key (id)
);

insert into universitario values (301, '5522478576', 'Libia', 'Katari', 'Reynoso', 'Enfermeria');
insert into universitario values (302, '6757218827', 'Lizzet', 'Rico', 'Surco', 'Ingenieria Quimica');
insert into universitario values (303, '3501621553', 'Anibal', 'Himmler', 'Rufino', 'Enfermeria');
insert into universitario values (304, '0760176438', 'Lena', 'Jimenez', 'Poquechoque', 'Arquitectura');
insert into universitario values (305, '1772230531', 'Lina', 'Kenjo', 'Llusco', 'Ingenieria Quimica');
insert into universitario values (326, '1071742326', 'Hilarion', 'Surco', 'Jimenez', 'Derecho');
insert into universitario values (327, '1651117538', 'Fernando', 'Kenjo', 'Fuertes', 'Farmacia');
insert into universitario values (328, '4727502832', 'Rei', 'Simpson', 'Fortuna', 'Medicina');
insert into universitario values (329, '2634301352', 'Paola', 'Altamirano', 'Fortuna', 'Farmacia');
insert into universitario values (330, '4060826165', 'Laura', 'Gorgori', 'Ikari', 'Administración de Empresas');
insert into universitario values (331, '6562441148', 'Reyna', 'Alvis', 'Himmler', 'Agronomia');
insert into universitario values (332, '2278381772', 'Lena', 'Altamirano', 'Kenjo', 'Administración de Empresas');
insert into universitario values (333, '8554161628', 'Laura', 'Aviles', 'Llusco', 'Administración de Empresas');
insert into universitario values (334, '0002738271', 'Oscar', 'Camara', 'Katari', 'Gas y Petroleo');
insert into universitario values (335, '2673648388', 'Lena', 'Fortuna', 'Altamirano', 'Agronomia');
insert into universitario values (336, '3605678426', 'Lizzet', 'Zanabria', 'Callaza', 'Economia');
insert into universitario values (337, '1543513701', 'Fernando', 'Katari', 'Simpson', 'Diseño de Interiores');
insert into universitario values (338, '3877833273', 'Fernando', 'Camara', 'Chipana', 'Agronomia');
insert into universitario values (339, '5524582347', 'Oscar', 'Brinco', 'Chavez', 'Gas y Petroleo');
insert into universitario values (340, '7532852006', 'Cesar', 'Brinco', 'Ikari', 'Ingenieria de Sistemas');
insert into universitario values (341, '4740118030', 'Rei', 'Chive', 'Gorgori', 'Enfermeria');
insert into universitario values (342, '5663577704', 'Paola', 'Paravicini', 'Flanders', 'Derecho');
insert into universitario values (343, '5742610002', 'David', 'Brinco', 'Jimenez', 'Economia');
insert into universitario values (344, '3740560251', 'Pedro', 'Sanchez', 'Brinco', 'Agronomia');
insert into universitario values (345, '1681801012', 'Lula', 'Chive', 'Langley', 'Odontologia');
insert into universitario values (346, '0454664741', 'Bryan', 'Brinco', 'Jimenez', 'Ingenieria Quimica');

