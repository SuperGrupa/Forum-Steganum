authServ = ($rootScope, $stateParams) ->

    return (what, name, object) ->
        user = $rootScope.currentUser
        sectionId = $stateParams.section_id
        topicId = object.topic_id || $stateParams.topic_id

        if !user
            if name == 'section' && what == 'read'
                return true
            else
                return false

        if user.can[what][name]
            return true

        if name == 'post'
            if !!topicId && topicId in user.can[what].in.topic
                return true
            if !!sectionId && sectionId in user.can[what].in.section
                return true

        if name == 'topic'
            if !!sectionId && sectionId in user.can[what].in.section
                return true

        if user.can[what].self[name] && user._id == object.userId
            return true

        return false



authServ.$inject = ['$rootScope', '$stateParams']

angular.module 'users'
.service 'authServ', authServ
