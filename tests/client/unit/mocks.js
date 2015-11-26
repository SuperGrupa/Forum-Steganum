function Mongo () {
    this.Collection = function(asd) {};
}

Mongo.Collection = function(asd) {};

function Meteor () {
    this.users = {};
}

Sections = {};
Images = {
    insert: function () { return {_id: 'abc'}; }
};

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

_ = {
    isEmpty: angular.noop,
    first: angular.noop
}
