$(document).on('turbolinks:load', function () {

// Home_Modal//
  $('#signup').click(function(){
    $('#signup_modal').addClass('active');
  });

  $('#login').click(function(){
    $('#login_modal').addClass('active');
  });

  $('#post_new').click(function(){
    $('#post_modal').addClass('active');
  });

  $('.close_button').click(function(){
    $(this).parents('.modal_form').removeClass('active');
  });

  $('.flash').click(function(){
    $(this).fadeOut();
  });

// My Page //

  $('.prof_show').click(function(){
    $(this).removeClass('active');
    $(this).parent('.prof_contents').children('.prof_edit').addClass('active');
  });

  $('#pass_change').click(function(){
    $('#password_change').addClass('active');
  });

  $('#destroy_btn').click(function(){
    $('#user_destroy').addClass('active');
  });

  //show_post //
  $('#destroy_btn_post').click(function(){
    $('#post_destroy').addClass('active');
  });

});
