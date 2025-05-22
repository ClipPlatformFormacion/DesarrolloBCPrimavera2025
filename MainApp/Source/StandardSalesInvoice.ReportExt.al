reportextension 50100 "CLIP Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(CLIP_Course_Edition; "CLIP Course Edition")
            {
                IncludeCaption = true;
            }
        }
    }

    requestpage
    {
        layout
        {
            modify(DisplayShipmentInformation)
            {
                Visible = false;
            }
        }
    }

    rendering
    {
        layout(CLIPNuevoRDLCConEdiciones)
        {
            Type = RDLC;
            LayoutFile = './source/StandardSalesInvoice.rdl';
        }
    }
}