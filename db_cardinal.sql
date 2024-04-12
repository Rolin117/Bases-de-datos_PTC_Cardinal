DROP DATABASE IF EXISTS db_cardinal;

CREATE DATABASE db_cardinal;
USE db_cardinal;

/*Tablas*/
CREATE TABLE tb_administradores(
id_administrador INT AUTO_INCREMENT PRIMARY KEY  NOT NULL,
nombre_admi VARCHAR (200) NOT NULL,
apellido_admi VARCHAR (200) NOT NULL,
correo_admi VARCHAR (250)  UNIQUE NOT NULL,
telefono_admi INT (8) NOT NULL UNIQUE CHECK (telefono_admi >= 0),
contraseña_admi VARCHAR (30) UNIQUE NOT NULL,
tipo_usuario INT 
);

CREATE TABLE tb_clientes(
id_cliente INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre_cliente VARCHAR (200) NOT NULL,
apellido_cliente VARCHAR (250) NOT NULL,
correo_cliente VARCHAR (250) UNIQUE NOT NULL,
telefono_cliente VARCHAR (8) NOT NULL UNIQUE CHECK (telefono_cliente >= 0),
contraseña_cliente VARCHAR (30) UNIQUE NOT NULL,
tipo_usuario INT 
);

CREATE TABLE tb_tipo_usuario(
id_usuario_tipo INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
usuario_tipo VARCHAR (50) NOT NULL
);

CREATE TABLE tb_categorias(
id_categoria INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre_categoria VARCHAR (100) NOT NULL,
descripcion_categoria VARCHAR (200) NOT NULL
);

CREATE TABLE tb_productos(
id_producto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre_producto VARCHAR (200) NOT NULL,
precio_producto FLOAT (3,2) NOT NULL CHECK (precio_producto >= 0),
c_descripcion VARCHAR (250) NOT NULL,
cantidad_producto INT NOT NULL,
id_categoria INT,
id_admin INT,
id_oferta INT
);

CREATE TABLE tb_fotos_productos(
id_foto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
foto VARCHAR (200) NOT NULL,
id_producto INT
);

CREATE TABLE tb_fotos_categorias(
id_foto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
foto VARCHAR (200) NOT NULL,
id_categoria INT
);

CREATE TABLE tb_servicios(
id_servicio INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre_servicio VARCHAR (200) NOT NULL,
descripcion_servicio VARCHAR (250) NOT NULL,
id_admin INT 
);

CREATE TABLE tb_pedidos(
id_pedido INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
fecha DATE NOT NULL,
total FLOAT (3,2) NOT NULL CHECK (total >= 0),
id_cliente INT
);

CREATE TABLE tb_detalle_pedido(
id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
precio FLOAT (3,2) NOT NULL,
total FLOAT (3,2) NOT NULL CHECK (total >= 0),
cantidad INT NOT NULL CHECK (cantidad >= 0),
id_pedido INT,
id_producto INT
);

CREATE TABLE tb_ofertas(
id_oferta INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre_oferta VARCHAR (200) NOT NULL,
descripcion_oferta VARCHAR (200) NOT NULL,
descuento DECIMAL(4,2) NOT NULL CHECK (descuento >= 0)
);

/*Conexiones*/
ALTER TABLE tb_administradores ADD CONSTRAINT fk_administrador_tipo FOREIGN KEY(tipo_usuario) REFERENCES tb_tipo_usuario(id_usuario_tipo);

ALTER TABLE tb_clientes ADD CONSTRAINT fk_cliente_tipo FOREIGN KEY (tipo_usuario) REFERENCES tb_tipo_usuario(id_usuario_tipo);

ALTER TABLE tb_pedidos ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente);

ALTER TABLE tb_detalle_pedido ADD CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido);
ALTER TABLE tb_detalle_pedido ADD CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES tb_productos(id_producto);

ALTER TABLE tb_productos ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id_categoria);
ALTER TABLE tb_productos ADD CONSTRAINT fk_producto_admin FOREIGN KEY (id_admin) REFERENCES tb_administradores(id_administrador);
ALTER TABLE tb_productos ADD CONSTRAINT fk_producto_oferta FOREIGN KEY (id_oferta) REFERENCES tb_ofertas(id_oferta);

ALTER TABLE tb_fotos_productos ADD CONSTRAINT fk_foto_producto FOREIGN KEY (id_producto) REFERENCES tb_productos(id_producto);

ALTER TABLE tb_fotos_categorias ADD CONSTRAINT fk_foto_categoria FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id_categoria);

ALTER TABLE tb_servicios ADD CONSTRAINT fk_servicio_admin FOREIGN KEY (id_admin) REFERENCES tb_administradores(id_administrador);

















