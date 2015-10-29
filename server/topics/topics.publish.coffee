Meteor.publish 'topicsInSection', (section_id) ->
    Filter.Topics.by(section_id)
