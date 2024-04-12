USE db_cardinal;

/*Trigger*/

/*El trigger se ejecutará después de que un registro sea insertado en la tabla tb_detalle_pedido*/
DELIMITER $$

CREATE TRIGGER AfterInsertDetallePedido
AFTER INSERT ON tb_detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE tb_productos
    SET cantidad_producto = cantidad_producto - NEW.cantidad
    WHERE id_producto = NEW.id_producto; /* Asegura que la actualización solo ocurre para el producto especificado en el nuevo detalle de pedido.*/
END$$

DELIMITER ;