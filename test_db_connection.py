from sqlalchemy import create_engine

# Replace with your actual credentials from Railway MySQL plugin
db_uri = "mysql+mysqlconnector://root:InmSyHdmdPeDkVwCFTVDTwWTxZnVoMcb@mysql.railway.internal:3306/railway"
engine = create_engine(db_uri)

try:
    with engine.connect() as conn:
        print("✅ Connected successfully to MySQL!")
except Exception as e:
    print("❌ Connection failed:", e)
