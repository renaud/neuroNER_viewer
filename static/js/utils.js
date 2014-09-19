// some small utils
// renaud.richardet@epfl.ch


$(document).ready(function() {

  // prevents hitting 'enter' to submit the form
  $('.no-return').keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      event.stopPropagation();
    }
  });
});


// mini templating, similar to Python's string.format()
//"hello {0}".format("world");
if (!String.prototype.format) {
    String.prototype.format = function() {
      var args = arguments;
      return this.replace(/{(\d+)}/g, function(match, number) {
        return typeof args[number] != 'undefined'
        ? args[number]
        : match
        ;
    });
  };
}

