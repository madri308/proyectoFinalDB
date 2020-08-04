<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainPage.aspx.cs" Inherits="BasesPrograFinal.WebPages.loginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Styles/mainPage.css" rel="stylesheet" />
    <script src="../Js/jquery-3.5.1.min.js"></script>
    <script src="../Js/mainPage.js"></script>
    <title></title>
</head>
<body>
    
    <form id="form1" runat="server" style="width:100%;height:100%;">
        <asp:Button runat="server" Text="Digitar otro numero" ID="botonVolverAInicio" CssClass="botonInicio" OnClick="botonVolverAInicio_Click" visible="false"/>
        
        <div runat="server" id="divFormContainer" visible="true" style="width:100%;height:100%;">
            <div id="divConsulta">
                <span class="spanLabel">Bienvenido</span>
                <asp:TextBox runat="server" id="txtBoxNumeroDeTelefono"></asp:TextBox>
                <asp:Label runat="server" id="labelNumeroDeTelefono" Text="Digite el numero de telefono:"> </asp:Label>                
                <asp:Button runat="server" id="botonConsultarNumero" Text="Ver facturas" OnClick="botonConsultarNumero_Click"/>
            </div>
        </div>

        <div runat="server" class="mainContainer" id="divFacturas" visible="false">
            <table border="1" class="tableHeader">
                    <thead>
				        <tr class="row100 head">
					        <th class="column1 factura" >Estado</th>
					        <th class="column2 factura" >Fecha Pago</th>
					        <th class="column3 factura" >Minutos acumulados</th>
                            <th class="column4 factura" >Megas acumulados</th>
                            <th class="column5 factura" >Monto</th>
                            <th class="column6 factura" ></th>
				        </tr>
			        </thead>        
                </table>
            <div class="divGridContainer">
                <asp:GridView runat="server" CssClass="grid" ID="gridFacturas" ShowHeader="false" AutoGenerateColumns="false" DataKeyNames="id">
                    <Columns>
                        <asp:BoundField DataField="estado" ReadOnly="True" ItemStyle-CssClass="column1 factura" />
                        <asp:BoundField DataField="fechaPago" ReadOnly="True" ItemStyle-CssClass="column2 factura" />
                        <asp:BoundField DataField="minutosAcumulados" ReadOnly="True" ItemStyle-CssClass="column3 factura" />
                        <asp:BoundField DataField="megasAcumulados" ReadOnly="True" ItemStyle-CssClass="column4 factura" />
                        <asp:BoundField DataField="monto" ReadOnly="True" ItemStyle-CssClass="column5 factura" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lnkBVerDetalleDeFactura" Text="Ver detalle" OnClick="lnkBVerDetalleDeFactura_Click"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle CssClass="column6 factura" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <div runat="server" class="mainContainer" id="divDetalleFactura" visible="false">
            <table border="1" class="tableHeader">
                    <thead>
				        <tr class="row100 head">
					        <th class="column1 detalle" >Estado</th>
					        <th class="column2 detalle" >Fecha Pago</th>
					        <th class="column3 detalle" >Minutos acumulados</th>
                            <th class="column4 detalle" >Megas acumulados</th>
                            <th class="column5 detalle" >Monto</th>
                            <th class="column6 detalle" ></th>
				        </tr>
			        </thead>        
                </table>
            <div class="divGridContainer">
                <asp:GridView runat="server" CssClass="grid" ID="gridDetalleDeFactura" ShowHeader="false" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="estado" ReadOnly="True" ItemStyle-CssClass="column1 detalle" />
                        <asp:BoundField DataField="fechaPago" ReadOnly="True" ItemStyle-CssClass="column2 detalle" />
                        <asp:BoundField DataField="minutosAcumulados" ReadOnly="True" ItemStyle-CssClass="column3 detalle" />
                        <asp:BoundField DataField="megasAcumulados" ReadOnly="True" ItemStyle-CssClass="column4 detalle" />
                        <asp:BoundField DataField="monto" ReadOnly="True" ItemStyle-CssClass="column5 detalle" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
    
</body>
</html>
