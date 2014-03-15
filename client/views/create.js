Template.create.helpers({
    categories: function () {
        return Categories;
    },
    location: function () {
        navigator.geolocation.getCurrentPosition(function (position) {
            console.log(position.coords.latitude);
            console.log(position.coords.longitude);
        });
    }
});
