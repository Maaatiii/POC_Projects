<%@ Page Language="C#" %>
 
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new List<object>
             {
                 new {Company = "3m Co"},
                 new {Company = "Alcoa Inc"},
                 new {Company = "Altria Group Inc"},
                 new {Company = "American Express Company"},
                 new {Company = "American International Group, Inc."},
                 new {Company = "AT&amp;T Inc."},
                 new {Company = "Boeing Co."},
                 new {Company = "Caterpillar Inc."},
                 new {Company = "Citigroup, Inc."},
                 new {Company = "E.I. du Pont de Nemours and Company"},
                 new {Company = "Exxon Mobil Corp"},
                 new {Company = "General Electric Company"},
                 new {Company = "General Motors Corporation"},
                 new {Company = "Hewlett-Packard Co."},
                 new {Company = "Honeywell Intl Inc"},
                 new {Company = "Intel Corporation"},
                 new {Company = "International Business Machines"},
                 new {Company = "Johnson &amp; Johnson"},
                 new {Company = "JP Morgan &amp; Chase &amp; Co"},
                 new {Company = "McDonald\"s Corporation"},
                 new {Company = "Merck &amp; Co., Inc."},
                 new {Company = "Microsoft Corporation"},
                 new {Company = "Pfizer Inc"},
                 new {Company = "The Coca-Cola Company"},
                 new {Company = "The Home Depot, Inc."},
                 new {Company = "The Procter &amp; Gamble Company"},
                 new {Company = "United Technologies Corporation"},
                 new {Company = "Verizon Communications"},
                 new {Company = "Wal-Mart Stores, Inc."}
             };
 
            this.Store1.DataBind();
        }
    }
</script>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Row Selection Model</title>
     
    <style type="text/css">
        .marked-row {
            background: #FFFDD8;
        }
         
        .green-text{
            color: Green;
        }
    </style>
     
    <script type="text/javascript">
        function toggleMarker(grid) {
            var record = grid.getSelectionModel().getSelected();
            if (record) {
                record.set('Marker', !record.get('Marker'));
            }
        }

        function showMarked(grid) {
            var message = [];
            grid.store.query('Marker', true).each(function (record) {
                message.push(record.data.Company + '<br/>');
            });

            Ext.Msg.alert('Marked companies', message.join(''));
        }
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
         
        <ext:Store ID="Store1" runat="server">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="Company" />
                        <ext:RecordField Name="Marker" Type="Boolean" DefaultValue="false" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
         
        <ext:GridPanel ID="GridPanel1" runat="server" StoreID="Store1" StripeRows="true"
            Title="Company List" AutoExpandColumn="Company" Collapsible="true" Width="600"
            Height="350">
            <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:Column ColumnID="Company" Header="Company" Width="160" DataIndex="Company" />
                    <ext:Column DataIndex="Marker">
                        <Renderer Handler="metadata.css = 'green-text'; return value ? 'Marked' : '';" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" />
            </SelectionModel>
            <View>
                <ext:GridView ID="GridView1" runat="server" MarkDirty="false">
                    <GetRowClass Handler="if(record.data.Marker){return 'marked-row';}" />                      
                </ext:GridView>
            </View>
 
            <KeyMap>
                <ext:KeyBinding Ctrl="true" StopEvent="true">
                    <Keys>
                        <ext:Key Code="SPACE" />
                    </Keys>
                     
                    <Listeners>
                        <Event Handler="toggleMarker(#{GridPanel1});" />
                    </Listeners>
                </ext:KeyBinding>
            </KeyMap>
        </ext:GridPanel>
         
        <ext:Button ID="Button1" runat="server" Text="Show selected records">
            <Listeners>
                <Click Handler="showMarked(#{GridPanel1});" />
            </Listeners>
        </ext:Button>
    </form>
</body>
</html>