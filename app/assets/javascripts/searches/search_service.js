function SearchService(response) {
  this.response = response;
  this.container = $('.dropdown-menu.dropdown-menu-right.search').find('.results');
}

SearchService.prototype = {
  constructor: SearchService,

  render: function() {
    this.container.empty();
    this.anyResults() ? this.showResults() : this.noResults();
  },

  anyResults: function() {
    return this.response.count > 0 // count of records returns from backend
  },

  noResults: function()  {
    var $span = $("<span>").text('No results found');
    $("<h6>").addClass("dropdown-header").append($span).appendTo(this.container);
  },

  showResults: function() {
    var self = this;
    $.each(this.response, function (key, collection) { // each key of json
      if (collection.length > 0) {
        self.addTitle(key, collection.length);

        $.each(collection, function(ignore, item) {
          $icon = $("<span>").addClass(item.image_class);
          $span = $("<span>").addClass("offset-md-1").text(item.name);
          $pullRight = $("<span>").addClass("offset-md-1 pull-right").text(item.note);
          $("<a>").addClass("dropdown-item").attr('href', item.url).append($icon).append($span).append($pullRight).appendTo(self.container);
        });
      }
    });
  },

  addTitle: function(title, count) {
    var $span = $("<span>").text(title);
    var $count = $("<span>").addClass("pull-right count").text(count);
    $("<h6>").addClass("dropdown-header").append($span).append($count).appendTo(this.container);
  }
};
