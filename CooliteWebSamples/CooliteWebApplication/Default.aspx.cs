using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataRepository;
using Ext.Net;

namespace CooliteWebApplication
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
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
            var repo = new DataRepository.DataRepository();
            var ranges = repo.GetRanges();

            if (ranges.Count == 0)
            {
                for (int i = 0; i < 5; i++)
                {
                    ranges.Add(new DataRange(){OrderNumber = i});
                }
            }

            var store = this.grid.Store.Primary;
            store.DataSource = ranges;
            store.DataBind();
        }        

        protected void btn1_clicked(object sender, DirectEventArgs e)
        {

        }

        //protected void HandleChanges(object sender, BeforeStoreChangedEventArgs e)
        //{
        //    var data = e.DataHandler.ObjectData<RowDefinition>();
        //    foreach (var el in data.Updated)
        //    {
        //        Data.Remove(Data.Where(d => d.Id == el.Id).FirstOrDefault());
        //        Data.Add(el);                
        //    }            
        //    BindData();
        //}

        protected void ReadRecords(object sender, DirectEventArgs e)
        {
            string jsonValues = e.ExtraParams["values"];
            List<DataRange> records = JSON.Deserialize<List<DataRange>>(jsonValues);

            var repo =new DataRepository.DataRepository();
            repo.SaveOrUpdateRanges(records);

            DataBind();
        }

        protected void HandleChanges(object sender, BeforeStoreChangedEventArgs e)
        {
        }
    }

    //public class RowDefinition
    //{
    //    public int Id { get; set; }

    //    public int? From { get; set; }
    //    public int? To { get; set; }

    //    public decimal? Min { get; set; }
    //    public decimal? Default { get; set; }
    //    public decimal? Max { get; set; }

    //    public bool Disabled { get; set; }
    //}
}