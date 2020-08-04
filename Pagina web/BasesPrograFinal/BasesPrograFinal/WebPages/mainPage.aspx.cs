using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BasesPrograFinal.WebPages
{
    public partial class loginPage : System.Web.UI.Page
    {
        private string selectFacturasSpName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }

        protected void botonConsultarNumero_Click(object sender, EventArgs e)
        {
            string numeroDigitado = (txtBoxNumeroDeTelefono.Text).Trim();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connDB"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = selectFacturasSpName;

                    cmd.Parameters.Add("@inNumero", SqlDbType.VarChar).Value = numeroDigitado;
                    
                    cmd.Connection = conn;
                    conn.Open();

                    divFormContainer.Visible = false;
                    divFacturas.Visible = true;
                    botonVolverAInicio.Visible = true;

                    DataTable table = new DataTable();
                    table.Columns.Add("id");
                    table.Columns.Add("estado");
                    table.Columns.Add("fechaPago");
                    table.Columns.Add("minutosAcumulados");
                    table.Columns.Add("megasAcumulados");
                    table.Columns.Add("monto");

                    table.Rows.Add(0, 1, "1/2/4", 140, 50, 10560);

                    gridFacturas.DataSource = table;
                    gridFacturas.DataBind();
                }
            }
            catch (SqlException ex)
            {
                string alertMessage = ex.ToString();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + alertMessage + "')", true);

            }
        }

        protected void lnkBVerDetalleDeFactura_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int rowIndex = Convert.ToInt32(row.RowIndex);
            int idFactura = int.Parse((string)gridFacturas.DataKeys[rowIndex]["id"]);

            divFacturas.Visible = false;
            divDetalleFactura.Visible = true;
        }

        protected void botonVolverAInicio_Click(object sender, EventArgs e)
        {
            divFacturas.Visible = false;
            divDetalleFactura.Visible = false;
            divFormContainer.Visible = true;
            botonVolverAInicio.Visible = false;
        }
    }
}