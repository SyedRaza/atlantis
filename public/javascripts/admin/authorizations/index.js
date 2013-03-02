/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
  $('input[type=checkbox]').live('change', function(){
    id = $(this).closest('td').find('#pid').val();
    if ( $(this).val() == 'all' ) {
      if ( $(this).attr('checked') ) {
        $(this).closest('td').find('input[type=checkbox]').each(function(i){
          $(this).attr('checked', true);
        });
        action = 'all';
        mode = 'activate';
      } else {
        $(this).closest('td').find('input[type=checkbox]').each(function(i){
          $(this).attr('checked', false);
        });
        action = 'none';
        mode = 'deactivate';
      }
    } else {
      action = $(this).attr('id').split('_');
      action = action[action.length-1];
      mode =  $(this).attr('checked') ? 'activate' : 'deactivate';
    }
    $.getScript('/admin/authorizations/set_permissions/'+action+'/'+mode+'/'+id)
  });


  $('.data-table td').mouseover(function(){
    $(this).parent().find('td').each(function(i){
      $(this).addClass('highlight')
    });
  });

  $('.data-table td').mouseout(function(){
    $(this).parent().find('td').each(function(i){
      $(this).removeClass('highlight')
    });
  });

});