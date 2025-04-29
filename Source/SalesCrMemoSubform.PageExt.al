pageextension 50101 "CLIP Sales Cr. Memo Subform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition") { ApplicationArea = All; }
        }
    }
}