$(document).ready(function () {

    $("#txtBoxNumeroDeTelefono").focus(function () {
        $("#labelNumeroDeTelefono").css('transform', 'translateY(130px)');
    }).focusout(function () {
        var name = $.trim($(this).val()); // get the value of the input field
        if (name == "") {
            $("#labelNumeroDeTelefono").css('transform', 'translateY(150px)');
        }
    });

});

$.ajax({
    beforeSend: function () {
        // Handle the beforeSend event
    },
    complete: function () {
        // Handle the complete event
        var name = $.trim($("#txtBoxNumeroDeTelefono").val()); // get the value of the input field
        if (name != "") {
            $("#labelNumeroDeTelefono").css('transform', 'translateY(130px)');
        }
    }
});