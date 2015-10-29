Meteor.methods
    seedPosts: ->
        # najpierw wyczyść bazę danych (kolekcja postów)
        Posts.remove {}
        users = (entry._id for entry in Meteor.users.find({}, fieds: {}).fetch())
        usersLength = users.length

        # posts = ({
        #     _id: num.toString()
        #     text: 'Some dummy text #' + num + ' in topic ' + ((num % 6) + 1).toString()
        #     createdAt: new Date(2015, 9, 6, num % 24, 0, 0)
        #     updatedAt: new Date
        #     userId: users[Math.floor((Math.random() * users.length))]
        #     topic_id: ((num % 18) + 1).toString()
        # } for num in [1..36])

        posts = [
          {
            _id: '1'
            topic_id: '1'
            text: 'If you live in a country where rabies exists, take no chances and see a doctor immediately. Also have the dog checked by blood test, as a precaution. If you live in a country with no rabies, it would still be wise to show your bruising to your doctor.'
            createdAt: new Date(2015, 9, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '2'
            topic_id: '1'
            text: 'What exactly happened that caused your dog to bite you? Was it an accident? (I was bitten a couple of times during play with a neighbours dog)If it was not during play, but from nervousness or aggression, I do advise you to see or talk to an animal behaviourist as soon as you can, to find a way to stop this happening. The dogs life and welfare could be at risk, and it would be a good investment in his/her future as well as your own.'
            createdAt: new Date(2015, 9, 7, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '3'
            topic_id: '1'
            text: 'A good article on bites... http://www.uptodate.com/contents/ani...ond-the-basics'
            createdAt: new Date(2015, 10, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '4'
            topic_id: '2'
            text: 'It would help if you stated what kind of pets they are, what size, etc. Generally speaking, the best cage is no cage at all, but some pets do need one (for example to keep a bird safe when a cat is in the room).'
            createdAt: new Date(2015, 9, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '5'
            topic_id: '3'
            text: '77% of dog bites come from the family dog, or a friends dog. Teach children to respect and understand dogs, using these helpful short videos and information: http://www.stopthe77.com https://youtu.be/HCh36FdCpy0'
            createdAt: new Date(2015, 9, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '6'
            topic_id: '3'
            text: 'Very useful links, with excellent advice. Thanks so much for starting this thread, Tobi. I have rated it five stars - which it deserves, but also to draw attention to it. This site gets a large number of visitors each day, many many times more than the member visits made. On many days, there are hundreds of visitors at the same time. So your thread will reach and help a lot of people.'
            createdAt: new Date(2015, 10, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '7'
            topic_id: '4'
            text: 'Hi)A few days ago I bought a kitten similar to this picture http://lodozo.com/us-en/detail/kitten/grey-kitten/ (sorry,but i dont have other image yet)))Its insanely cute and affectionate,but I dont know how to properly care for this breed,somebody tell me or give advice)I would be grateful.'
            createdAt: new Date(2015, 9, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '8'
            topic_id: '4'
            text: 'Firstly, welcome to the forum! I suggest that you upload a picture of your kitten, as the page you have given shows photos of lots of different types.'
            createdAt: new Date(2015, 9, 6, 14, 23, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '9'
            topic_id: '5'
            text: 'There is a stray cat whos had kittens in my next door neighbours shed. She had 5 babies Im finding them all homes. But would the vets be able to check them over for free to make sure there all healthy before they go to there forever loving homes ?'
            createdAt: new Date(2015, 9, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '10'
            topic_id: '5'
            text: 'ou can ask your local vets. I doubt whether a vet would do this for nothing, but you might find find one with a kind heart if you are short of money.'
            createdAt: new Date(2015, 9, 7, 12, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '11'
            topic_id: '5'
            text: 'Probably not all for free. You could see if a TNR place will fix them and give them shots, but to do that they usually only want feral cats, not adoptable kittens. They will also cut the corner of one ear to show they are fixed, and some people may not like that in a pet. Around where I live, each vaccine (distemper modified live and rabies always killed) costs about $45 per shot, maybe around $50-100 for the visit. Both the rabies and distemper come in a series of at least 2, and rabies can only be given at 12 weeks of age. Of course that price differs from place to place and clinic to clinic. If you wanted an FeLV test, the cheap ones cost around $12-15 per test. FIV combo test costs more. Then theres the cost of getting them all fixed, which very quickly adds up. Its much better to get them fixed before they reach sexual maturity, to avoid behavior issues and to keep from having to pay extra for a gravid or mid estrus spay.'
            createdAt: new Date(2015, 9, 8, 14, 30, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '12'
            topic_id: '6'
            text: 'Long story short my cat broke his leg and i didint think 1sec before i take to fix that and now i need help to pay his bills. Donate or share this link forward will help a lot! Thank you, More info inside of this link'
            createdAt: new Date(2015, 9, 6, 1, 0, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '13'
            topic_id: '6'
            text: 'Welcome to the forum. Please introduce yourself first, before making any more posts or appeals for money. If you wish, you may post the name, address, telephone number and website of the vet who is treating your pet, so that members can verify the details independently and possibly send money to the vet direct if they so wish.'
            createdAt: new Date(2015, 9, 6, 6, 23, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
          {
            _id: '14'
            topic_id: '6'
            text: 'Good idea LPC, would be safer to donate that way.'
            createdAt: new Date(2015, 9, 6, 8, 45, 0)
            updatedAt: new Date
            userId: users[Math.floor((Math.random() * users.length))]
          }
        ]

        Posts.insert post for post in posts
