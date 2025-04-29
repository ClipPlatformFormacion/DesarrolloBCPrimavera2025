pageextension 50105 "CLIP BlanketSalesOrderSubform" extends "Blanket Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition") { ApplicationArea = All; }
        }
    }
}