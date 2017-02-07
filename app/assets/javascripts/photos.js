$(document).on({
  mouseenter: function() {
    $(this).find("#hoverbox").removeClass('hidden');
    $(this).find(".photo-images").addClass('blur');
  },
  mouseleave: function() {
    $(this).find("#hoverbox").addClass('hidden');
    $(this).find(".photo-images").removeClass('blur');
  }
}, '.photo');
