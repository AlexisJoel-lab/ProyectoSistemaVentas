﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="frmProveedor.aspx.vb" Inherits="SistemaWeb_Ventas.frmProveedor1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Formulario de Proveedor</h3>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Mantenimiento de Proveedor</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <%--<form class="form-horizontal form-label-left" method="post" action="#" runat="server">--%>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Rol<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" TabIndex="9">
                                        <asp:ListItem>Seleccionar Rol:</asp:ListItem>
                                        <asp:ListItem Value="E">Eventual</asp:ListItem>
                                        <asp:ListItem Value="H">Habitual</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Datos<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" TabIndex="1" required="required"></asp:TextBox>
                                </div>
                            </div>
                           <%-- <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Contraseña<span
                                        class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" TabIndex="2" required="required"></asp:TextBox>
                                </div>
                            </div>--%>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    R.U.C<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="TextNombres" runat="server" CssClass="form-control" TabIndex="3" required="required"></asp:TextBox>
                                </div>
                            </div>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Representante<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="TextApePaterno" runat="server" CssClass="form-control" TabIndex="3" required="required"></asp:TextBox>
                                </div>
                            </div>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Telefono<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="txtApeMaterno" runat="server" CssClass="form-control" TabIndex="3" required="required"></asp:TextBox>
                                </div>
                            </div>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Direccion<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" TabIndex="4" required="required"></asp:TextBox>
                                </div>
                            </div>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Email<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="TextFecNAc" runat="server" CssClass="form-control" TabIndex="4" required="required"></asp:TextBox>
                                </div>
                            </div>
                            <div class="item form-group">
                                <label class="col-form-label col-md-3 col-sm-3 label-align">
                                    Estado<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:RadioButton ID="rbtMales" runat="server" CssClass="flat" GroupName="rbtGroupGenero" required="required" Text="Masculino" />
                                    <asp:RadioButton ID="rbtFemale" runat="server" CssClass="flat" GroupName="rbtGroupGenero" required="required" Text="Femenina" />
                                </div>
                            </div>
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Email<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:TextBox ID="TextEmail" runat="server" CssClass="form-control" TabIndex="8" required="required"></asp:TextBox>
                                </div>
                            </div>                                                  
                            <div class="field item form-group">
                                <label class="col-form-label col-md-3 col-sm-3  label-align">
                                    Estado<span class="required">*</span></label>
                                <div class="col-md-6 col-sm-6">
                                    <asp:DropDownList ID="cbEstado" runat="server" CssClass="form-control" TabIndex="9">
                                        <asp:ListItem>Seleccionar estado:</asp:ListItem>
                                        <asp:ListItem Value="E">Eventual</asp:ListItem>
                                        <asp:ListItem Value="H">Habitual</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="ln_solid">
                                <div class="form-group">
                                    <div class="col-md-6 offset-md-3">
                                        <asp:Button ID="btnNuevo" runat="server" Text="Agregar" TabIndex="10" CssClass="btn btn-primary" />
                                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" TabIndex="11" CssClass="btn btn-danger" />
                                    </div>
                                </div>
                            </div>
                            <%--</form>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Listado de Proveedor</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <asp:Button ID="btnShowFormUsu" runat="server" Height="36px" Text="Nuevo Usuario" TabIndex="7" CssClass="btn btn-primary" /><br />
                            <asp:GridView ID="tblUsuarios" runat="server" CssClass="table" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" ShowHeaderWhenEmpty="True">
                                <AlternatingRowStyle BackColor="#CCCCCC" />
                                <Columns>
                                    <%--<asp:TemplateField HeaderText="ID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Text='<% # Eval("ID_CLIENTE")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Nombre de Cliente"></asp:TemplateField>
                                    <asp:TemplateField HeaderText="DNI"></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Genero"></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Teléfono"></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Dirección"></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Correo"></asp:TemplateField>--%>
                                    <asp:CommandField ButtonType="Button" HeaderText="Opciones" ShowDeleteButton="True" ShowEditButton="True" ShowHeader="True" ControlStyle-CssClass="btn-info" />
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC" />
                                <HeaderStyle BackColor="Black" CssClass="thead-dark" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#808080" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#383838" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->
</asp:Content>
