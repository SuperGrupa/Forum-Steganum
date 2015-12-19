function BuildCtrl() {
  var vm = this;
  jQuery.getJSON("build.json").then(function(data) {
    vm.info  = data;
  });
}

angular.module('forumSteganum')
.controller('BuildCtrl', BuildCtrl)
