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


/*Insersion de datos*/
INSERT INTO tb_tipo_usuario (usuario_tipo) VALUES
('Administrador'),
('Cliente');

INSERT INTO tb_administradores (nombre_admi, apellido_admi, correo_admi, telefono_admi, contraseña_admi, tipo_usuario) VALUES
('Ana', 'Martinez', 'ana.martinez@example.com', 12345678, 'pass1234', 1),
('Carlos', 'Jimenez', 'carlos.jimenez@example.com', 12345679, 'pass1235', 1),
('Luisa', 'Pérez', 'luisa.perez@example.com', 12345680, 'pass1236', 1),
('Juan', 'Rodriguez', 'juan.rodriguez@example.com', 12345681, 'pass1237', 1),
('Sofía', 'Lopez', 'sofia.lopez@example.com', 12345682, 'pass1238', 1),
('Mario', 'González', 'mario.gonzalez@example.com', 12345683, 'pass1239', 1),
('Julia', 'Moreno', 'julia.moreno@example.com', 12345684, 'pass1240', 1),
('Pedro', 'Mendez', 'pedro.mendez@example.com', 12345685, 'pass1241', 1),
('Diana', 'Salazar', 'diana.salazar@example.com', 12345686, 'pass1242', 1),
('Marco', 'Ramirez', 'marco.ramirez@example.com', 12345687, 'pass1243', 1);

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, correo_cliente, telefono_cliente, contraseña_cliente, tipo_usuario) VALUES
('María', 'Fernández', 'maria.fernandez@example.com', '87654321', 'securePass1', 2),
('Roberto', 'Alvarez', 'roberto.alvarez@example.com', '87654322', 'securePass2', 2),
('Patricia', 'Molina', 'patricia.molina@example.com', '87654323', 'securePass3', 2),
('Fernando', 'Castillo', 'fernando.castillo@example.com', '87654324', 'securePass4', 2),
('Lucía', 'Ortiz', 'lucia.ortiz@example.com', '87654325', 'securePass5', 2),
('Eduardo', 'Vega', 'eduardo.vega@example.com', '87654326', 'securePass6', 2),
('Sara', 'Ramírez', 'sara.ramirez@example.com', '87654327', 'securePass7', 2),
('Esteban', 'Navarro', 'esteban.navarro@example.com', '87654328', 'securePass8', 2),
('Carmen', 'Campos', 'carmen.campos@example.com', '87654329', 'securePass9', 2),
('Jorge', 'Gutiérrez', 'jorge.gutierrez@example.com', '87654330', 'securePass10', 2);

INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria) VALUES
('Accesorios PVC Presión', 'Accesorios de PVC diseñados para sistemas de suministro de agua a alta presión, incluyendo codos, uniones y tapones.'),
('Accesorios PVC Sanitario', 'Componentes de PVC usados en sistemas de drenaje sanitario, como trampas, codos y adaptadores.'),
('Tubos para Conducción Eléctrica', 'Tubos de PVC resistentes y seguros para la protección y gestión de instalaciones eléctricas.'),
('Tubos PVC', 'Variedad de tubos de PVC utilizados para conducción de líquidos y cables, disponibles en varias dimensiones.'),
('Herramientas para PVC', 'Herramientas especializadas para trabajar con PVC, incluyendo cortadores, sierras y soldadores de plástico.'),
('Fittings de PVC', 'Amplia gama de fittings como conectores, codos, y tés para la construcción de redes de tuberías de PVC.'),
('Válvulas de PVC', 'Válvulas de PVC para controlar el flujo de fluidos en sistemas de riego y sanitarios, resistentes a la corrosión.'),
('Adhesivos y Selladores para PVC', 'Selección de adhesivos y selladores diseñados para asegurar uniones fuertes y duraderas en instalaciones de PVC.'),
('Accesorios para Conducción de Agua', 'Accesorios especializados para sistemas de conducción de agua fabricados en PVC, incluyendo reducciones y juntas.'),
('Componentes Eléctricos de PVC', 'Variedad de componentes de PVC para sistemas eléctricos, asegurando protección y durabilidad.');

INSERT INTO tb_ofertas (nombre_oferta, descripcion_oferta, descuento) VALUES
('Descuento de Primavera', '20% de descuento en todos los tubos de PVC sanitario.', 20.00),
('Oferta de Verano', '15% de descuento en accesorios de PVC para la conducción eléctrica.', 15.00),
('Promo de Invierno', '10% de descuento en válvulas de PVC.', 10.00),
('Lanzamiento de Producto', '25% de descuento en nuevos fittings de PVC.', 25.00),
('Black Friday', '30% de descuento en herramientas para trabajar el PVC.', 30.00),
('Cyber Monday', '35% de descuento en todos los adhesivos y selladores para PVC.', 35.00),
('Liquidación de Stock', '40% de descuento en tubos para conducción de agua.', 40.00),
('Oferta Especial', '5% de descuento en accesorios para conducción de agua.', 5.00),
('Promoción de Otoño', '18% de descuento en componentes eléctricos de PVC.', 18.00),
('Fin de Año', '22% de descuento en una selección de accesorios PVC presión.', 22.00);

INSERT INTO tb_productos (nombre_producto, precio_producto, c_descripcion, cantidad_producto, id_categoria, id_admin, id_oferta) VALUES
('Tubo PVC 4 Pulgadas', 100.00, 'Tubo de PVC de 4 pulgadas para conducción sanitaria.', 150, 2, 1, 1),
('Codo PVC 90 Grados', 20.00, 'Codo de PVC de 90 grados para instalaciones de agua.', 200, 1, 1, 2),
('Tubo PVC Eléctrico 1/2"', 50.00, 'Tubo de PVC de media pulgada para protección eléctrica.', 180, 3, 2, 3),
('Válvula de Cheque PVC', 70.00, 'Válvula de cheque en PVC para sistemas de riego.', 90, 7, 2, 4),
('Sellador de PVC', 30.00, 'Sellador especial para juntas de tuberías de PVC.', 120, 8, 3, 5),
('Tubo de PVC para Agua', 85.00, 'Tubo de PVC resistente al uso para conducción de agua.', 160, 9, 3, 6),
('Cortador de PVC', 45.00, 'Herramienta cortadora para tubos de PVC.', 110, 5, 4, 7),
('Fitting de Reducción PVC', 15.00, 'Fitting de reducción para instalaciones complejas de PVC.', 300, 6, 4, 8),
('Caja de Paso Eléctrica PVC', 25.00, 'Caja de paso para instalaciones eléctricas en PVC.', 140, 10, 5, 9),
('Adaptador PVC T', 10.00, 'Adaptador en forma de T para sistemas de tuberías PVC.', 250, 6, 5, 10);

INSERT INTO tb_fotos_productos (foto, id_producto) VALUES
('foto_producto_1.jpg', 1),
('foto_producto_2.jpg', 2),
('foto_producto_3.jpg', 3),
('foto_producto_4.jpg', 4),
('foto_producto_5.jpg', 5),
('foto_producto_6.jpg', 6),
('foto_producto_7.jpg', 7),
('foto_producto_8.jpg', 8),
('foto_producto_9.jpg', 9),
('foto_producto_10.jpg', 10);

INSERT INTO tb_fotos_categorias (foto, id_categoria) VALUES
('foto_categoria_1.jpg', 1),
('foto_categoria_2.jpg', 2),
('foto_categoria_3.jpg', 3),
('foto_categoria_4.jpg', 4),
('foto_categoria_5.jpg', 5),
('foto_categoria_6.jpg', 6),
('foto_categoria_7.jpg', 7),
('foto_categoria_8.jpg', 8),
('foto_categoria_9.jpg', 9),
('foto_categoria_10.jpg', 10);

INSERT INTO tb_servicios (nombre_servicio, descripcion_servicio, id_admin) VALUES
('Servicio de Ingeniería', 'Servicios profesionales de ingeniería para el diseño y construcción de infraestructuras.', 1),
('Instalación Eléctrica Residencial', 'Instalaciones eléctricas en hogares incluyendo cableado, fusibles y tableros de control.', 2),
('Servicio de Fontanería', 'Reparación e instalación de tuberías, grifos, inodoros y sistemas de calefacción.', 3),
('Mantenimiento de HVAC', 'Servicios de mantenimiento preventivo y correctivo para sistemas de calefacción y aire acondicionado.', 1),
('Consultoría en Eficiencia Energética', 'Análisis y recomendaciones para mejorar la eficiencia energética en edificaciones.', 2),
('Instalación de Sistemas de Seguridad', 'Instalación de sistemas de seguridad como alarmas, cámaras de vigilancia y sistemas de acceso.', 3),
('Servicios de Pintura y Decoración', 'Pintura interior y exterior, junto con servicios de decoración para residencias y oficinas.', 1),
('Inspección y Certificación de Edificios', 'Inspecciones detalladas y certificación de edificios según normativas vigentes.', 2),
('Instalación y Mantenimiento de Piscinas', 'Servicios de instalación y mantenimiento periódico de piscinas.', 3),
('Renovaciones y Remodelaciones', 'Proyectos completos de renovación y remodelación para todo tipo de edificaciones.', 1);

INSERT INTO tb_pedidos (fecha, total, id_cliente) VALUES
('2024-04-01', 300.00, 1),
('2024-04-02', 150.50, 2),
('2024-04-03', 210.75, 3),
('2024-04-04', 450.00, 4),
('2024-04-05', 325.25, 5),
('2024-04-06', 234.00, 6),
('2024-04-07', 190.00, 7),
('2024-04-08', 310.00, 8),
('2024-04-09', 400.00, 9),
('2024-04-10', 200.00, 10);

INSERT INTO tb_detalle_pedido (precio, total, cantidad, id_pedido, id_producto) VALUES
(100.00, 200.00, 2, 1, 1),
(150.00, 300.00, 2, 2, 2),
(75.50, 226.50, 3, 3, 3),
(50.75, 152.25, 3, 4, 4),
(90.00, 270.00, 3, 5, 5),
(120.00, 240.00, 2, 6, 6),
(80.00, 160.00, 2, 7, 7),
(130.00, 260.00, 2, 8, 8),
(110.00, 330.00, 3, 9, 9),
(95.00, 285.00, 3, 10, 10);

/*Trigger*/
DELIMITER $$

CREATE TRIGGER AfterInsertDetallePedido
AFTER INSERT ON tb_detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE tb_productos
    SET cantidad_producto = cantidad_producto - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END$$

DELIMITER ;














