Meteor.publish 'topics', ->
    Topics.find {},
        sort: createdAt: -1

Meteor.publish 'topicsInSection', (section_id) ->
    Topics.find { section_id: section_id },
        sort: createdAt: -1
