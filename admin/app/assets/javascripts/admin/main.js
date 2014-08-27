function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("div.nestedfield").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(function () {

  $app_group = $(".app-group");
  var $android_app_group = $(".android-app-group");
  var $ios_app_group = $(".ios-app-group");
  var $amazon_app_group = $(".amazon-app-group");

  $("select#app_platform").change(function () {
    var platform = $(this).val();

    switch(platform) {
      case "android":
        $app_group.addClass("hide");
        $android_app_group.removeClass("hide");
        break;
      case "ios":
        $app_group.addClass("hide");
        $ios_app_group.removeClass("hide");
        break;
      case "amazon":
        $app_group.addClass("hide");
        $amazon_app_group.removeClass("hide");
        break;
    }
  }).trigger('change');

  $(".view-token").popover();
});