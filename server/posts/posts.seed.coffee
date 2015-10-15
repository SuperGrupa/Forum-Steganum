if Posts.find().count() == 0
    user_id = this.userId || '1'

    posts = ({
        _id: num.toString()
        text: 'Some dummy text #' + num + ' in topic ' + ((num % 6) + 1).toString()
        createdAt: new Date(2015, 9, 6, num % 24, 0, 0)
        updatedAt: new Date
        userId: user_id
        topic_id: ((num % 6) + 1).toString()
    } for num in [1..36])

    Posts.insert post for post in posts
