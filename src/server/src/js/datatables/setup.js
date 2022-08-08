
(function ($) {
    $('.ItemsTable').DataTable({
            "pageLength": -1,
            pagingType: "full_numbers",
            "language": {
                "info": "PAGE _PAGE_ OF _PAGES_",
                "infoEmpty": "NO ITEMS AVAILABLE",
                "infoFiltered": "(FILTERED FROM _MAX_ TOTAL ITEMS)",
                "zeroRecords": "NOTHING FOUND",
                "sSearch": "SEARCH ",
                "sProccessing": "LOADING...",
                "oPaginate": {
                    "sFirst": "FIRST",
                    "sLast": "LAST",
                    "sNext": "▶",
                    "sPrevious": "◀",
                },
                "lengthMenu": 'SHOW  <select>'+
                '<option value="-1"></option>'+
                '<option value="5">5</option>'+
                '<option value="10">10</option>'+
                '<option value="15">15</option>'+
                '<option value="20">20</option>'+
                '<option value="25">25</option>'+
                '<option value="30">30</option>'+
                '<option value="35">35</option>'+
                '<option value="40">40</option>'+
                '<option value="45">45</option>'+
                '<option value="50">50</option>'+
                '<option value="55">55</option>'+
                '<option value="60">60</option>'+
                '<option value="65">65</option>'+
                '<option value="70">70</option>'+
                '<option value="75">75</option>'+
                '<option value="80">80</option>'+
                '<option value="85">85</option>'+
                '<option value="90">90</option>'+
                '<option value="95">95</option>'+
                '<option value="100">100</option>'+
                '</select>  ITEMS'  
            } 
        });
        $('.dataTables_filter input[type="search"]').css(
            {'width':'87%','display':'inline-block'}
            );
})(jQuery);