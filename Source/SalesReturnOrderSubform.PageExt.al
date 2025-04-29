pageextension 50104 "CLIP SalesReturnOrderSubform" extends "Sales Return Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition") { ApplicationArea = All; }
        }
    }
}