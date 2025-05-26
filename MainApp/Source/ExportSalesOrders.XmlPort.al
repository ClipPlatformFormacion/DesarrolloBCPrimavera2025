xmlport 50100 "CLIPExport Sales Orders"
{
    Caption = 'Export Sales Orders', comment = 'ESP="Exportar Pedidos de Venta"';
    Direction = Export;
    FormatEvaluate = Xml;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                SourceTableView = where(Number = const(1));
                textelement(DocumentTypeCaption)
                {
                    Width = 20;
                    trigger OnBeforePassVariable()
                    begin
                        DocumentTypeCaption := 'Document Type';
                    end;
                }
                textelement(CustomerCaption)
                {
                    Width = 20;
                    trigger OnBeforePassVariable()
                    begin
                        CustomerCaption := 'Customer No.';
                    end;
                }
                textelement(NoCaption)
                {
                    Width = 20;
                    trigger OnBeforePassVariable()
                    begin
                        NoCaption := 'document No.';
                    end;
                }
                textelement(DateCaption)
                {

                    Width = 15;
                    trigger OnBeforePassVariable()
                    begin
                        DateCaption := 'Posting Date';
                    end;
                }
                textelement(CurrencyCaption)
                {
                    Width = 3;
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
                    Width = 20;
                    trigger OnBeforePassVariable()
                    begin
                        DocumentType := 'Order';
                    end;
                }
                fieldelement(Customer; SalesHeader."Sell-to Customer No.")
                {
                    Width = 20;
                }
                fieldelement(No; SalesHeader."No.")
                {
                    Width = 20;
                }
                fieldelement(Date; SalesHeader."Posting Date")
                {
                    Width = 15;
                }
                fieldelement(Currency; SalesHeader."Currency Code")
                {
                    Width = 3;
                }
            }
        }
    }
}