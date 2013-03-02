/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    jQuery( "#tabs" ).tabs();

    $("#tabs").tabs({
      select: function(event, ui){

          $(".content > #title").each(function(){

              $(this).parents().show();
              var content = $(this).text().toLowerCase();
              var tab = $(ui.tab).text().toLowerCase();
              //alert(content)
              //alert(tab)
              if(tab == "all"){
                  $("#tabs-1 > div").each(function(){
                      $(this).css("display", "block")
                  })
              }
              else if(content.indexOf(tab) != 0){
                  //alert(tab)
                  //tab.hide()
                  $(this).parent().hide()

              }
          })
      }
    });

    var contents = new Array()
    $(".content > #title").each(function(){
        //alert($(this).text())
        contents.push($(this).text().toLowerCase())
    });
    contents.sort();
    //alert(contents[0])


    var count = 0
    while(count < contents.length){
        $("#tabs ul a").each(function(){
            if($(this).text().toLowerCase() == "all") {$(this).show()}
            else {
                if(count < contents.length){
                    var index = contents[count].indexOf($(this).text().toLowerCase())
                    //var content = $(this).text().toLowerCase();
                    //alert(index)
                    if(index == 0) {
                        $(this).show();
                        count++
                    }
                    else {$(this).hide()}
                }
                else {$(this).hide()}
            }
        })
    }
})