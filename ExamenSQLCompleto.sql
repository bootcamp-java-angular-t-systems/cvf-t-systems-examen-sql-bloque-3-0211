# Ejercicio 1 -> 5.1
SELECT 
    DNI, NomApels
FROM
    directores.directores;


# Ejercicio 1 -> 5.2
SELECT 
    *
FROM
    directores.directores
WHERE
    DNIJefe IS NULL;


# Ejercicio 1 -> 5.3
SELECT 
    dir.NomApels, des.capacidad
FROM
    directores.directores AS dir
        LEFT JOIN
    directores.despachos AS des ON dir.Despacho = des.numero;


# Ejercicio 1 -> 5.4
SELECT 
    Despacho, COUNT(*)
FROM
    directores.directores
GROUP BY Despacho;


# Ejercicio 1 -> 5.5
SELECT 
    *
FROM
    directores.directores AS d
WHERE
    d.DNIJefe IS NOT NULL
        AND d.DNIJefe NOT IN (SELECT 
            DNI
        FROM
            directores.directores
        WHERE
            DNIJefe IS NOT NULL);


# Ejercicio 1 -> 5.6
SELECT d1.NomApels AS NombreDirector, d2.NomApels AS NombreJefe
FROM directores.directores as d1
LEFT JOIN directores.directores AS d2 ON d1.DNIJefe = d2.DNI;


# Ejercicio 1 -> 5.7
SELECT 
    d.numero AS NumeroDespacho,
    d.capacidad AS CapacidadMaxima,
    COUNT(dir.DNI) AS NumDirectoresEnDespacho
FROM
    directores.directores AS dir
        RIGHT JOIN
    directores.despachos AS d ON dir.Despacho = d.numero
GROUP BY d.numero , d.capacidad
HAVING NumDirectoresEnDespacho >= d.capacidad;



# Ejercicio 1 -> 5.8
INSERT INTO directores.despachos (numero, capacidad) VALUES (124, 123);
INSERT INTO directores.directores (DNI, NomApels, DNIJefe, Despacho)
VALUES ('28301700', 'Paco Pérez', NULL, 124);


# Ejercicio 1 -> 5.9
UPDATE directores.directores 
SET 
    DNIJefe = '74568521'
WHERE
    NomApels LIKE '%Pérez%';


# Ejercicio 1 -> 5.10
DELETE FROM directores.directores 
WHERE
    DNIJefe IS NOT NULL;


# Ejercicio 2 -> 6.1
SELECT 
    Nombre
FROM
    piezasproveedores.piezas;


# Ejercicio 2 -> 6.2
SELECT 
    *
FROM
    piezasproveedores.proveedores;


# Ejercicio 2 -> 6.3
SELECT 
    AVG(precio)
FROM
    piezasproveedores.suministra;


# Ejercicio 2 -> 6.4
SELECT 
    *
FROM
    piezasproveedores.suministra AS s
        LEFT JOIN
    piezasproveedores.proveedores AS pr ON s.IdProveedor = pr.id
WHERE
    s.CodigoPieza = 1;


# Ejercicio 2 -> 6.5
SELECT 
    pi.Nombre
FROM
    piezasproveedores.suministra AS s
        LEFT JOIN
    piezasproveedores.piezas AS pi ON s.CodigoPieza = pi.Codigo
WHERE
    IdProveedor = 'HAL';


# Ejercicio 2 -> 6.6
SELECT 
    p.Nombre AS NombrePieza,
    s.Precio,
    pr.Nombre AS NombreProveedor
FROM
    piezasproveedores.suministra s
        JOIN
    piezasproveedores.piezas p ON s.CodigoPieza = p.Codigo
        JOIN
    piezasproveedores.proveedores pr ON s.IdProveedor = pr.id
WHERE
    s.Precio = (SELECT 
            MAX(Precio)
        FROM
            suministra);


# Ejercicio 2 -> 6.7
INSERT INTO piezasproveedores.proveedores (id, Nombre) VALUES ('TNBC', 'Skellington Supplies');
INSERT INTO piezasproveedores.suministra (CodigoPieza, IdProveedor, Precio) VALUES (1, 'TNBC', 7);


# Ejercicio 2 -> 6.8
UPDATE piezasproveedores.suministra
SET Precio = Precio + 1
WHERE CodigoPieza = 1 AND IdProveedor = 'TNBC';


# Ejercicio 2 -> 6.9
DELETE FROM piezasproveedores.suministra 
WHERE
    IdProveedor = 'RBT';
    

# Ejercicio 2 -> 6.10
DELETE FROM suministra 
WHERE
    IdProveedor = 'RBT' AND CodigoPieza = 4;
    
    
# Ejercicio 3 -> 7.1
SELECT 
    c.DNI,
    c.NomApels,
    p.id AS IdProyecto,
    p.Nombre AS NombreProyecto
FROM
    cientificos.cientificos c
        JOIN
    cientificos.asignado_a aa ON c.DNI = aa.cientifico
        JOIN
    cientificos.proyecto p ON aa.proyecto = p.id;


# Ejercicio 3 -> 7.2
SELECT 
    c.DNI,
    c.NomApels,
    COUNT(aa.proyecto) AS NumeroProyectosAsignados
FROM
    cientificos.cientificos c
        LEFT JOIN
    cientificos.asignado_a aa ON c.DNI = aa.cientifico
GROUP BY c.DNI , c.NomApels;


# Ejercicio 3 -> 7.3
SELECT 
    p.id AS IdProyecto,
    p.Nombre AS NombreProyecto,
    COUNT(aa.cientifico) AS NumeroCientificosAsignados
FROM
    cientificos.proyecto p
        LEFT JOIN
    cientificos.asignado_a aa ON p.id = aa.proyecto
GROUP BY p.id , p.Nombre;


# Ejercicio 3 -> 7.4
SELECT 
    c.DNI, c.NomApels, SUM(p.Horas) AS HorasDedicacion
FROM
    cientificos.cientificos c
        JOIN
    cientificos.asignado_a aa ON c.DNI = aa.cientifico
        JOIN
    cientificos.proyecto p ON aa.proyecto = p.id
GROUP BY c.DNI , c.NomApels;


# Ejercicio 3 -> 7.5
SELECT 
    c.DNI, c.NomApels
FROM
    cientificos.cientificos c
        JOIN
    cientificos.asignado_a aa ON c.DNI = aa.cientifico
        JOIN
    cientificos.proyecto p ON aa.proyecto = p.id
GROUP BY c.DNI , c.NomApels
HAVING COUNT(DISTINCT aa.proyecto) > 1
    AND AVG(p.Horas) > 80;


