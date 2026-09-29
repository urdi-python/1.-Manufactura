-- Seleccionar datos a traves de una consulta de JOINs

SELECT 
	p.product_type as tipo_producto,
	p.shift as turno,
	p.ambient_temperature as temperatura,
	p.humidity as humedad,
	p.spindle_speed as velocidad,
	p.power_consumption as consumo,
	p.defect_rate as tasa_defectos,
	p.downtime_minutes as tiempo_detenida,
	p.operation_mode as tipo_operacion,
	p.machine_id as maquina_id,
	m.production_line as linea_produccion,
	m.maintenance_frequency as frecuencia_mantenimiento,
	p.product_type as tipo_producto,
	pr.production_cost_per_unit

FROM Metricas_Produccion p
JOIN Catalogo_Maquinas m on p.machine_id = m.machine_id
JOIN Catalogo_Productos pr on p.product_type = pr.product_type




-- Cargar la consulta a Tabla_modelo

-- Crear y poblar la nueva tabla 'Tabla_modelo' con los datos de tu consulta
SELECT 
    p.product_type AS tipo_producto,
    p.shift AS turno,
    p.ambient_temperature AS temperatura,
    p.humidity AS humedad,
    p.spindle_speed AS velocidad,
    p.power_consumption AS consumo,
    p.defect_rate AS tasa_defectos,
    p.downtime_minutes AS tiempo_detenida,
    p.operation_mode AS tipo_operacion,
    p.machine_id AS maquina_id,
    m.production_line AS linea_produccion,
    m.maintenance_frequency AS frecuencia_mantenimiento,
    pr.production_cost_per_unit AS costo_produccion_unidad
INTO dbo.Tabla_modelo
FROM Metricas_Produccion p
JOIN Catalogo_Maquinas m ON p.machine_id = m.machine_id
JOIN Catalogo_Productos pr ON p.product_type = pr.product_type;
GO

-- 2. Verificar que los datos se hayan guardado correctamente
SELECT TOP 10 * FROM dbo.Tabla_modelo;
GO

-- COnsulta de tabla para exportar CVS para modelar

SELECT * FROM Tabla_modelo;