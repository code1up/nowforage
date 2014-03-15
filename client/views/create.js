Template.create.helpers({
    categories: function () {
        return Categories;
    },

    items: function () {
        return Items;
    },
    
    location: function () {
        navigator.geolocation.getCurrentPosition(function (position) {
            console.log(position.coords.latitude);
            console.log(position.coords.longitude);
        });
    }
});

Template.create.events({
    "click #addButton": function(e) {
        e.preventDefault();

        var category = document.getElementById("category").value;
        var description = document.getElementById("description").value;

        var item = {
            category: category,
            description: description
        };

        Items.insert(item);
    }
});
