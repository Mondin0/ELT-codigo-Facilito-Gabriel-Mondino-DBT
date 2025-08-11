Este proyecto desarrollado por **Gabriel Mondino** enmarcado en el curso **INGENIERÍA DE DATOS**, brindado por **CODIGO FACILITO** implementa una arquitectura ELT tipo medallion utilizando dbt para transformar datos de smartphones y almacenarlos en Snowflake, y Apache Airflow para orquestar la ejecución del flujo de trabajo.

### Resumen del proyecto
- Se utiliza **dbt (data build tool)** para desarrollar las transformaciones en tres capas:
  - **Bronze:** tabla vista con los datos brutos obtenidos directamente de la fuente (tabla SMARTPHONES en esquema público de Snowflake).
  - **Silver:** tabla con datos limpiados y normalizados, donde se filtran filas inválidas y se estandarizan tipos de datos (por ejemplo, booleanos para características como soporte 5G).
  - **Gold:** etapa final con dos tablas, una dimensión con atributos consolidados de smartphones y clave surrogate, y una tabla de hechos que contiene medidas como precio y calificación, relacionadas con la dimensión mediante la clave surrogate.
  
- Las transformaciones están definidas en SQL dentro de carpetas organizadas según estas capas (`bronze`, `silver`, `gold`) y están descritas mediante archivos `schema.yml` que documentan fuentes y modelos y aplican tests básicos.

- El proyecto está configurado en un archivo `dbt_project.yml` donde se asignan esquemas específicos para cada capa, materializaciones (vistas para bronze, tablas para silver y gold) y otros parámetros de compilación.

- Para la orquestación y automatización de la ejecución, se utiliza **Apache Airflow**. El DAG configurado ejecuta un comando `bash` que navega al directorio del proyecto dbt (mapeado en el volumen del contenedor Airflow) y corre `dbt debug` y `dbt run` para validar y ejecutar las transformaciones en Snowflake.

### Detalles técnicos importantes
- La clave surrogate en la capa gold es un hash MD5 concatenando marca y modelo del smartphone para garantizar unicidad.
- Se mapeó la CLI de dbt Cloud en un volumen interno de Airflow para facilitar la integración y ejecución desde Airflow.
- Airflow ejecuta el DAG con una tarea inicial sencilla que imprime un mensaje y luego corre los comandos dbt.
- Todas las configuraciones de dbt están preparadas para apuntar a Snowflake, aprovechando su potencia para el procesamiento y almacenamiento.

### Estructura del proyecto
- `dbt_project.yml`: configuración principal del proyecto dbt.
- `models/bronze`: modelo para ingestión de datos en vista.
- `models/silver`: modelo para datos limpiados y normalizados.
- `models/gold`: modelos para tablas dimensionales y de hechos consolidadas.
- Archivos `schema.yml` para documentación y tests en cada capa.
- DAG en Airflow definido en Python para ejecutar el pipeline dbt diariamente.

Esta solución demuestra cómo combinar herramientas modernas: **dbt para transformación modular y testable**, **Snowflake para almacenamiento escalable en la nube**, y **Airflow para la orquestación automatizada**, siguiendo un patrón arquitectónico robusto y escalable de capas medallion.

[1] https://docs.getdbt.com/docs/build/projects
[2] https://www.syntonize.com/desbloqueando-el-poder-de-los-datos-con-dbt-y-snowflake/
[3] https://pipeline2insights.substack.com/p/dbt-in-action-1-fundamentals
[4] https://docs.newrelic.com/es/docs/infrastructure/other-infrastructure-integrations/dbt-cloud-integration/
[5] https://dev.to/pizofreude/study-notes-421-422-dbt-project-setup-2d4d
[6] https://www.reddit.com/r/dataengineering/comments/1k83uee/how_to_use_airflow_and_dbt_together_in_a/?tl=es-419
[7] https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview
[8] https://github.com/DivineSamOfficial/Snowflake-ELT-Pipeline-with-dbt-and-Airflow/blob/main/README.md
[9] https://stellans.io/dbt-project-structure-conventions/
[10] https://www.youtube.com/watch?v=nxsnzB3mwjA