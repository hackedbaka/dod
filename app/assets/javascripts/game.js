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

          var params = {
            player: who,
            choice: this.value
          };    
          var url = '../games/answered';
          $.post(url,params,function(){ });
      
    });

    $('#button2').click(function(){
          var params = {
          player: who,
          choice: this.value
          };    
          var url = '../games/answered';
          $.post(url,params,function(){ });
  
    });

    $('#button3').click(function(){
          var params = {
          player: who,
          choice: this.value
          };    
          var url = '../games/answered';
          $.post(url,params,function(){ });

    });

    $('#button4').click(function(){
          var params = {
            player: who,
            choice: this.value
          };    
          var url = '../games/answered';
          $.post(url,params,function(){ });
          
  
    });

    $('#double').click(function(){
      //get next question, double loser bet, reset timer
      var params = { 
        player: who  
        
      };
      $.post('../games/start_another',params,function(){ });

    });

    $('#donate').click(function(){
  //delete current game, give winner current bet from loser, and kick out both players to index page
      var win=false;
      var params = { 
        player: who,  
        win: win
      };
      $.post('../games/game_end',params,function(){ });
    });

    $('#run').click(function(){
      var win=true;
      var params = { 
        player: who,
        win: win  

      };
      $.post('../games/game_end',params,function(){ });

    });

    $('#again').click(function(){
      var params = { 
        player: who  
        
      };
      $.post('../games/start_another',params,function(){ });
    });


});


