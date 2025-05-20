from app import app, db  # assumes app and db are defined in app.py

with app.app_context():
    db.create_all()
    print("✅ Tables created!")
