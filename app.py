
from importlib import import_module
st = import_module("streamlit")
import pickle
import pandas as pd
import os
import joblib

@st.cache_resource
def cargar_modelo():
    ruta_actual = os.path.dirname(os.path.abspath(__file__))
    ruta_modelo = os.path.join(ruta_actual, 'modelo_calidad_produccion.pkl')
    modelo = joblib.load(ruta_modelo)
    return modelo

modelo = cargar_modelo()

# 2. Configurar la interfaz de la aplicación
st.title("🎛️ Predictor de Calidad de Producción")
st.write("Ingrese los valores de las variables para realizar la predicción de calidad del modelo de Random Forest.")

# 3. Crear campos de entrada para el usuario (10 en total)
st.subheader("Parámetros de entrada")

variable_1 = st.number_input("Temperatura", value=0.0)
variable_2 = st.number_input("Presión", value=0.0)
variable_3 = st.number_input("Vibración", value=0.0)
variable_4 = st.number_input("Humedad", value=0.0)
variable_5 = st.number_input("Bomba", value=0.0)
variable_6 = st.number_input("Turbina", value=0.0)
variable_7 = st.number_input("Chicago", value=0.0)
variable_8 = st.number_input("Houston", value=0.0)
variable_8 = st.number_input("New York", value=0.0)
variable_9 = st.number_input("San Francisco", value=0.0)
variable_10 = st.number_input("Variable 10", value=0.0)  # <-- Décima variable agregada

# 4. Botón para ejecutar la predicción
if st.button("Ejecutar Predicción"):
    # Agrupar los 10 valores y definir las 10 columnas
    datos_entrada = pd.DataFrame(
        [[variable_1, variable_2, variable_3, variable_4, variable_5, 
          variable_6, variable_7, variable_8, variable_9, variable_10]], 
        columns=['col1', 'col2', 'col3', 'col4', 'col5', 'col6', 'col7', 'col8', 'col9', 'col10']
    )
    
    # Realizar la predicción
    prediccion = modelo.predict(datos_entrada)
    
    # Obtener la probabilidad de falla si el modelo soporta 'predict_proba'
    if hasattr(modelo, "predict_proba"):
        probabilidades = modelo.predict_proba(datos_entrada)
        # Suponiendo que la clase 1 (falla crítica) está en el índice 1
        probabilidad_fallo = probabilidades[0][1] 
    else:
        probabilidad_fallo = 0.0

    # Lógica de estados tal como la tienes en tu imagen
    estado = "FALLA CRÍTICA (1)" if prediccion[0] == 1 else "NORMAL (0)"
    
    # Mostrar resultados en la interfaz web de Streamlit
    st.markdown("---")
    st.subheader("📊 Resultado del Diagnóstico")
    
    if prediccion[0] == 1:
        st.error(f"Diagnóstico del equipo: {estado}")
    else:
        st.success(f"Diagnóstico del equipo: {estado}")
        
    st.info(f"Probabilidad de falla: {probabilidad_fallo * 100:.2f}%")