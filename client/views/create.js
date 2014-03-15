Template.create.created = function () {
    navigator.geolocation.getCurrentPosition(function (position) {
        Session.set("position", position);
    });
};

Template.create.rendered = function () {
    if (this._alreadyCalled) {
        return;
    }

    this._alreadyCalled = true;

    var video = this.find("video");

    navigator.getUserMedia =
        navigator.getUserMedia ||
        navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia ||
        navigator.msGetUserMedia;

    video.onloadedmetadata = function(e) {
        console.log("onloadedmetadata");
    };
        
    var options = {
        video: true,
        audio: false
    };

    navigator.getUserMedia(options, function (stream) {
        // video.src = window.URL.createObjectURL(stream);
        video.src = window.webkitURL.createObjectURL(stream);

        video.play();

    }, function(e) {
        console.log("Video failed!");
        console.log(e);
    });    
};

Template.create.helpers({
    categories: function () {
        return Categories;
    },

    items: function () {
        return Items;
    },

    allItems: function () {
        return Items.find();
    },
    
    position: function () {
        return Session.get("position");
    }
});

Template.create.events({
    "click #addButton": function (e) {
        e.preventDefault();

        var category = document.getElementById("category").value;
        var description = document.getElementById("description").value;

        var item = {
            category: category,
            description: description
        };

        Items.insert(item);
    },

    "click #snapButton": function (e) {
        e.preventDefault();

        var video = document.getElementById("video");
        var canvas = document.getElementById("canvas");
        var context = canvas.getContext("2d");

        context.drawImage(video, 0, 0, 640, 480);

        console.log("SNAPPED!");
    }
});
