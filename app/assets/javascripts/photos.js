$(document).ready(function() {
  $(".photo").hover(
    function() {
      $(this).find("#hoverbox").removeClass('hidden');
      $(this).find(".photo-images").addClass('blur');
    }, function() {
      $(this).find("#hoverbox").addClass('hidden');
      $(this).find(".photo-images").removeClass('blur');
    }
  )
});
