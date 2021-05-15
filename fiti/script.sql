<<<<<<< HEAD
--eventawbd
DROP TABLE EVENTO;
CREATE TABLE EVENTO (
    id                  INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    titulo              VARCHAR(30) NOT NULL,
    descripcion         VARCHAR(500) NOT NULL,
    ciudad              VARCHAR(45),
    fecha               DATE NOT NULL,
    fechaCompra         DATE NOT NULL,
    precio              DOUBLE NOT NULL,
    aforo               INT NOT NULL,
    maxEntradasUsuario  INT NOT NULL,
    numFilas            INT,
    asientosFila        INT,
    PRIMARY KEY (id)
);

DROP TABLE ETIQUETA;
CREATE TABLE ETIQUETA (
    id      INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    nombre  VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE EVENTO_ETIQUETA;
CREATE TABLE EVENTO_ETIQUETA (
    evento      INTEGER NOT NULL,
    etiqueta    INTEGER NOT NULL,
    FOREIGN KEY (evento) REFERENCES EVENTO(id),
    FOREIGN KEY (etiqueta) REFERENCES ETIQUETA(id)
);
  
DROP TABLE ROL;
CREATE TABLE ROL (
    id      INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    tipo    VARCHAR(15) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE USUARIO;
CREATE TABLE USUARIO (
    id          INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    correo      VARCHAR(45) NOT NULL,
    contrasenya VARCHAR(45) NOT NULL,
    rol         INTEGER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (rol) REFERENCES ROL(id)
    CONSTRAINT AK_Correo UNIQUE(correo)
);

DROP TABLE USUARIOEVENTO;
CREATE TABLE USUARIOEVENTO (
    idUsuario       INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    nombre          VARCHAR(45) NOT NULL,
    apellido1       VARCHAR(45) NOT NULL,
    apellido2       VARCHAR(45),
    domicilio       VARCHAR(45) NOT NULL,
    ciudad          VARCHAR(45) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    sexo            VARCHAR(1) NOT NULL,
    PRIMARY KEY(idUsuario),
    FOREIGN KEY (idUsuario) REFERENCES USUARIO(id)
);
                  
DROP TABLE ENTRADA;
CREATE TABLE ENTRADA (
    id          INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    usuario     INTEGER NOT NULL,
    evento      INTEGER NOT NULL,
    numFila     INTEGER,
    asientoFila INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario) REFERENCES USUARIO,
    FOREIGN KEY (evento) REFERENCES EVENTO
);

DROP TABLE CONVERSACION;
CREATE TABLE CONVERSACION (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    teleoperador INTEGER NOT NULL,
    usuario INTEGER NOT NULL,
    FOREIGN KEY (teleoperador) REFERENCES USUARIO,
    FOREIGN KEY (usuario) REFERENCES USUARIO,
    PRIMARY KEY (id)
);

DROP TABLE MENSAJE;
CREATE TABLE MENSAJE (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    contenido VARCHAR(500) NOT NULL,
    fecha DATE NOT NULL,
    emisor INTEGER NOT NULL,
    conversacion INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (emisor) REFERENCES USUARIO,
    FOREIGN KEY (conversacion) REFERENCES CONVERSACION
);

DROP TABLE ANALISIS;
CREATE TABLE ANALISIS (
    analisisId    INTEGER,
    nombre        VARCHAR(30),
    analista      INTEGER,
    fechaMayor    INTEGER,
    fechaMenor    INTEGER,
    fechaIgual    INTEGER,
    precioMayor   INTEGER,
    precioMenor   INTEGER,
    precioIgual   INTEGER, 
    ciudadEvento  VARCHAR(45),
    ciudadUsuario VARCHAR(45),
    edadMayor     INTEGER,
    edadMenor     INTEGER,
    edadIgual     INTEGER,
    sexo          VARCHAR (1),
    PRIMARY KEY (analisisId),
    FOREIGN KEY (analista) REFERENCES USUARIO
);

INSERT INTO ROL (TIPO) VALUES ('ADMIN');
INSERT INTO ROL (TIPO) VALUES ('USER');
INSERT INTO ROL (TIPO) VALUES ('CREADOR');
INSERT INTO ROL (TIPO) VALUES ('TELEOPERADOR');
INSERT INTO ROL (TIPO) VALUES ('ANALISTA');

INSERT INTO USUARIO (CORREO, CONTRASENYA, ROL) VALUES ('admin@gmail.com', 'admin', 1);
INSERT INTO USUARIO (CORREO, CONTRASENYA, ROL) VALUES ('usuario@gmail.com', 'usuario', 2);

INSERT INTO ANALISIS (ANALISISID, NOMBRE, ANALISTA) VALUES (1, 'ejemploAnalisis', 1);
=======
--eventawbd
CREATE TABLE ROL (
     id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
     tipo VARCHAR(15) NOT NULL,
     PRIMARY KEY (id)
);

CREATE TABLE USUARIO (
  id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  correo VARCHAR(45) NOT NULL UNIQUE,
  contrasenya VARCHAR(45) NOT NULL,
  rol INTEGER NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (rol) REFERENCES ROL(id)
);

CREATE TABLE EVENTO (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    titulo VARCHAR(30) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    fecha DATE NOT NULL,
    fechaCompra DATE NOT NULL,
    precio DOUBLE NOT NULL,
    aforo INT NOT NULL,
    maxEntradasUsuario INT NOT NULL,
    numFilas INT,
    asientosFila INT,
    creador INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (creador) REFERENCES USUARIO(id)
);

CREATE TABLE ETIQUETA (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    nombre VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE EVENTO_ETIQUETA (
    evento INTEGER NOT NULL,
    etiqueta INTEGER NOT NULL,
    FOREIGN KEY (evento) REFERENCES EVENTO(id),
    FOREIGN KEY (etiqueta) REFERENCES ETIQUETA(id)
);

CREATE TABLE USUARIOEVENTO (
  id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  idUsuario INTEGER NOT NULL UNIQUE,
  nombre VARCHAR(45) NOT NULL,
  apellido1 VARCHAR(45) NOT NULL,
  apellido2 VARCHAR(45),
  domicilio VARCHAR(45) NOT NULL,
  ciudad VARCHAR(45) NOT NULL,
  fechaNacimiento DATE NOT NULL,
  sexo VARCHAR(1) NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (idUsuario) REFERENCES USUARIO(id)
 );
                  

CREATE TABLE ENTRADA (
  id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  usuario INTEGER NOT NULL,
  evento INTEGER NOT NULL,
  numFila INTEGER,
  asientoFila INTEGER,
  PRIMARY KEY (id),
  FOREIGN KEY (usuario) REFERENCES USUARIO,
  FOREIGN KEY (evento) REFERENCES EVENTO
);


CREATE TABLE CONVERSACION (
  id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  teleoperador INTEGER NOT NULL,
  usuario INTEGER NOT NULL,
  FOREIGN KEY (teleoperador) REFERENCES USUARIO,
  FOREIGN KEY (usuario) REFERENCES USUARIO,
  PRIMARY KEY (id)
  );

CREATE TABLE MENSAJE (
  id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  contenido VARCHAR(500) NOT NULL,
  fecha DATE NOT NULL,
  emisor INTEGER NOT NULL,
  conversacion INTEGER NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (emisor) REFERENCES USUARIO,
  FOREIGN KEY (conversacion) REFERENCES CONVERSACION
);
>>>>>>> origin/master
