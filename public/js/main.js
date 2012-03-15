$(function(){

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
