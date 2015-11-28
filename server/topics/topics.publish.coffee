auth = require('authFunctions')

Meteor.publish 'topicsInSection', (section_id) ->
    if auth.can('read', 'section', section_id, this.userId)
        Filter.Topics.by.section(section_id)
