Sections = new Mongo.Collection('sections')
Topics = new Mongo.Collection('topics')

angular.module 'sections'
.service 'sectionsServ', ($meteor) ->
    all: $meteor.collection(Sections).subscribe('sections')

    getTopics: (section_id) ->
        topics = []
        $meteor.subscribe('sectionTopicIds', section_id).then ->
            section = Sections.findOne({ _id: section_id }) || { }
            topic_ids = section.topic_ids || []

            unless topic_ids.length == 0
                $meteor.subscribe('topicsByIds', topic_ids).then ->
                    topics = Topics.find({ _id: { $in: topic_ids } }).fetch()

        return topics
