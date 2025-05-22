xmlport 50100 "CLIPExport Sales Orders"
{
    Caption = 'Export Sales Orders', comment = 'ESP="Exportar Pedidos de Venta"';
    Direction = Export;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                fieldattribute(DocumentType; SalesHeader."Document Type") { }
                fieldelement(Customer; SalesHeader."Sell-to Customer No.") { }
                fieldelement(No; SalesHeader."No.") { }
                fieldelement(Date; SalesHeader."Posting Date") { }
                fieldelement(Currency; SalesHeader."Currency Code") { }

            }
        }
    }
}