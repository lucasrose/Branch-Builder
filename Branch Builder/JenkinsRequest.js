var jenkinsapi = require('jenkins-api');
var jenkins = jenkinsapi.init('https://${username}:${token}@http://jenkins.reach.rackspace.com');

var test = function {
    return "test"
}

var buildWithParameters = function(err, data) {
    jenkins.build('job-in-jenkins', {key: 'value'}, function(err, data) {
        if (err){ return console.log(err); }
            console.log(data)
    });
}
