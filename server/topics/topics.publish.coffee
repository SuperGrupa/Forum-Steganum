Meteor.publish 'topicsInSection', (section_id) ->
    Filter.Topics.by.section(section_id)
