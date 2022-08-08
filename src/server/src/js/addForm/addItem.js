
(function ($) {
    $(document).ready(function(){
        // Open modal on page load
        $("#itemModal").modal('show');
 
        // Close modal on button click
        $(".discardBtn").click(function(){
            $("#itemModal").modal('hide');
        });
    });
})(jQuery);