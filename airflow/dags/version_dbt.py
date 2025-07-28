from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.log.logging_mixin import LoggingMixin
from datetime import datetime
import pkg_resources

log = LoggingMixin().log

def check_package():
    version = pkg_resources.get_distribution("apache-airflow-providers-dbt-cloud").version
    log.info(f"dbt Cloud provider version: {version}")

with DAG(
    dag_id="check_dbt_provider",
    start_date=datetime(2025, 7, 1),
    schedule=None,  # Cambiado de schedule_interval a schedule
    catchup=False,
    tags=["test"]
) as dag:

    check_package_task = PythonOperator(
        task_id="check_package_installed",
        python_callable=check_package,
    )
