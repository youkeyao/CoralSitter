from flask import Flask, request, g
from contextlib import closing
import config
import sqlite3
import shutil

app = Flask(__name__)

'''
init the database
'''
def init_db():
    with closing(connect_db()) as db:
        with open('data.sql') as f:
            db.cursor().executescript(f.read())
        db.commit()

def connect_db():
    return sqlite3.connect(config.DATABASE)

'''
help function for database
'''
def query_db(query, args=(), one=False):
    cur = g.db.execute(query, args)
    rv = [dict((cur.description[idx][0], value)
        for idx, value in enumerate(row)) for row in cur.fetchall()]
    return (rv[0] if rv else None) if one else rv

'''
connect database before request
'''
@app.before_request
def before_request():
    g.db = connect_db()

'''
close database after request
'''
@app.teardown_request
def teardown_request(exception):
    if hasattr(g, 'db'):
        g.db.close()

'''
login route
post: {
    'username': username,
    'password': password
}
response: {
    'username': username,
    'sign': sign,
    'tags': tags,
    'mycorals': [
        {
            'master': master,
            'coralname': coralname,
            'position': position,
            'updatetime': updatetime,
            'tags': tags,
            'species': species,
            'light': light,
            'temp': temp,
            'microelement': microelement,
            'size': size,
            'lastmeasure': lastmeasure,
            'growth': growth,
            'score': score,
        },
        ...
    ],
    'success': True/False
}
'''
@app.route('/login',methods=["POST"])
def login():
    username = request.form['username']
    password = request.form['password']
    user = query_db('select * from users where username = ?',
        [username], one=True)

    if user and user['password'] == password:
        user['success'] = True
        corals = query_db('select * from corals where master = ?',
            [username])
        user['mycorals'] = []
        for coral in corals:
            user['mycorals'].append(coral)
    else:
        user = {}
        user['success'] = False
    return user

'''
signup route
post: {
    'username': username,
    'password': password
}
response: {
    'username': username,
    'sign': sign,
    'tags': tags,
    'mycorals': {
        master,
        coralname,
        position,
        updatetime,
        tags,
        species,
        light,
        temp,
        microelement,
        size,
        lastmeasure,
        growth,
        score,
    },
    'success': True/False
}
'''
@app.route('/signup',methods=["POST"])
def signup():
    username = request.form['username']
    password = request.form['password']

    response = {}
    try:
        cur = g.db.execute('insert into users values(?, ?, ?, ?)',
            [username, password, "无签名", "无标签"])
        g.db.commit()
        shutil.copy("./static/user_avatar/default.jpg", "./static/user_avatar/" + username + ".jpg")
        response['success'] = True
        response = {
            'username': username,
            'sign': "无签名",
            'tags': "无标签",
            'mycorals': [],
            'success': True,
        }
    except:
        response['success'] = False
    return response


# main
if __name__ == '__main__':
    app.config.from_object(config)
    app.run(host="0.0.0.0", port=3000)