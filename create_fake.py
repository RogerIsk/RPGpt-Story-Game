import psycopg2
import random
import time
from faker import Faker

# Initialize Faker to generate fake data
fake = Faker()

# Connect to your PostgreSQL database
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="postgres",
    host="localhost",
    port="5432"
)

# Create a cursor object to interact with the database
cur = conn.cursor()

# Step 1: Create the `angestellte` table with various data types
cur.execute("""
    CREATE TABLE IF NOT EXISTS angestellte (
        id SERIAL PRIMARY KEY,            -- Auto-incrementing ID
        name VARCHAR(100),                -- Character type for employee name
        age INTEGER,                      -- Numeric type for age
        join_date DATE,                   -- Date type for join date
        salary NUMERIC(10, 2),            -- Numeric type with precision for salary
        department VARCHAR(50),           -- Character type for department
        active BOOLEAN                    -- Boolean type for employee activity status
    );
""")
conn.commit()

# Step 2: Insert fake data into the `angestellte` table
num_records = 1000  # Number of records to insert
for _ in range(num_records):
    name = fake.name()
    age = random.randint(22, 65)
    join_date = fake.date_between(start_date='-10y', end_date='today')
    salary = round(random.uniform(30000, 150000), 2)
    department = random.choice(['Sales', 'Engineering', 'HR', 'Marketing', 'Finance'])
    active = random.choice([True, False])
    cur.execute("""
        INSERT INTO angestellte (name, age, join_date, salary, department, active)
        VALUES (%s, %s, %s, %s, %s, %s);
    """, (name, age, join_date, salary, department, active))
    print(f"CREATED {name}")
    time.sleep(0.01)
conn.commit()
print("\nDONE DONE DONE")

# Close the cursor and connection
cur.close()
conn.close()
