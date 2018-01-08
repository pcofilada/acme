//= require jquery
//= require rails-ujs
//= require onmount
//= require_tree .

$(document).on('ready show.bs closed.bs load page:change', () => $.onmount());
