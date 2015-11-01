SELECT * FROM articulos

SELECT * FROM rolarticulos

SELECT * FROM clientes

DELETE FROM clientes *

SELECT * FROM comercializables_impuestos

SELECT * FROM listaprecios

SELECT * FROM precioarts

DELETE FROM precioarts *

SELECT * FROM formadepagos

SELECT * FROM formadepagos_monedas

SELECT * FROM facturas

SELECT * FROM renglon_facturas

SELECT * FROM recibos

SELECT * FROM facturas WHERE recibo_id IS NULL

INSERT INTO facturas (comerciante_id,contado) VALUES ('1','f');

SELECT * FROM comercializables_promocions