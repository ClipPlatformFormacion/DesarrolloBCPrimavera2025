pageextension 50100 "CLIP Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition") { ApplicationArea = All; }
        }
    }
}