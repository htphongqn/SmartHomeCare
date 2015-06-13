<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Label ID="lbEmpty" runat="server"></asp:Label>
    <div>
        
        <div style="float:left; height: 232px; margin-right:5px">
             
                       <asp:GridView ID="grvBody" runat="server" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("IndexStr") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Value" DataField="Value">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Diagnose" DataField="Diagnose">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
             
        </div><!-- Data -->
        <div style="float:left; height: 232px;">
             
                       <asp:GridView ID="grvBody2" runat="server" AutoGenerateColumns="False">
                                <Columns>
                                    
                                    <asp:BoundField HeaderText="Value" DataField="Value">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Diagnose" DataField="Diagnose">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
             
        </div><!-- Data -->
        <div style="clear:both">
            <asp:Button ID="btn_back" runat="server" Text="Back" onclick="btn_back_Click" />
            <asp:Button ID="btnNext" runat="server" Text="Next" onclick="btnNext_Click" />
        </div>
    </div>
    </form>
</body>
</html>
