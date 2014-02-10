$(function(){
  $('a').click(function(){
    $('html, body').animate({
        scrollTop: $( $(this).attr('href') ).offset().top
    }, 800);
    return false;
  });
});
$(function(){
  $("#eventslist2").on('click','input[type=checkbox]',function(e){
    var brother="#eventslist input[type='checkbox'][value="+this.value+"]";
    if (this.checked){
      $(brother).prop('checked', true);
    }
    else {
      $(brother).prop('checked', false);
    }
  });
});
$(function(){
  $("#eventslist").on('click','input[type=checkbox]',function(e){
    var brother="#eventslist2 input[type='checkbox'][value="+this.value+"]";
    if (this.checked){
      $(brother).prop('checked', true);
    }
    else {
      $(brother).prop('checked', false);
    }
  });
});
$(function(){
  $("input[name='commit'][value='submit']").on('click',function(e){
    var nameMissing=false;
    if($('#attendee_name').val()===''){
        e.preventDefault();
        $('#attendee_name').addClass("inputError");
        $('#attendee_name').prop('placeholder',"Input required");
        $('#attendee_name').focus();
        nameMissing=true;
    }
    if($('#attendee_email').val()===''){
      $('#attendee_email').addClass("inputError");
      $('#attendee_email').prop('placeholder',"Input required");
      if (!nameMissing){
        e.preventDefault();
        $('#attendee_email').focus();
      }
    }
    else{
      var email_pat = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$/i;
      if (email_pat.exec($('#attendee_email').val())===null){
        $('#attendee_email').addClass("inputError");
        $('#attendee_email').val(null);
        $('#attendee_email').prop('placeholder',"Email is wrong");
        if (!nameMissing){
          e.preventDefault();
          $('#attendee_email').focus();
        }
      }
    }
  });
});
$(function(){
  $('#attendee_name').on('keyup',function(e){
    if($('#attendee_name').val()!=''){
        $('#attendee_name').removeClass("inputError");
    }
  });
});
$(function(){
  $('#attendee_email').on('keyup',function(e){
    if($('#attendee_email').val()!=''){
        $('#attendee_email').removeClass("inputError");
    }
  });
});