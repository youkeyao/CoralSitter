# Server for project

## static file
- coral_avatar  // 珊瑚头像
    - 1.jpg // coralID.jpg
    - 2.jpg
    ...
    - default.jpg // 默认头像
- coral_bg      // 珊瑚背景
    - 1 // coralID
        - 1.jpg // 三张背景
        - 2.jpg
        - 3.jpg
    - 2
        - 1.jpg
        - 2.jpg
        - 3.jpg
    ...
- coral_intro   // 珊瑚介绍
    - acropora.jpg
- daily         // 每日精选
    - 1.jpg
    - 2.jpg
    - 3.jpg
- storys        // 珊瑚故事
    - 1 // coralID
        - 1.jpg // 三张背景
        - 2.jpg
        - 3.jpg
    - 2
        - 1.jpg
        - 2.jpg
        - 3.jpg
    ...
    - default.jpg
- user_avatar   // 用户头像
    - 1.jpg // userID.jpg
    - 2.jpg
    ...
    - default.jpg // 默认头像

## route
- /login 判断用户名和密码是否正确
    - post
    ```
    {
        'username': string,
        'password': string
    }
    ```
    - response
    ```
    正确
    {
        'userID': int,
        'username': string,
        'sign': string,
        'tags': string, // 外向开朗-热情-心思细腻
        'mycorals': [   // 所有拥有珊瑚信息
            {
                'coralID': int,
                'coralname': string,
                'position': string,
                'updatetime': string, // 2021.1.2
                'light': string, // 充足
                'temp': string, // 温暖
                'microelement': string, // 偏少
                'size': int, // cm
                'lastmeasure': float, // cm
                'growth': float, // cm
                'score': int,
                'birthtime': string, // 2021.1.2
                'adopttime': string, // 2021.1.2
                'species': {    //珊瑚种类信息
                    'species': string,
                    'speciesen': string,
                    'tags': string, // 好强-敏感
                    'classification': string, // 大类
                    'classificationen': string,
                    'difficulty': int, // 1~5
                    'growspeed': string, // 快
                    'current': current, // 中弱
                    'light': light, // 中等
                    'feed': feed, // 低
                    'color': color, // FFFFFF-FBFCBB
                    'attention': attention, // 易碎-毒性强
                },
            },
            ...
        ],
        'success': True
    }
    错误
    {
        'success': False
    }
    ```
- /signup 根据用户名和密码进行注册
    - post
    ```
    {
        'username': username,
        'password': password
    }
    ```
    - response
    ```
    成功
    {
        'userID': userID,
        'username': username,
        'sign': sign,
        'tags': tags,
        'mycorals': [],
        'success': True
    }
    失败
    {
        'success': False
    }
    ```
- /changeUserInfo 更改用户信息
    - post
    ```
    {
        'userID': userID,
        'username': username,
        'sign': sign,
        'tags': tags,
        'avatar': avatar, // base64编码字节流图片
    }
    ```
    - response
    ```
    成功
    {
        'success': True
    }
    失败
    {
        'success': True
    }
    ```
- /match 匹配 返回珊瑚种类
    - post
    ```
    {
        'tags': tags
    }
    ```
    - response
    ```
    {
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
    ```
- /box 盲盒 返回珊瑚种类
    - post
    ```
    {
    }
    ```
    - response
    ```
    {
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
    ```
- /listCorals 返回指定种类的所有珊瑚
    - post
    ```
    {
        'species': species
    }
    ```
    - response
    ```
    {
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
    ```
- /adopt 领养珊瑚，更改珊瑚对应信息
    - post
    ```
    {
        'coralID': coralID
        'username': username,
        'coralname': coralname,
        'position': position,
    }
    ```
    - response
    ```
    成功
    {
        'success': True
    }
    失败
    {
        'success': True
    }
    ```
- /gePos 返回可选位置
    - post
    ```
    {
    }
    ```
    - response
    ```
    {
        'pos': [
            "凤凰岛西侧海域",
            "渤海东侧海域",
            ...
        ]
    }
    ```
- /getStory 根据珊瑚ID返回珊瑚故事
    - post
    ```
    {
        'coralIDs': [1， 2...]
    }
    ```
    - response
    ```
    {
        'story': [
            {
                'coralID': coralID,
                'time': time,
                'text': text,
                'image': string, // 1/2021_1_2.jpg
            },
            ...
        ]
    }
    ```