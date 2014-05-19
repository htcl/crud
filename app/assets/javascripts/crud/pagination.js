$(function() {
  $(document).on("click", ".pagination a", function() {
    $(".pagination_overlay").html("Page is loading...");
    $.get(this.href, pagination_parameters(), null, "script");
    return false;
  });

  $(document).on("change", "select#per_page", function() {
    $(".pagination_overlay").html("Page is loading...");
    $.get(this.href, pagination_parameters(), null, "script");
    return false;
  });

  $(document).on("submit", "form#search_form", function() {
    $(".pagination_overlay").html("Page is loading...");
    $.get(this.href, pagination_parameters(), null, "script");
    return false;
  });

  //$(document).on("change", "input#search", function() {
  //  $(".pagination_overlay").html("Page is loading...");
  //  $.get(this.href, pagination_parameters(), null, "script");
  //  return false;
  //});

  $(document).on("change", "input#advanced_search", function() {
    $(".pagination_overlay").html("Page is loading...");
    $.get(this.href, pagination_parameters(), null, "script");
    return false;
  });

  function pagination_parameters()
  {
    return {
      page: $("input#page").val(),
      per_page: $("select#per_page").val(),
      search: $("input#search").val(),
      advanced_search: $("input#advanced_search").is(':checked')
    };
  }

});
