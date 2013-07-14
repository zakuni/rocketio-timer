io = new RocketIO().connect();

// receive "tick" from server
io.on("tick", function(time){
  $("#timer").html( $("<p>").text(time) );
});
