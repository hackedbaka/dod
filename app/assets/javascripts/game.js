

// modal stuff
$('#myModal').on('shown.bs.modal', function () {
  $('#myInput').focus()
})


//stopwatch stuff
function clsStopwatch() {
    // Private vars
    var startAt = 0;  // Time of last start / resume. (0 if not running)
    var lapTime = 0;  // Time on the clock when last stopped in milliseconds
 
    var now = function() {
        return (new Date()).getTime(); 
      }; 
 
    // Public methods
    // Start or resume
    this.start = function() {
        startAt = startAt ? startAt : now();
      };
 
    // Stop or pause
    this.stop = function() {
        // If running, update elapsed time otherwise keep it
        lapTime = startAt ? lapTime + now() - startAt : lapTime;
        startAt = 0; // Paused
      };
 
    // Reset
    this.reset = function() {
        lapTime = startAt = 0;
      };
 
    // Duration
    this.time = function() {
        return lapTime + (startAt ? now() - startAt : 0); 
      };
  };
 
var x = new clsStopwatch();
var time=$('#time').attr('value');
var clocktimer;
 
function pad(num, size) {
  var s = "0000" + num;
  return s.substr(s.length - size);
}
var h = m = s = ms = 0;

function formatTime(time) {
  
  var newTime = '';
 
  h = Math.floor( time / (60 * 60 * 1000) );
  time = time % (60 * 60 * 1000);
  m = Math.floor( time / (60 * 1000) );
  time = time % (60 * 1000);
  s = Math.floor( time / 1000 );
  ms = time % 1000;
 
  newTime = pad(h, 2) + ':' + pad(m, 2) + ':' + pad(s, 2) + ':' + pad(ms, 3);

  return newTime;
}
 
function update() {
  $('#time').text(formatTime(x.time()));
}
 
function start() {
  clocktimer = setInterval("update()", 1);
  x.start();
}
 
function stop() {
  x.stop();
  clearInterval(clocktimer);
}
 
function reset() {
  stop();
  x.reset();
  update();
}
$(function(){


$('#button1').click(function(){
    // console.log("button1 " + this.value);
    
    var button=this.value;
    var correct=$('#correct').text();
    if(correct == button)
      $('.modal-body').html("correct");
    else
    {
      $('.modal-body').html("wrong");
      console.log($('#p1_bet').text());
      var p1_bet=$('#p1_bet').text();
      var params = "p1_bet=" + p1_bet * 2;    
      var url = '../games/bet';
      $.post(url,params,function(){ console.log("request complete")});
   
      
    }

});

$('#button2').click(function(){
    // console.log("button2 "+ this.value );
  var button=this.value;
    var correct=$('#correct').text();
    if(correct == button)
      $('.modal-body').html("correct");
    else
      $('.modal-body').html("wrong");
  
});

$('#button3').click(function(){
    // console.log("button3 "+ this.value);
    var button=this.value;
   var correct=$('#correct').text();
    if(correct == button)
      $('.modal-body').html("correct");
    else
      $('.modal-body').html("wrong");

});

$('#button4').click(function(){
    // console.log("button4 "+ this.value);
    var button=this.value;
    var correct=$('#correct').text();
    if(correct == button)
      $('.modal-body').html("correct");
    else
      $('.modal-body').html("wrong");
 
});

});

