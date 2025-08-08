from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime


with DAG(
   dag_id="mi_primer_dag",
   start_date=datetime(2025, 7, 22),
   schedule="@daily",
   catchup=False,
) as dag:


   tarea_inicial = BashOperator(
       task_id="tarea_inicial",
       bash_command="echo 'Esta es mi primera tarea en Airflow' && cd /opt/airflow/dbt_project/dbt && dbt debug"
   )
