xmlport 50100 "CLIPExport Sales Orders"
{
    Caption = 'Export Sales Orders', comment = 'ESP="Exportar Pedidos de Venta"';
    Direction = Export;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
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

                tableelement(SalesLine; "Sales Line")
                {
                    LinkTable = SalesHeader;
                    LinkFields = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    SourceTableView = sorting("Document Type", "Document No.", "Line No.");

                    // fieldelement(Type; SalesLine.Type) { }
                    textelement(Type)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            case SalesLine.Type of
                                SalesLine.Type::Item:
                                    Type := 'Item';
                                SalesLine.Type::"G/L Account":
                                    Type := 'Account';
                                SalesLine.Type::"Charge (Item)":
                                    Type := 'Charge';
                                SalesLine.Type::Resource:
                                    Type := 'Resource';
                                SalesLine.Type::"Fixed Asset":
                                    Type := 'Fixed Asset';
                                else
                                    Type := '';
                            end;
                        end;
                    }
                    fieldelement(No; SalesLine."No.") { }
                    fieldelement(Quantity; SalesLine.Quantity) { }
                    fieldelement(UnitPrice; SalesLine."Unit Price") { }
                }
            }
        }
    }
}