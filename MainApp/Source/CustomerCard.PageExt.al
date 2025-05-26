pageextension 50107 "CLIP Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("CLIP Customer Level"; Rec."CLIP Customer Level")
            {
                ApplicationArea = All;
            }
            field("CLIP Discount"; Rec."CLIP Discount")
            {
                ApplicationArea = All;
            }
        }
    }
}