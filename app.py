from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# 📦 MySQL connection with SQLAlchemy
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:syedminhaj9270@localhost/student_management'


app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:InmSyHdmdPeDkVwCFTVDTwWTxZnVoMcb@mysql.railway.internal:3306/railway'


db = SQLAlchemy(app)

# 🧾 Student Model
class Student(db.Model):
    __tablename__ = 'students'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(120))
    dob = db.Column(db.Date)

    def __repr__(self):
        return f"<Student {self.name}>"

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/students')
def show_students():
    students = Student.query.all()
    return render_template('students.html', students=students)



@app.route('/add-student', methods=['GET', 'POST'])
def add_student():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        dob = request.form['dob']

        new_student = Student(name=name, email=email, dob=dob)
        db.session.add(new_student)
        db.session.commit()

        return redirect(url_for('show_students'))

    return render_template('add_student.html')

class Course(db.Model):
    __tablename__ = 'courses'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    teacher_id = db.Column(db.Integer)

@app.route('/courses')
def show_courses():
    courses = Course.query.all()
    return render_template('courses.html', courses=courses)



# Model
class Teacher(db.Model):
    __tablename__ = 'teachers'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(120))

# Route
@app.route('/teachers')
def show_teachers():
    teachers = Teacher.query.all()
    return render_template('teachers.html', teachers=teachers)


# Model
class Enrollment(db.Model):
    __tablename__ = 'enrollments'
    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer)
    course_id = db.Column(db.Integer)

# Route
@app.route('/enrollments')
def show_enrollments():
    enrollments = Enrollment.query.all()
    return render_template('enrollments.html', enrollments=enrollments)



# Model
class Result(db.Model):
    __tablename__ = 'results'
    id = db.Column(db.Integer, primary_key=True)
    enrollment_id = db.Column(db.Integer)
    score = db.Column(db.Float)

@app.route('/results')
def show_results():
    results = Result.query.all()
    return render_template('results.html', results=results)


import os

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
