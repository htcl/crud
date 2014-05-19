// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
    $('select#klass_list').change(function() {
        location.href = $(this).val();
    });
});
