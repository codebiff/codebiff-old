// Linkify 
(function(a){a.extend({linkify:function(b,c){var d={link:{regex:/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig,template:'<a href="$1">$1</a>'},user:{regex:/(^|\s)@(\w+)/g,template:'$1<a href="http://twitter.com/#!/$2">@$2</a>'},hash:{regex:/(^|\s)#(\w+)/g,template:'$1<a href="http://twitter.com/#!/search?q=%23$2">#$2</a>'},email:{regex:/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi,template:'<a href="mailto:$1">$1</a>'}};var e=a.extend(d,c);a.each(e,function(a,c){b=b.replace(c.regex,c.template)});return b}})})(jQuery)

// Initialize syntax highlighting
hljs.initHighlightingOnLoad();


$(function(){

  // Get latest tweet
  $.getJSON("http://twitter.com/statuses/user_timeline/codebiff.json?callback=?", function(data) {
    text = data[0].text;
    $("#twitter").html($.linkify(text));
  });

  // Fix highlighting
  $("pre > code").each(function(){
    var lang = $(this).text().match(/~~(\w+)/);
    if (lang) {
      var content = $(this).html().replace(/~~(\w+)/, "").substr(1);
      var new_pre = "<pre><code class=\"" + lang[1] + "\">" + content + "</code></pre>";
      $(this).parent().after(new_pre).remove();
    }
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

});
