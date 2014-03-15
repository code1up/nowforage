Router.configure({
  layoutTemplate: 'layout'
});

Router.map(function () {
  this.route('create', {
    path: '/',
    template: 'create'
  });
});
