from flask import Flask, request, g
from contextlib import closing
import config
import sqlite3
import shutil
import base64

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
    'userID': userID,
    'username': username,
    'sign': sign,
    'tags': tags,
    'mycorals': [
        {
            'coralID': coralID,
            'coralname': coralname,
            'position': position,
            'updatetime': updatetime,
            'light': light,
            'temp': temp,
            'microelement': microelement,
            'size': size,
            'lastmeasure': lastmeasure,
            'growth': growth,
            'score': score,
            'birthtime': birthtime,
            'adopttime': adopttime,
            'species': {
                'species': species,
                'speciesen': speciesen,
                'tags': tags,
                'classification': classification,
                'classificationen': classificationen,
                'difficulty': difficulty,
                'growspeed': growspeed,
                'current': current,
                'light': light,
                'feed': feed,
                'color': color,
                'attention': attention,
            },
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
            species = query_db('select * from coralspecies where species = ?',
                [coral['species']], one=True)
            coral['species'] = species
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
    'userID': userID,
    'username': username,
    'sign': sign,
    'tags': tags,
    'mycorals': [],
    'success': True/False
}
'''
@app.route('/signup',methods=["POST"])
def signup():
    username = request.form['username']
    password = request.form['password']
    user = query_db('select * from users where username = ?',
        [username], one=True)

    response = {}

    if user:
        response['success'] = False
        return response

    try:
        g.db.execute('insert into users values(?, ?, ?, ?, ?)',
            [None, username, password, "无签名", "无标签"])
        g.db.commit()
        user = query_db('select * from users where username = ?',
            [username], one=True)
        print(user)
        shutil.copy("./static/user_avatar/default.jpg", "./static/user_avatar/" + str(user['userID']) + ".jpg")
        response = {
            'userID': user['userID'],
            'username': username,
            'sign': "无签名",
            'tags': "无标签",
            'mycorals': [],
            'success': True,
        }
    except:
        response['success'] = False
    return response

'''
changeUserInfo route
post: {
    'userID': userID,
    'username': username,
    'sign': sign,
    'tags': tags,
    'avatar': avatar,
}
response: {
    'success': True/False
}
'''
@app.route('/changeUserInfo',methods=["POST"])
def changeUserInfo():
    userID = request.form['userID']
    username = request.form['username']
    sign = request.form['sign']
    tags = request.form['tags']
    avatar = request.form['avatar']

    response = {}

    try:
        if avatar != '':
            file = open("./static/user_avatar/" + str(userID) + ".jpg", 'wb')
            file.write(base64.b64decode(avatar))
            file.close()
        response['success'] = True
    except:
        response['success'] = False
    
    return response

'''
match route
post: {
    'tags': tags
}
response: {
    'species': species,
    'speciesen': speciesen,
    'tags': tags,
    'classification': classification,
    'classificationen': classificationen,
    'difficulty': difficulty,
    'growspeed': growspeed,
    'current': current,
    'light': light,
    'feed': feed,
    'color': color,
    'attention': attention,
}
'''
@app.route('/match',methods=["POST"])
def match():
    tags = request.form['tags']

    species = query_db('select * from coralspecies',
        [],)
    
    return species[0]

'''
box route
post: {
}
response: {
    'species': species,
    'speciesen': speciesen,
    'tags': tags,
    'classification': classification,
    'classificationen': classificationen,
    'difficulty': difficulty,
    'growspeed': growspeed,
    'current': current,
    'light': light,
    'feed': feed,
    'color': color,
    'attention': attention,
}
'''
@app.route('/box',methods=["POST"])
def box():
    species = query_db('select * from coralspecies',
        [],)
    
    return species[0]

'''
listCorals route
post: {
    'species': species
}
response: {
    'result': [
        {
            'coralID': coralID,
            'coralname': coralname,
            'position': position,
            'updatetime': updatetime,
            'light': light,
            'temp': temp,
            'microelement': microelement,
            'size': size,
            'lastmeasure': lastmeasure,
            'growth': growth,
            'score': score,
            'birthtime': birthtime,
            'adopttime': adopttime,
            'species': species,
        },
        ...
    ]
}
'''
@app.route('/listCorals',methods=["POST"])
def listCorals():
    species = request.form['species']

    corals = query_db('select * from corals where species = ?',
        [species])

    return {'result': corals}

'''
adopt route
post: {
    'coralID': coralID
    'username': username,
    'coralname': coralname,
    'position': position,
}
response: {
    'success': True/False
}
'''
@app.route('/adopt',methods=["POST"])
def adopt():
    return {'success': True}

'''
getPos route
post: {
}
response: {
    'pos': [
        "凤凰岛西侧海域",
        "渤海东侧海域"
    ]
}
'''
@app.route('/getPos',methods=["POST"])
def getPos():
    return {
        'pos': [
            "凤凰岛西侧海域",
            "渤海东侧海域"
        ]
    }

'''
getStory route
post: {
    'coralIDs': [...]
}
response: {
    'story': [
        {
            'coralID': coralID,
            'time': time,
            'text': text,
            'image': image,
        }
    ]
}
'''
@app.route('/getStory',methods=["POST"])
def getStory():
    coralIDs = request.form['coralIDs'].split('-')
    return {
        'story': [
            {
                'coralID': 1,
                'time': '2021年1月2日',
                'text': '小丑鱼拜访了我',
                'image': '1/2021_1_2.jpg',
            },
            {
                'coralID': 1,
                'time': '2021年1月2日',
                'text': '小丑鱼拜访了我',
                'image': '1/2021_1_2.jpg',
            },
        ]
    }

# main
if __name__ == '__main__':
    app.config.from_object(config)
    app.run(host="0.0.0.0", port=config.PORT)