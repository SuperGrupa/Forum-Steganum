function Mongo () {
    this.Collection = function(asd) {};
}

Mongo.Collection = function(asd) {};

function Meteor () {
    this.users = {};
}

Promise = {
    then: function () {},
    error: function () {}
};

Sections = {}

angular.module('angular-meteor', []);
angular.module('toastr', []);

Filter = {
  Posts: {
    by: angular.noop
  },
  Topics: {
    by: {
      section: angular.noop,
      id: angular.noop
    }
  },
  Sections: {
    by: angular.noop
  }
}
