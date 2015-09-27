Sections = new Mongo.Collection('sections')

angular.module 'sections'
.service 'sectionsServ', ($meteor) ->
    all: $meteor.collection(Sections).subscribe('sections')
