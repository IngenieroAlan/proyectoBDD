DROP DATABASE IF EXISTS comics;
CREATE DATABASE comics;
USE comics;

DROP TABLE IF EXISTS categoria_producto;
CREATE TABLE categoria_producto (
  id_categoria_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre ENUM('Comic', 'Manga', 'Libro') NOT NULL,
  descripcion VARCHAR(100)
);

DROP TABLE IF EXISTS imagen;
CREATE TABLE imagen (
  id_imagen INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ruta_imagen VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS marca;
CREATE TABLE marca (
  id_marca INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(100),
  pagina VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario(
  id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  contrasena VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  fecha_nacimiento DATE NOT NULL,
  domicilio VARCHAR(200)
);

DROP TABLE IF EXISTS producto;
CREATE TABLE producto (
  id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  stock INT NOT NULL,
  idioma ENUM('ESPANOL', 'INGLES', 'JAPONES') NOT NULL,
  id_categoria_producto INT NOT NULL,
  id_imagen INT NOT NULL,
  id_marca INT NOT NULL,

  FOREIGN KEY (id_categoria_producto)
  REFERENCES categoria_producto(id_categoria_producto)
  ON UPDATE CASCADE ON DELETE CASCADE,

  FOREIGN KEY (id_imagen) REFERENCES imagen(id_imagen)
  ON UPDATE CASCADE ON DELETE CASCADE,

  FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
  ON UPDATE CASCADE ON DELETE CASCADE
);

  DROP TABLE IF EXISTS detalle_venta;
  CREATE TABLE detalle_venta(
    id_detalle_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cantidad INT NOT NULL,
    fecha_venta DATE NOT NULL,
    monto_venta FLOAT NOT NULL,
    descripcion_venta VARCHAR(500) NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON UPDATE CASCADE ON DELETE CASCADE
  );

DROP TABLE IF EXISTS venta;
CREATE TABLE venta(
  id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_detalle_venta INT NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (id_detalle_venta) REFERENCES detalle_venta(id_detalle_venta) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO imagen(ruta_imagen) values("/home/rusty/Downloads/gruv.png");
INSERT INTO categoria_producto( nombre, descripcion) values('Comic', 'Historieta infantil');
INSERT INTO marca(nombre, descripcion, pagina) VALUES('Detective Comics', 'dc', 'dc.com');
INSERT INTO producto(nombre, descripcion, precio, stock, idioma, id_categoria_producto, id_imagen, id_marca) VALUES('Batman Tomo 1', 'primera aparicion de batman', 234, 10, 'INGLES', 1, 1, 1);
INSERT INTO usuario(usuario, contrasena, email, fecha_nacimiento) VALUES ('rusty', MD5('EOhlHhhfOApFT'), 'rustytheguy2@gmail.com', '2003-03-01');
