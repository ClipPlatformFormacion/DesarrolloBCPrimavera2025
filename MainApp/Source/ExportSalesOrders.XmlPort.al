xmlport 50100 "CLIPExport Sales Orders"
{
    Caption = 'Export Sales Orders', comment = 'ESP="Exportar Pedidos de Venta"';
    Direction = Export;
    FormatEvaluate = Xml;
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = '"';

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                SourceTableView = where(Number = const(1));
                textelement(DocumentTypeCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DocumentTypeCaption := 'Document Type';
                    end;
                }
                textelement(CustomerCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerCaption := 'Customer No.';
                    end;
                }
                textelement(NoCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        NoCaption := 'document No.';
                    end;
                }
                textelement(DateCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DateCaption := 'Posting Date';
                    end;
                }
                textelement(CurrencyCaption)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CurrencyCaption := 'Currency Code';
                    end;
                }
            }
            tableelement(SalesHeader; "Sales Header")
            {
                SourceTableView = where("Document Type" = const(Order));
                textattribute(DocumentType)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DocumentType := 'Order';
                    end;
                }
                fieldelement(Customer; SalesHeader."Sell-to Customer No.") { }
                fieldelement(No; SalesHeader."No.") { }
                fieldelement(Date; SalesHeader."Posting Date") { }
                fieldelement(Currency; SalesHeader."Currency Code") { }
            }
        }
    }
}