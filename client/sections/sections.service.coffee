@Sections = new Mongo.Collection('sections')

angular.module 'sections'
.service 'sectionsServ', ($meteor, $q) ->
    all: $meteor.collection(Sections).subscribe('sections')

    getTopics: (section_id) ->
        $meteor.call 'getTopicsOfSection', section_id
