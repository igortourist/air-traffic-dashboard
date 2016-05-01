$(document).ready(function() {
  var flight = new Flight();

  $('.takeoff, .landing').on('click', function(e) {
    flight.control(e);
  });
});

function Flight() {
  var self = this;

  self.control = function (e) {
    var $button = $(e.currentTarget);
    var $plane = $button.closest('.plane');
    var bodyRequest = {id: $plane.data('id'), status: $button.data('status')};

    $.ajax({
      url: '/flight.json',
      type: 'post',
      content: 'json',
      data: bodyRequest
    })
    .done(function(response) {
      var plane = response.plane;
      var $plane = $('.plane[data-id=' + plane.id + ']');
      
      $plane.find('.status').html(plane.status);
      $plane.find('.takeoff').attr('disabled', plane.status !== 'pending');
      $plane.find('.landing').attr('disabled', plane.status !== 'flight');
    })
    .fail(function(jqXHR) {
      console.log(jqXHR.responseText);
    });
  };
};
