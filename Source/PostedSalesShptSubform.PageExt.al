pageextension 50106 "CLIP PostedSalesShptSubform" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition") { ApplicationArea = All; }
        }
    }
}