
USE Manufactura;
GO

CREATE TABLE dbo.Catalogo_Maquinas (
    machine_id VARCHAR(3) PRIMARY KEY,
    production_line VARCHAR(6),
    maintenance_frequency FLOAT
);
GO

CREATE TABLE dbo.Catalogo_Productos (
    product_type VARCHAR(9) PRIMARY KEY,
    production_cost_per_unit FLOAT
);
GO

CREATE TABLE Metricas_Produccion (
    record_id INT PRIMARY KEY,
    machine_id VARCHAR(3) NOT NULL,
    product_type VARCHAR(9) NOT NULL,
    batch_id VARCHAR(10),
    shift VARCHAR(9),
    ambient_temperature FLOAT,
    humidity FLOAT,
    spindle_speed FLOAT,
    power_consumption FLOAT,
    defect_rate FLOAT,
    downtime_minutes FLOAT,
    operation_mode VARCHAR(25),

    CONSTRAINT FK_Produccion_Maquinas FOREIGN KEY (machine_id) REFERENCES dbo.Catalogo_Maquinas(machine_id),
    CONSTRAINT FK_Produccion_Productos FOREIGN KEY (product_type) REFERENCES dbo.Catalogo_Productos(product_type)
);


GO

print '¡Tabla Metricas_Produccion creada con éxito en SQL Server!';



	-- En SQL Server Management Studio (SSMS), puedes borrar la tabla y dejar que Python la cree con la estructura correcta:
DROP TABLE IF EXISTS dbo.Metricas_Produccion;
DROP TABLE IF EXISTS dbo.Catalogo_Maquinas;
DROP TABLE IF EXISTS dbo.Catalogo_Productos;
-- Vaciar las tablas en el orden correcto (respetando las dependencias)
DELETE FROM dbo.Metricas_Produccion;
DELETE FROM dbo.Catalogo_Maquinas;
DELETE FROM dbo.Catalogo_Productos;

