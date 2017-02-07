$(document).on({
  mouseenter: function() {
    $(this).find("#info").removeClass('hidden');
    $(this).find(".photo-images").addClass('blur');
  },
  mouseleave: function() {
    $(this).find("#info").addClass('hidden');
    $(this).find(".photo-images").removeClass('blur');
  }
}, '.photo');
