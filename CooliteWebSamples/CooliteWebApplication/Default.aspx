<%@ Page Title="" Language="C#" MasterPageFile="~/Ext.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="CooliteWebApplication.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .x-grid3-header .x-grid3-cell-inner, .x-grid3-header .x-grid3-hd-inner
        {
            border: 0px solid;
            padding: 4px;
        }
        
        .x-grid3-hd-row td
        {
            padding: 1px;
        }
        
        .x-grid3-cell-inner, .x-grid3-hd-inner
        {
            border: 1px solid;
            padding: 4px;
        }
        
        
        .x-grid3-row td, .x-grid3-summary-row td
        {
            padding: 2px;
        }
    </style>
    <script type="text/javascript">
        var getRowClass = function (record, index) {
            if (record.data.Disabled) {
                return "x-item-disabled";
            }
        };

        function updateGridDataAfterEdit(e) {
            var from = e.record.data.From;
            var to = e.record.data.To;
            var store = e.grid.getStore();

            if (e.field == 'From') {
                var newValueFrom = parseInt(e.value);

                if (to != '' && to < newValueFrom)
                    return false;

                var previousElement = store.getAt(e.row - 1);

                if (previousElement != null) {
                    previousElement.set('To', newValueFrom - 1);
                }
            }

            if (e.field == 'To') {                
                var newValueTo = parseInt(e.value);

                if (from != '' && from > newValueTo)
                    return false;

                //max value
                if (newValueTo >= 84) {
                    e.value = 84;
                    setAvailabilityOfRecordSet(e.row, store, true);
                }                
                else if (to == 84 && newValueTo < 84) {
                    setAvailabilityOfRecordSet(e.row, store, false);

                    var nextElement = store.getAt(e.row + 1);

                    if (nextElement != null) {
                        nextElement.set('From', newValueTo + 1);
                    }
                }
                else {
                    var nextElement = store.getAt(e.row + 1);

                    if (nextElement != null) {
                        nextElement.set('From', newValueTo + 1);
                    }
                }
            }

            return true;
        }

        function setAvailabilityOfRecordSet(indexOfRow, store, disabled) {
            for (var i = indexOfRow + 1; i <= store.data.items.length - 1; i++) {
                store.data.items[i].set('Disabled', disabled);
            }
        }

        var formatValue = function (value, metadata, record, rowIndex, colIndex, store) {            
            if (value == null) { return ' '; }
            else return value;
        };
    </script>
    <ext:Panel ID="panMain" runat="server" Width="500" Height="600" Padding="30" Title="Tabela">
        <Items>
            <ext:GridPanel ID="grid" runat="server" Width="400" Height="290" AutoDataBind="true"
                ClicksToEdit="1" EnableHdMenu="false" EnableDragDrop="false">
                <Store>
                    <ext:Store runat="server" OnRefreshData="MyData_Refresh" OnBeforeStoreChanged="HandleChanges">
                        <Reader>
                            <ext:JsonReader IDProperty="Id">
                                <Fields>
                                    <ext:RecordField Name="Id" Type="Int"/>
                                    <ext:RecordField Name="From" Type="String" AllowBlank="true" />
                                    <ext:RecordField Name="To" Type="String"  AllowBlank="true"/>
                                    <ext:RecordField Name="Min" Type="String" AllowBlank="true"  />
                                    <ext:RecordField Name="Default" Type="String" AllowBlank="true"  />
                                    <ext:RecordField Name="Max" Type="String" AllowBlank="true"  />
                                    <ext:RecordField Name="Disabled" Type="Boolean" />
                                </Fields>
                            </ext:JsonReader>
                        </Reader>
                        <SortInfo Field="Id" Direction="ASC" />
                    </ext:Store>
                </Store>
                <SelectionModel>
                    <ext:RowSelectionModel ID="selectionModel" runat="server" SingleSelect="true">
                    </ext:RowSelectionModel>
                </SelectionModel>
                <ColumnModel ID="ColumnModel1" runat="server">
                    <Columns>
                        <ext:Column ColumnID="Id" Header="Id" Width="30" DataIndex="Id" Sortable="false"  Resizable="false" Hidden="true"/>
                        <ext:Column ColumnID="From" Header="From" Width="50" DataIndex="From" Sortable="false" Resizable="false">
                            <Editor>
                                <ext:NumberField runat="server" AllowBlank="false" SelectOnFocus="true">  
                                </ext:NumberField>
                            </Editor>
                            <Renderer Fn="formatValue" />
                        </ext:Column>
                        <ext:Column ColumnID="To" Header="To" Width="50" DataIndex="To" Sortable="false" Resizable="false">
                            <Editor>
                                <ext:NumberField ID="NumberField1" runat="server" AllowBlank="false"  SelectOnFocus="true">                                    
                                </ext:NumberField>
                            </Editor>
                        </ext:Column>
                        <ext:Column ColumnID="Min" Header="Min" Width="80" DataIndex="Min" Sortable="false" Resizable="false">
                            <Editor>
                                <ext:NumberField ID="NumberField2" runat="server" AllowBlank="false"  SelectOnFocus="true">                                    
                                </ext:NumberField>
                            </Editor>
                        </ext:Column>
                        <ext:Column ColumnID="Default" Header="Default" Width="80" DataIndex="Default" Sortable="false" Resizable="false" >
                            <Editor>
                                <ext:NumberField ID="NumberField3" runat="server" AllowBlank="false"  SelectOnFocus="true">                                    
                                </ext:NumberField>
                            </Editor>
                        </ext:Column>
                        <ext:Column ColumnID="Max" Header="Max" Width="80" DataIndex="Max" Sortable="false" Resizable="false">
                            <Editor>
                                <ext:NumberField ID="NumberField4" runat="server" AllowBlank="false"  SelectOnFocus="true">
                                </ext:NumberField>
                            </Editor>
                        </ext:Column>
                    </Columns>
                </ColumnModel>
                <Listeners>
                    <BeforeEdit Handler="if(e.record.data.Disabled) return false;" />
                    <ValidateEdit Handler="return updateGridDataAfterEdit(e);" />
                </Listeners>
                <View>
                    <ext:GridView ForceFit="true">
                        <getrowclass fn="getRowClass" />
                    </ext:GridView>
                </View>
            </ext:GridPanel>
            <ext:Button ID="btn1" runat="server" Text="Save">
                <Listeners>
                    <Click Handler="#{grid}.save();" />
                </Listeners>
            </ext:Button>
        </Items>
    </ext:Panel>
</asp:Content>
