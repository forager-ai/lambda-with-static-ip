import os
import psycopg2

def lambda_handler(event, context):
    # Get DB connection info from environment variables
    db_host = os.environ.get('DB_HOST')
    db_port = os.environ.get('DB_PORT', '5432')
    db_name = os.environ.get('DB_NAME')
    db_user = os.environ.get('DB_USER')
    db_password = os.environ.get('DB_PASSWORD')
    table_name = os.environ.get('TABLE_NAME', 'sample_table')

    conn = psycopg2.connect(
        host=db_host,
        port=db_port,
        dbname=db_name,
        user=db_user,
        password=db_password
    )
    cur = conn.cursor()
    cur.execute(f'SELECT * FROM {table_name}')
    rows = cur.fetchall()
    for row in rows:
        print(row)
    cur.close()
    conn.close()
    return {'statusCode': 200, 'body': f'Processed {len(rows)} rows.'} 