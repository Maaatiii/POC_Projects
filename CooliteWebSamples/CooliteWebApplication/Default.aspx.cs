using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace CooliteWebApplication
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Data == null)
            {
                Data = GetData();
            }


            if (!IsPostBack)
            {
                this.BindData();
            }
        }

        protected void MyData_Refresh(object sender, StoreRefreshDataEventArgs e)
        {
            this.BindData();
        }

        private void BindData()
        {
            var store = this.grid.Store.Primary;
            store.DataSource = Data;
            store.DataBind();
        }

        List<RowDefinition> Data
        {
            get { return Session["Data"] as List<RowDefinition>; }
            set { Session["Data"] = value; }
        }

        private List<RowDefinition> GetData()
        {
            var row1 = new RowDefinition() { Id = 1, From = null, To = null, Min = null, Max = null, Default = null };
            var row2 = new RowDefinition() { Id = 2, From = null, To = null, Min = null, Max = null, Default = null };
            var row3 = new RowDefinition() { Id = 3, From = null, To = null, Min = null, Max = null, Default = null };
            var row4 = new RowDefinition() { Id = 4, From = null, To = null, Min = null, Max = null, Default = null };
            var row5 = new RowDefinition() { Id = 5, From = null, To = null, Min = null, Max = null, Default = null };

            return new List<RowDefinition>(new[] { row1, row2, row3, row4 , row5});
        }

        protected void btn1_clicked(object sender, DirectEventArgs e)
        {

        }

        protected void HandleChanges(object sender, BeforeStoreChangedEventArgs e)
        {
            var data = e.DataHandler.ObjectData<RowDefinition>();
            foreach (var el in data.Updated)
            {
                Data.Remove(Data.Where(d => d.Id == el.Id).FirstOrDefault());
                Data.Add(el);                
            }
            
            BindData();

        }

        protected void ReadRecords(object sender, DirectEventArgs e)
        {
            string jsonValues = e.ExtraParams["values"];
            List<RowDefinition> records = JSON.Deserialize<List<RowDefinition>>(jsonValues);                                  
        }
    }

    public class RowDefinition
    {
        public int Id { get; set; }

        public int? From { get; set; }
        public int? To { get; set; }

        public decimal? Min { get; set; }
        public decimal? Default { get; set; }
        public decimal? Max { get; set; }

        public bool Disabled { get; set; }
    }
}