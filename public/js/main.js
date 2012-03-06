// Linkify 
(function(a){a.extend({linkify:function(b,c){var d={link:{regex:/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig,template:'<a href="$1">$1</a>'},user:{regex:/(^|\s)@(\w+)/g,template:'$1<a href="http://twitter.com/#!/$2">@$2</a>'},hash:{regex:/(^|\s)#(\w+)/g,template:'$1<a href="http://twitter.com/#!/search?q=%23$2">#$2</a>'},email:{regex:/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi,template:'<a href="mailto:$1">$1</a>'}};var e=a.extend(d,c);a.each(e,function(a,c){b=b.replace(c.regex,c.template)});return b}})})(jQuery)

$(function(){

  // Get latest tweet
  $.getJSON("http://twitter.com/statuses/user_timeline/codebiff.json?callback=?", function(data) {
    text = data[0].text;
    $("#twitter").html($.linkify(text));
  });

   // change search arrow when input entered
   img1 = new Image(); // preload image to stop flash
   img1.src = "../images/arrow-curve.png";

   $("#side-search").keyup(function(){
      if ($(this).val().trim() == "") {
        $(".sidebar-search button").css("background-image", "url(../images/arrow-curve-gray.png)");
      } else {
        $(".sidebar-search button").css("background-image", "url(../images/arrow-curve.png)");
      }
   });

   // Open all external links in new window
   $("a[href^='http://']").attr("target","_blank");
   $("a[href^='https://']").attr("target","_blank");
   
});
