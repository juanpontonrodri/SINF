DROP PROCEDURE IF EXISTS crearOferta;
DELIMITER &&
CREATE PROCEDURE crearOferta(IN nombreEspectaculo CHAR(50), IN nombreRecinto CHAR(50), IN fechaEvento DATETIME, IN tipoUsuarioOfertado CHAR(50), IN localizacionLocalidad CHAR(50), IN nombreGrada CHAR(50))
BEGIN
    DECLARE done BOOLEAN;
    DECLARE valido BOOLEAN;
    DECLARE consulta VARCHAR(50);
    DECLARE localidad VARCHAR(50);
    DECLARE recinto VARCHAR(100);
    DECLARE cursito CURSOR FOR (SELECT nombre_recinto_localidad FROM Localidad WHERE localizacion_localidad = localizacionLocalidad AND nombre_grada_localidad = nombreGrada);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SET valido = FALSE;
    SET done = FALSE;
    
    SELECT nombre_espectaculo_evento INTO consulta FROM Evento WHERE nombre_recinto_evento = nombreRecinto AND nombre_espectaculo_evento = nombreEspectaculo AND fecha_evento = fechaEvento;
    
    SELECT estado_localidad INTO localidad FROM Localidad WHERE nombre_recinto_localidad = nombreRecinto AND nombre_grada_localidad = nombreGrada AND localizacion_localidad = localizacionLocalidad;
    
    SELECT(consulta);
    
    OPEN cursito;

    loop1: LOOP
        FETCH cursito INTO recinto;
        
        SELECT(recinto);
        SELECT(localidad);
        
        IF done = TRUE THEN
            LEAVE loop1;
        ELSE 
            IF recinto = nombreRecinto THEN
                IF consulta IS NOT NULL THEN
                    IF localidad = 'disponible' THEN
                        SET valido = TRUE;
                        LEAVE loop1;
                    ELSE 
                        SELECT 'No se creo la oferta' AS mensaje;
                    END IF;
                END IF;
            END IF;
        END IF;
    END LOOP;

    CLOSE cursito;

    IF valido = TRUE THEN 
        INSERT INTO Oferta VALUES (nombreEspectaculo, nombreRecinto, tipoUsuarioOfertado, localizacionLocalidad, nombreGrada, fechaEvento, 'libre');
    END IF;

END &&
DELIMITER ;
