using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSQLServerBD1
{
    public partial class Agregar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        protected void Button1_Click(object sender, EventArgs e)
        {
            string s =
                System.Configuration.ConfigurationManager.ConnectionStrings["CadenaConexion1"].ConnectionString;
            SqlConnection connection = new SqlConnection(s);
            connection.Open();
            SqlCommand comand = new SqlCommand("insert into Bovino(id_Bovino, Edad, idSexo, FechaSalida, FechaIngreso, FechaNacimiento, Nombre, Raza, Color, idEmpresa) values('" +
                TextBox1.Text + "', '" + this.TextBox2.Text + "', '" + TextBox3.Text + "','" +TextBox4.Text + "','" + TextBox5.Text + "','" + TextBox6.Text + "','" + TextBox7.Text + "','" + TextBox8.Text + "','" + TextBox9.Text + "','" + TextBox10.Text + "')", connection);
            comand.ExecuteNonQuery();
            Label1.Text = "Registro agregado";
            connection.Close(); 
        }

       }
}