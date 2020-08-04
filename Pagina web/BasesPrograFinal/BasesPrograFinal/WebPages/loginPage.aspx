<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginPage.aspx.cs" Inherits="BasesPrograFinal.WebPages.loginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Styles/LoginPage.css" rel="stylesheet" />
    <link href="../Styles/jquery-ui.min.css" rel="stylesheet" />
    <script src="../Js/jquery-3.5.1.min.js"></script>
    <script src="../Js/jquery-ui.min.js"></script>
    <title></title>
</head>
<body>
    <div id="mainContainer">
            <form id="form1" runat="server" style="width:100%;height:100%;">
                <div id="divConsulta">
                    <span class="spanLabel">Welcome</span>

                    <asp:TextBox runat="server" id="txtBoxNumeroDeTelefono"></asp:TextBox>
                    <asp:Label runat="server" id="labelNumeroDeTelefono" Text="Digite el numero de telefono:"> </asp:Label>
                
                    <asp:Button runat="server" id="botonConsultarNumero" Text="Ver facturas"/>
                </div>
            </form>
    </div>

    <script>
        $("#txtBoxNumeroDeTelefono").focus(function () {
            $("#labelNumeroDeTelefono").css('transform', 'translateY(130px)');
        }).focusout(function () {
            var name = $.trim($(this).val()); // get the value of the input field
            if (name == "") {
                $("#labelNumeroDeTelefono").css('transform', 'translateY(150px)');
            }
        });

        $.ajax({
            beforeSend: function () {
                // Handle the beforeSend event
            },
            complete: function () {
                // Handle the complete event
                debugger;
                var name = $.trim($("#txtBoxNumeroDeTelefono").val()); // get the value of the input field
                if (name != "") {
                    $("#labelNumeroDeTelefono").css('transform', 'translateY(130px)');
                }
            }
            // ......
        });
    </script>
</body>
</html>
