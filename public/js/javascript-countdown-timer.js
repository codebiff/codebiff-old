var days    = 24*60*60,
    hours   = 60*60,
    minutes = 60;

var d, h, m, s;

var endTime = new Date().setHours(23,59,59,0);
var now     = new Date().getTime();

setInterval(function() {
  
  s = Math.floor((endTime - now) / 1000) ;
  s = (s < 0) ? 0 : s;
  
  d = Math.floor(s/days);
  document.getElementById("timer-days").innerHTML = d;
  s -= d*days;

  h = Math.floor(s/hours);
  document.getElementById("timer-hours").innerHTML = h;
  s -= h*hours;

  m = Math.floor(s/minutes);
  document.getElementById("timer-minutes").innerHTML = m;
  s -= m*minutes;
  
  document.getElementById("timer-seconds").innerHTML = s;
  
  now += 1000;
  
}, 1000);