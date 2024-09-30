-- CREACION DE TABLAS

create database wanted_prices2;

use wanted_prices2;

drop database wanted_prices2;

CREATE TABLE Host
(
	ID_Host int NOT NULL AUTO_INCREMENT,
    Nombre_H varchar(30) NOT NULL,
    ApellidoP_H varchar(20) NOT NULL,
    ApellidoM_H varchar(20) NOT NULL,
    Telefono_H int(10) NOT NULL,
    Direccion_H varchar(40) NOT NULL,
	PRIMARY KEY(ID_Host)
);

CREATE TABLE Proveedor
(
	ID_Prov int NOT NULL AUTO_INCREMENT,
    Nombre_P varchar(30) NOT NULL,
    Apellidos_P varchar(30) NOT NULL,
    Telefono_P int(10) NOT NULL,
    Direccion_P varchar(40) NOT NULL,
    ID_Host int,
    FOREIGN KEY(ID_Host) REFERENCES Host(ID_Host),
    PRIMARY KEY(ID_Prov)
);

CREATE TABLE Contrato_P
(
	ID_ContP int NOT NULL AUTO_INCREMENT,
    Nombre_cont varchar(30) NOT NULL,
    Fecha date NOT NULL,
    ID_Host int,
    ID_Prov int,
    FOREIGN KEY(ID_Host) REFERENCES Host(ID_Host),
    FOREIGN KEY(ID_Prov) REFERENCES Proveedor(ID_Prov),
    PRIMARY KEY(ID_ContP)
);

CREATE TABLE Surte
(
	ID_Surte int NOT NULL AUTO_INCREMENT,
    Fecha_S date NOT NULL,
    Hora_S time NOT NULL,
    ID_Prov int,
    FOREIGN KEY(ID_Prov) REFERENCES Proveedor(ID_Prov),
    PRIMARY KEY(ID_Surte)
);

CREATE TABLE Mercancia
(
	ID_Mercancia int NOT NULL AUTO_INCREMENT,
    Nombre_M varchar(30) NOT NULL,
    Precio_M double NOT NULL,
    Descripcion_M varchar(100) NOT NULL,
    Cantidad_M int NOT NULL,
    ID_Prov int,
    ID_Surte int,
    FOREIGN KEY(ID_Prov) REFERENCES Proveedor(ID_Prov),
    FOREIGN KEY(ID_Surte) REFERENCES Surte(ID_Surte),
    PRIMARY KEY(ID_Mercancia)
);

CREATE TABLE Horario
(
	ID_Horario int,
    Hora_Entrada time,
    Hora_Salida time,
    PRIMARY KEY(ID_Horario)
);

CREATE TABLE Area_de_Trabajo
(
	ID_AT int NOT NULL AUTO_INCREMENT,
    Nombre_AT varchar(30),
    ID_Host int,
    ID_Horario int, 
    FOREIGN KEY(ID_Host) REFERENCES Host(ID_Host),
    FOREIGN KEY(ID_Horario) REFERENCES Horario(ID_Horario),
    PRIMARY KEY(ID_AT)
);

CREATE TABLE Vendedor
(
	ID_Vendedor int NOT NULL AUTO_INCREMENT,
    Nombre_V varchar(30),
    ApellidoP_V varchar(15),
    ApellidoM_V varchar(15),
    telefono_V int(10),
    Direccion_V varchar(40),
    ID_Host int,
    ID_Mercancia int,
    ID_Horario int,
    ID_AT int,
    FOREIGN KEY(ID_Host) REFERENCES Host(ID_Host),
    FOREIGN KEY(ID_Mercancia) REFERENCES Mercancia(ID_Mercancia),
    FOREIGN KEY(ID_Horario) REFERENCES Horario(ID_Horario),
    FOREIGN KEY(ID_AT) REFERENCES Area_de_Trabajo(ID_AT),
    PRIMARY KEY(ID_Vendedor)
);
    
CREATE TABLE Contrato_V
(
	ID_ContV int NOT NULL AUTO_INCREMENT,
    Nombre_contV varchar(20),
    Fecha_contV date,
    ID_Host int,
    ID_Vendedor int,
    FOREIGN KEY(ID_Host) REFERENCES Host(ID_Host),
    FOREIGN KEY(ID_Vendedor) REFERENCES Vendedor(ID_Vendedor),
    PRIMARY KEY(ID_ContV)
);

CREATE TABLE Seleccion_V
(
	ID_SeleV int NOT NULL AUTO_INCREMENT,
    ID_Vendedor int,
    ID_Horario int,
    ID_AT int,
    FOREIGN KEY(ID_Vendedor) REFERENCES Vendedor(ID_Vendedor),
    FOREIGN KEY(ID_Horario) REFERENCES Horario(ID_Horario),
	FOREIGN KEY(ID_AT) REFERENCES Area_de_Trabajo(ID_AT),
    PRIMARY KEY(ID_SeleV)
);

CREATE TABLE Seleccion_M
(
	ID_SeleM int NOT NULL AUTO_INCREMENT,
    ID_Vendedor int,
    ID_Mercancia int,
	FOREIGN KEY(ID_Vendedor) REFERENCES Vendedor(ID_Vendedor),
	FOREIGN KEY(ID_Mercancia) REFERENCES Mercancia(ID_Mercancia),
    PRIMARY KEY(ID_SeleM)
);

CREATE TABLE Cliente
(
	ID_Cliente int NOT NULL AUTO_INCREMENT,
    Nombre_C varchar(30) NOT NULL,
    Apellidos_C varchar (40) NOT NULL,
    Telefono_C int(10) NOT NULL,
    ID_Vendedor int,
	FOREIGN KEY(ID_Vendedor) REFERENCES Vendedor(ID_Vendedor),
    PRIMARY KEY(ID_Cliente)
);

CREATE TABLE Ventas
(
	ID_Ventas int NOT NULL AUTO_INCREMENT,
    ID_Cliente int,
    ID_Mercancia int,
    ID_Vendedor int,
	FOREIGN KEY(ID_Vendedor) REFERENCES Vendedor(ID_Vendedor),
    FOREIGN KEY(ID_Mercancia) REFERENCES Mercancia(ID_Mercancia),
    FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente),
    PRIMARY KEY(ID_Ventas)
);
    
CREATE TABLE Compras
(
	ID_Compras int NOT NULL AUTO_INCREMENT,
    Cantidad_C int NOT NULL,
    Total_G double NOT NULL,
    ID_Cliente int,
    ID_Mercancia int,
    ID_Ventas int, 
	FOREIGN KEY(ID_Mercancia) REFERENCES Mercancia(ID_Mercancia),
    FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente),
	FOREIGN KEY(ID_Ventas) REFERENCES Ventas(ID_Ventas),
    PRIMARY KEY(ID_Compras)
);

CREATE TABLE Consigue
(
	ID_Consigue int NOT NULL AUTO_INCREMENT,
    ID_Vendedor int,
    ID_Ventas int,
    FOREIGN KEY(ID_Ventas) REFERENCES Ventas(ID_Ventas),
    FOREIGN KEY(ID_Vendedor) REFERENCES Vendedor(ID_Vendedor),
    PRIMARY KEY(ID_Consigue)
);
    
///////////////////////////////////////////////////////////////////////////////////
-- LLENADO DE TABLAS

insert into host values
(null, 'luis armando', 'villanueva', 'garcia', 811844478, 'mar caspio 8564 mty'),
(null, 'diego alonso', 'villanueva', 'garcia', 811127417, 'mar caspio 8564 mty'),
(null, 'jose luis', 'avila', 'garcia', 815789468, 'malvina 5781 gpe'),
(null, 'moises miguel', 'hernandez', 'figueroa', 819786152, 'londres 8752 gpe'),
(null, 'damian', 'guerra', 'avila', 818574687, 'murcia 5741 san nicolas'),
(null, 'aide monserrat', 'longoria', 'perez', 814975824 , '5581 Graceland gpe'),
(null, 'miguel', 'cortez', 'cervantes',  814976324, '8120 Hallows Terrace mty'),
(null, 'itzel sofia', 'lopez', 'martinez', 811278491, '83 Messerschmidt apodaca'),
(null, 'jonatan', 'sandoval', 'muelle', 814792582, '98 Hallows escobedo'),
(null, 'diego', 'espejel', 'manzano', 814529376, '3 Gale garcia'),
(null, 'luis daniel', 'servantes', 'medina',  813645825, '8645 Jenna san pedro'),
(null, 'guillermo', 'villalobos', 'puerta',  521487595, '66651 International garcia'),
(null, 'santiago alexis', 'vegas', 'silla', 817954863, '71975 Dunning saltillo');

select * from host;

insert into proveedor values
(null, 'miguel', 'martinez', 815728946, 'puerto rico 581 gpe', 1), 
(null, 'manuel', 'hernandez', 811254785, 'puerto 752 garcia', 2), 
(null, 'luis daniel', 'villa', 819645885, 'pampas 9485 garcia', 5), 
(null, 'manuel', 'hernandez', 811254785, 'puerto 752 garcia', 3), 
(null, 'jose daniel', 'oliva', 813578945, 'murcia 5684 sanicolas', 2),
(null, 'ricardo', 'montes', 815697235, '0001 Toban Plaza mty', 6),
(null, 'maria', 'montiel', 812506975, '41 Melby Place santa catarina', 7),
(null, 'alejandra', 'ordoña', 813460597, '1 Cascade gpe', 8),
(null, 'blanca', 'hernandez', 813452976, '879 Ronald Regan garcia', 9),
(null, 'alonso', 'dominguez', 814758962, '05 Schurz escobedo', 10),
(null, 'miguel angel', 'espejel', 814975826, '05530 Forest apodaca', 11),
(null, 'valeria', 'cortez', 813042568, '7 Oriole apodaca', 10),
(null, 'isai', 'carrera', 810345269, '792 Main Terrace mty', 12);

select * from proveedor;

insert into horario values 
(1,'6:00:00','14:00:00'),
(2,'14:00:00','22:00:00'),
(3,'22:00:00','6:00:00');

select * from horario;

insert into contrato_p values
(null, 'dulces megan', '2023-05-15', 1, 1),
(null, 'sancks dino', '2023-07-16', 2, 5),
(null, 'desechables', '2023-06-09', 5, 3),
(null, 'aguas manuel', '2023-04-24', 2, 2),
(null, 'refrescos', '2023-04-25', 3, 4),
(null, 'frituras', '2023-05-25', 9, 9),
(null, 'salsas alonso', '2023-05-10', 10, 10),
(null, 'tostadas isai', '2023-06-15', 12, 13),
(null, 'aguas maria', '2023-06-20', 7, 7),
(null, 'dulces miguel', '2023-06-21', 11, 11),
(null, 'carenes montes', '2023-04-23', 6, 6),
(null, 'desechables valeria', '2023-05-14', 10, 12),
(null, 'frituras ale', '2023-04-25', 8, 8);

select * from contrato_p;

insert into surte values
(null, '2023-08-25', '11:30:00', 2),
(null, '2023-08-07', '10:05:20', 5),
(null, '2023-08-10', '10:10:50', 1),
(null, '2023-07-30', '13:20:35', 3),
(null, '2023-08-02', '09:56:20', 4),
(null, '2023-07-25', '10:02:36', 10),
(null, '2023-07-21', '10:12:57', 11),
(null, '2023-07-30', '09:25:45', 8),
(null, '2023-08-21', '10:30:51', 9),
(null, '2023-08-20', '09:24:10', 7),
(null, ' 2023-08-19', '20:10:30', 13),
(null, '2023-07-20', '11:32:30', 12),
(null, '2023-07-18', '09:54:51', 6);

select * from surte;

insert into mercancia values
(null, 'sabritas', 20, 'pasas fritas sabor natural con sal', 30, 5, 2),
(null, 'doritos rojos', 21, 'frituras en forma trinagular sabor queso picoso', 30, 5, 2),
(null, 'ruffles verdes', 19, 'frituras sabor queso', 25, 5, 2),
(null, 'ruffles azul', 18, 'frituras sabor a sal natural', 20, 5, 2),
(null, 'ruffles flammin hot', 20, 'frituras picantes, su bolsa es de color morado', 40, 5, 2),
(null, 'doritos flammin hot', 25, 'fritura en forma trinagular picosas, su bolsa es de color morado', 40, 5, 2),
(null, 'chettos torciditos', 17, 'frituras de forma amorfa sabor a queso con chile, su bolsa es de color naranja ', 25, 5, 2),
(null, 'chettos flammin hot', 19, 'frituras de forma amorfa sabor a chile picoso, su bolsa es de color amarrillo ', 40, 5, 2),
(null, 'tostitos verdes', 25, 'nachos sabor salsa verde', 30, 5, 2),
(null, 'tostitos flammin hot', 25, 'nachos sabor chile picoso ', 35, 5, 2),
(null, 'chips barcel', 20, 'papas fritas sabor natural condimentadas con sal', 20, 5, 2),
(null, 'chips barcel jalapeño', 22, 'papas fritas sabor chile jalapeño', 25, 5, 2),
(null, 'chips barcel habanero', 22, 'papas fritas sabor chile habanero', 25, 5, 2),
(null, 'conchitas', 18, 'frituras sabor sal y limon ', 20, 5, 2),
(null, 'frituras de biboritas', 10, 'fritura sabor a harina frita', 60, 8, 8),
(null, 'palomitas de maiz', 10, 'palomitas naturales sabor a sal', 80, 8, 8),
(null, 'papas fritas', 10, 'papas fritas en aceite sabor a sal', 60, 8, 8),
(null, 'palomitas de caramelo', 12, 'palomitas de maiz recubiertas de caramelo', 50, 8, 8),
(null, 'chetos puffs', 8, 'fritura de harina cocida mediante aire caliente sabor a queso', 50, 8, 8),
(null, 'aguas de limon', 15, 'aguas naturales de sabor limon', 20, 2, 1),
(null, 'aguas de tamarindo', 15, 'aguas naturales de sabor tamarindo ', 20, 2, 1),
(null, 'aguas de horchata', 15, 'aguas naturales sabor a horchata', 20, 2, 1),
(null, 'aguas de jamaica', 15, 'aguas naturales de sabor a jamaica ',20 , 2, 1),
(null, 'agua de sandia', 18, 'aguas naturales de sabor a sandia ', 20, 7, 10),
(null, 'agua de piña', 18, 'agua naturales de sabor a piña ', 20, 7, 10),
(null, 'agua de melon', 18, 'aguas naturales de sabor a melon ', 20, 7, 10),
(null, 'agua de guayaba', 18, 'agua natural de sabor guayaba ', 20, 7, 10),
(null, 'agua de mango', 18, 'agua natural de sabor mango', 20, 7, 10),
(null, 'chocolates', 18, 'barras de chocolate con leche', 20, 1, 3),
(null, 'sandibrochas', 5, 'paleta sabor sandia', 30, 1, 3),
(null, 'paleta brochita', 5, 'paleta sabor caramelo de color azul', 30, 1, 3),
(null, 'sandibrocha con chile', 6, 'paleta sabor a sandia recubierta con chile', 30, 1, 3),
(null, 'paleta tupsipop', 6, 'paleta sabor a cereza con reyeno chiclos', 30, 1, 3),
(null, 'paleta jara', 5, 'paleta sabor refresco de piña', 30, 1, 3),
(null, 'paleta manita', 5, 'paleta sabor caramelo y cereza', 30, 1, 3),
(null, 'paleta piña con chile', 5, 'paleta sabor piña con chile en polvo', 30, 1, 3),
(null, 'chicles trident menta', 12, 'paquete de 10 chicles sabor meta', 20, 1, 3),
(null, 'chicles trident jerba buena', 12,'paquete de 10 chicles sabor jerba buena', 20, 1, 3),
(null, 'chicles triden twist s', 15, 'paquete de 8 chicles rellenos de mermelada sabor sandia y menta', 20, 1, 3),
(null, 'chicles triden twist m', 15, 'paquete de 8 chilces rellenso de mermelada sabor mango y fresa', 20, 1, 3),
(null, 'chicles orbit menta', 4, ' paquete de 4 chlicles sabor menta', 40, 1, 3),
(null, 'chicles orbit jerba buena', 4, 'paquete de 4 chicles sabor jerba buena', 40, 1, 3),
(null, 'paleta rokaleta', 8, 'paleta de multicapaz de sabores acidos y picosos, con centro chicloso', 30, 11, 7),
(null, 'rokaleta', 4, 'dulce de multicapaz de sabores acidos y picosos con centro chiclos', 40, 11, 7),
(null, 'pulparindos', 5, 'tira de pulpa sabor tamarindo', 30, 11, 7),
(null, 'tixtix', 8, 'paquete de sobres llenos de polvos de distintos sabores', 30, 11, 7),
(null, 'duvalin', 4, 'crema tipo mantequilla de sabor chocolate y vainilla', 30, 11, 7),
(null, 'sckinlces', 12, 'dulce de goma, sabor a chamoy y tamarindo', 35, 11, 7),
(null, 'snickers', 15, 'barra de chocolate rellena de caramelo y nuez', 35, 11, 7),
(null, 'pepsi', 20, 'refresco sabor cola, de la marca pepsi de 355 ml', 30, 4, 5),
(null, 'coca cola', 22, 'refresco sabor cola, de la marca coca cola de 355 ml', 40, 4, 5),
(null, 'sprite', 20, 'refresco sabor lima-limon de 355 ml', 30, 4, 5),
(null, 'manzanita sol', 20, 'refresco sabor manzana de 355 ml', 30, 4, 5),
(null, 'fanta', 20, 'refresco sabor a naranja de 355 ml', 30, 4, 5),
(null, 'joya de ponche', 22, 'refresco sabor a ponche frutal de 355 ml', 35, 4, 5),
(null, 'fresca', 18, 'refresco sabor a toronja de 355 ml', 25, 4, 5),
(null, 'platos', 60, 'paquete de platos desechables de forma cuadrada', 10, 3, 4),
(null, 'vasos de unicel de 355 ml', 50, 'paquete de vasos largos de unicel', 10, 3, 4),
(null, 'platos rectangulares', 70, 'paquete de platos de unicel de forma rectangular', 10, 3, 4),
(null, 'vaso tipo cuenco', 55, 'paquete de vasos en forma de cuenco, utilizado para frijoles charros', 10, 3, 4),
(null, 'charolas con division', 80, 'paquete de platos tipo charola con division en 3 partes, se suele usar para llevarse comida', 20, 3, 4),
(null, 'paquete de tostadas rojas, gr', 70, 'paquete de tostadas rojas con un contendio de 50 tostadas', 20, 13, 11),
(null, 'paquete de tostadas yellow', 80, 'paquete de tostadas amarrillas, contiene en el paquete 30 tostadas', 15, 13, 11),
(null, 'paquete de tostadas deshi', 75, 'paquete de tostadas deshidratadas, contiene en el paquete 20 tostadas', 15, 13, 11),
(null, 'paquete de tostadas rojas ch', 40, 'paquete de tostadas rojas, tiene un contenido de 30 tostadas', 15, 13, 11),
(null, 'totopos', 30, 'bolsa de totopos, pesa 400 grms', 20, 13, 11),
(null, 'duritos de harina', 40, 'paquete de 20 duritos hechos de harina', 20, 9, 9),
(null, 'duritos de chicharon', 60, 'paquere de 10 duritos hechos de chicharon', 20, 9, 9),
(null, 'crema en bolsa', 30, 'bolsa de crema para tostadas, 500 ml', 15, 9, 9),
(null, 'queso amarrilo en bolsa', 35, 'bolsa de queso amarrillo para nachos, 500 ml', 15, 9, 9),
(null, 'salsa botanera', 25, 'bote de salsa picnate de 500 ml', 20, 9, 9),
(null, 'bote de frijoles machucados', 40, 'bote de frijoles machucados, contenido de 300 grms', 15, 9, 9),
(null, 'paquete de cucharas', 30, 'paquere de cucharas de plastico, contendio 30 cucharas', 20, 12, 12),
(null, 'paquete de tenedores', 30, 'paquete de tenedores de plastico, contenido 30 tenedores', 20, 12, 12),
(null, 'paquete de cuchillos', 25, 'paquete de cuchillos de plastico, contenido 30 cuchillos', 15, 12, 12),
(null, 'paquete de popotes', 20, 'paquete de popotes rectos, contenido 40 popotes', 20, 12, 12),
(null, 'paquete de servilletas', 35, 'paquete de servillestas, contenido 100 servilletas', 25, 12, 12),
(null, 'bisteck del cero', 80, 'charola de 500 grms, de bisteck del cero', 25, 6, 13),
(null, 'bisteck del siete', 90, 'charola de 500 grms, de bisteck del siete', 25, 6, 13),
(null, 'milanesa de res', 85, 'charola de 500 grms de milanesa de res', 20, 6, 13),
(null, 'milanesa de pollo', 65, 'charola de 500 grms de milanesa de pollo natural', 20, 6, 13),
(null, 'milanesa de pollo empanizada', 75, 'charola de 500 grms de milanesa de pollo empanizada', 25, 6, 13),
(null, 'milanesa de res empanizada', 95, 'charola de 500 grms de milanesa de res empanizada', 20, 6, 13),
(null, 'chuleta de cerdo', 80, 'charola de 500 grms de chuleta de cerdo', 20, 6, 13),
(null, 'chuleta de cerdo adobada', 100, 'charola de 500 grms de chuleta de cerdo adobada', 15, 6, 13),
(null, 'carne molida de res', 65, 'charola de 500 grms de carne molida de res', 20, 6, 13),
(null, 'carne molida de cerdo', 60, 'charola de 500 grms de carne molida de cerdo', 15, 6, 13),
(null, 'costilla de res simple', 90, 'charola de 600 grms de costilla de res', 20, 6, 13),
(null, 'pierna de pollo', 50, 'charola con 4 piernas de pollo naturales', 25, 6, 13),
(null, 'nuggets de pollo', 60, 'charola de 350 grms de nuggets de pollo', 25, 6, 13),
(null, 'palomitas de pollo', 60, 'charola de 400 grms de palomitas de pollo', 20, 6, 13),
(null, 'bonneless', 65, 'charola de 350 grms de bonneless de pollo', 30, 6, 13),
(null, 'dedos de queso', 80, 'charola de 400 grms de dedos de queso', 20, 6, 13),
(null, 'papas a la francesa', 60, 'bolsa de papas a la francesa de 600 grms', 30, 6, 13),
(null, 'papas onduladas', 70, 'bolsa de papas onduladas de 600 grms', 30, 6, 13),
(null, 'papas criscot', 80, 'bolsa de papas criscot de 600 grms', 25, 6, 13),
(null, 'salasa ranch', 60, 'salsa estilo ranch, contenido de 400 ml', 20, 10, 6),
(null, 'salsa buffalo', 55, 'salsa buffalo, tiene un contenido de 350 ml', 20, 10, 6),
(null, 'salsa de chipotle', 60, 'salsa hecha en base de chile chipotle, tiene un contenido de 400 ml', 10, 10, 6),
(null, 'salsa roja', 50, 'salsa hecha en base de jitomate y chile jalapeño, tiene un contendio de 500 ml', 20, 10, 6),
(null, 'salsa verde', 50, 'salsa hecha de chile serrano y tomatillo, tiene un contenido de 500 ml', 20, 10, 6),
(null, 'salsa habanera', 60, 'salsa picosa de sabor preparada con chile habanare, tiene contendido de 500 ml', 15, 10, 6);

select * from mercancia;

insert into area_de_trabajo values
(1, 'FIC CU', 1, 1),
(null, 'FCFM', 2, 1),
(null, 'FCB', 3, 3),
(null, 'FIME', 2, 2),
(null, 'FCQ', 5, 1),
(null, 'ARQ', 6, 1),
(null, 'FIC CU', 9, 2),
(null, 'FILOSOFIA', 10, 1),
(null, 'FACPYA', 8, 2),
(null, 'FACDYC', 11, 3),
(null, 'FCFM', 7, 2),
(null, 'CONTADURIA', 12, 1),
(null, ' FIC ANAHUAC', 13, 2);

select * from area_de_trabajo;

insert into vendedor values
(null, 'jose daniel', 'cerda', 'cortez', 811524976, 'lomas 7854 garcia', 1, 1, 1, 2),
(null, 'hector damian', 'mosquete', 'garza', 814519612, 'san andres 2597 gpe', 2, 5, 1, 2),
(null, 'andres', 'lopez', 'obrador', 814967582, 'san miguel 964 escobedo', 2, 3, 2, 4),
(null, 'maria anotnia', 'reyna', 'martinez', 814579325, 'cerro alto 9785 apodaca', 3, 1, 3, 3),
(null, 'segio', 'garza', 'garza', 815936488, 'centrica 9345 san nicolas', 5, 4, 1, 5),
(null, 'damaris', 'mosquete', 'rios', 812456975, '89 Eagan Avenue gpe', 13, 95, 2, 13),
(null, 'dafne', 'montiel', 'barro', 812456932, '7 Waubesa Place mty', 6, 84, 1, 6),
(null, 'marlen', 'lagos', 'fierro', 814759254, '73967 Kingsford Point escobedo', 12, 65, 1, 12),
(null, 'edwin', 'picazo', 'guerra', 814260257, '13 Village Circle santa catarina', 11, 30, 3, 10),
(null, 'vicente', 'fernandez', 'mota', 812034597, '72218 Fremont Way gpe', 9, 20, 2, 7),
(null, 'jose', 'morelos', 'fuentes', 813245698, '17 Delladonna Pass montemorelos', 10, 67, 1, 8),
(null, 'jose', 'morelos', 'fuentes', 813245698, '17 Delladonna Pass montemorelos', 10, 7, 1, 8),
(null, 'vicente', 'fernandez', 'mota', 812034597, '72218 Fremont Way gpe', 9, 28, 2, 7),
(null, 'jose daniel', 'cerda', 'cortez', 811524976, 'lomas 7854 garcia', 1, 54, 1, 2),
(null, 'jose daniel', 'cerda', 'cortez', 811524976, 'lomas 7854 garcia', 1, 15, 1, 2),
(null, 'andres', 'lopez', 'obrador', 814967582, 'san miguel 964 escobedo', 2, 86, 2, 4);

select * from vendedor;

insert into seleccion_v values
(null, 1, 1, 2),
(null, 2, 1, 2),
(null, 3, 2, 4),
(null, 4, 3, 3),
(null, 5, 1, 5),
(null, 6, 2, 13),
(null, 7, 1, 6),
(null, 8, 1, 12),
(null, 9, 3, 10),
(null, 10, 2, 7),
(null, 11, 1, 8),
(null, 12, 1, 8),
(null, 13, 2, 7),
(null, 14, 1, 2),
(null, 15, 1, 2),
(null, 16, 2, 4);

select * from seleccion_v;

insert into seleccion_m values
(null, 1, 1),
(null, 2, 5),
(null, 3, 3),
(null, 4, 1),
(null, 5, 4),
(null, 6, 95),
(null, 7, 84),
(null, 8, 65),
(null, 9, 30),
(null, 10, 20),
(null, 11, 67),
(null, 12, 7),
(null, 13, 28),
(null, 14, 54),
(null, 15, 15),
(null, 16, 86);

select * from seleccion_m;

insert into cliente values
(null, 'antonio', 'castillo', 81459672, 2),
(null, 'luis', 'gonzales', 816478295, 1),
(null, 'dolores', 'garza', 814796325, 5),
(null, 'javier', 'hernandez', 812493576, 2),
(null, 'irasema', 'guadalupe', 813679245, 3),
(null, 'javier' , 'perez', 810234597, 13),
(null, 'luis' , 'lopez', 810345296, 6),
(null, 'ricardo' , ' martinez', 813450267, 12),
(null, 'angel' , 'dominguez', 814205670, 11),
(null, 'leonel' , 'matorales', 550231648, 9),
(null, 'francisco' , 'huerta', 813504624, 10);

select * from cliente;


insert into ventas values
(null, 1, 5, 2),
(null, 2, 1, 1),
(null, 3, 5, 4),
(null, 4, 2, 5),
(null, 5, 3, 3),
(null, 6, 95, 13),
(null, 7, 84, 6),
(null, 8, 65, 12),
(null, 9, 30, 11),
(null, 10, 20, 9),
(null, 11, 67, 10);

select * from ventas;

insert into compras values
(null, 5, 300, 1, 5, 1),
(null, 2, 40, 2, 1, 2),
(null, 4, 240, 3, 5, 3),
(null, 3, 35, 4, 2, 4),
(null, 5, 54, 5, 3, 5),
(null, 3, 210, 6, 95, 6),
(null, 5, 400, 7, 84, 7),
(null, 8, 320, 8, 65, 8),
(null, 20, 100, 9, 30, 9),
(null, 10, 150, 10, 20, 10),
(null, 5, 200, 11, 67, 11);

select * from compras;

insert into consigue values
(null, 2, 1),
(null, 1, 2),
(null, 4, 3),
(null, 5, 4),
(null, 3, 5),
(null, 13, 6),
(null, 6, 7),
(null, 12, 8),
(null, 11, 9),
(null, 9, 10),
(null, 10, 11);

select * from consigue;

insert into contrato_v values
(null, 'JDCC', '2023-08-15', 1, 1),
(null, 'HDMG', '2023-08-16', 2, 2),
(null, 'ALO', '2023-08-15', 2, 3),
(null, 'MARM', '2023-08-20', 3, 4),
(null, 'SGG', '2023-09-20', 5, 5),
(null, 'DMR', '2023-09-15', 13, 6),
(null, 'DMB', '2023-07-25', 6, 7),
(null, 'MLF', '2023-08-06', 12, 8),
(null, 'EPG', '223-08-21', 11, 9),
(null, 'VFM', '2023-09-02', 9, 10),
(null, 'JMF', '2023-09-08', 10, 11);

select * from contrato_v;

////////////////////////////////////////////////////////////////////////////////////////
-- VISTAS

-- VISTA PARA VER QUIEN ES EL PROVEEDOR DE CADA MERCANCIA
create or replace view Nom_de_prov_de_M as
select m.Nombre_M, p.Nombre_P, p.Apellidos_P from mercancia m
inner join proveedor p
on m.ID_Prov = p.ID_Prov
where m.id_prov = 3;

select * from Nom_de_prov_de_M;

-- VISTA PARA VER QUE VENDEDORES ESTAN DISPONIBLES A CIERTA HORA
create or replace view Nom_Ven_por_horario as
select v.id_vendedor, v.nombre_v, nombre_m, a.nombre_at, h.id_horario, h.hora_entrada, h.hora_salida from vendedor v 
inner join mercancia m
on v.id_mercancia = m.id_mercancia
inner join seleccion_v s
on v.id_vendedor = s.id_vendedor
inner join area_de_trabajo a 
on v.id_at = a.id_at 
inner join horario h
on a.id_horario = h.id_horario
where h.id_horario = 1;

select * from Nom_Ven_por_horario;

////////////////////////////////////////////////////////////////////////////////////////////////////
-- PROCEDIMIENTOS ALMACENADOS

-- insertar un nuevo host
call insertar ('elian', 'martinez', 'cepeda', 813452069, 'michigan 2487 gpe');

select * from host;

-- codigo
delimiter //
CREATE PROCEDURE `insertar`(in nom varchar(50), in apeP varchar(40), in apeM varchar(40),
							in tel int(11), in dire varchar(60))
BEGIN
	insert into Host (Nombre_H, ApellidoP_H, ApellidoM_H, Telefono_H, Direccion_H)
				values (nom, apeP, apeM, tel, dire);
END
delimiter ;


-- ACTUALIZAR REGISTRO
CALL Actualizar (9, '2023-08-25', '13:20:08');

select * from surte;

-- CODIGO
delimiter //
CREATE PROCEDURE `Actualizar`(in id int, in fecha date, in hora time)
BEGIN
	
    update Surte
    set Fecha_S = fecha, Hora_S = hora
    where ID_Surte = id;

END
delimiter ;


-- BORRAR REGISTRO
CALL eliminar (102);

-- CODIGO
delimiter //
CREATE PROCEDURE `eliminar`(in id int)
BEGIN
	
	delete from mercancia where ID_Mercancia = id;

END
delimiter ;

select * from mercancia;

////////////////////////////////////////////////////////////
-- FUNCIONES 

-- FUNCION PRODUCTOS_SURTIDOS

drop function productos_surtidos;

-- AQUI PUEDE PONER LOS ID´s DE LOS SURTIDOS, VAN DEL 1 AL 13
SELECT productos_surtidos(1);

delimiter //
CREATE FUNCTION `productos_surtidos`(ID_P INT)
RETURNS int
READS SQL DATA
    
BEGIN

  DECLARE total_PS INT;
  SELECT COUNT(*) INTO total_PS
  FROM Mercancia as M
  INNER JOIN Surte AS S 
  ON M.ID_Surte = S.ID_Surte
  WHERE S.ID_Surte = ID_P;
  RETURN total_PS;
  
END

delimiter ;

-- FUNCION HORARIO_FAV

-- AQUI VAN LOS ID´s DE LOS HORARIOS QUE TENGO ALMACENADOS Y VAN DEL 1 A 3
select horario_fav ('2') as elegido;

delimiter //

CREATE FUNCTION `horario_fav`(idh int) 
RETURNS int
READS SQL DATA
BEGIN

	declare fav int;
	select count(*) into fav from seleccion_v where ID_Horario like concat('%', idh, '%'); 

RETURN fav;
END

delimiter ;

drop function horario_fav;

/////////////////////////////////////////////////////////////////////
-- TRIGGERS

-- CREACION DE TABLA

create table RENOVAION_contP
(
	id_prov int not null,
    id_host int not null,
    fecha date,
    tipo_de_movimiento varchar(30),
    responsable_del_cambio varchar(30),
    feche_mov datetime
);

-- ACTULIZACION DE FECHA DE CONTRATO CON EL PROVEEDOR

CREATE trigger tr_ren_contP
BEFORE UPDATE ON contrato_p
FOR EACH ROW
INSERT INTO RENOVAION_contP (id_prov, id_host, fecha, tipo_de_movimiento, responsable_del_cambio, feche_mov) VALUES
(OLD.id_prov, OLD.id_host, OLD.fecha, 'UPDATE', USER(), NOW());
    
UPDATE contrato_p
SET fecha = '2023-09-25'
WHERE id_prov = 3 AND id_host = 5;

select * from contrato_p;
select * from RENOVAION_contP;

//////////////////////////////////////////////////////////////////
-- CREACION DE USUARIO

CREATE USER LAVG IDENTIFIED BY '1907995';

SELECT * FROM MYSQL.USER;

-- ASIGNACION DE PERMISO PARA SOLO LECTURA 
GRANT SELECT ON wanted_prices2.mercancia TO LAVG;
SHOW GRANTS FOR LAVG;

-- ASIGNACION DE PERMISOS PARA LECTURA E INSERCION DE DATOS
GRANT SELECT ON wanted_prices2.area_de_trabajo TO LAVG;
GRANT INSERT ON wanted_prices2.area_de_trabajo TO LAVG;
SHOW GRANTS FOR LAVG;

