// Linkify 
(function(a){a.extend({linkify:function(b,c){var d={link:{regex:/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig,template:'<a href="$1">$1</a>'},user:{regex:/(^|\s)@(\w+)/g,template:'$1<a href="http://twitter.com/#!/$2">@$2</a>'},hash:{regex:/(^|\s)#(\w+)/g,template:'$1<a href="http://twitter.com/#!/search?q=%23$2">#$2</a>'},email:{regex:/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi,template:'<a href="mailto:$1">$1</a>'}};var e=a.extend(d,c);a.each(e,function(a,c){b=b.replace(c.regex,c.template)});return b}})})(jQuery)

hljs.initHighlightingOnLoad();

$(function(){
  $.getJSON("http://twitter.com/statuses/user_timeline/codebiff.json?callback=?", function(data) {
    text = data[0].text;
    $("#twitter").html($.linkify(text));
  });
});