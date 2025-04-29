tableextension 50101 "CLIP Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("CLIP Course")) "CLIP Course";
        }
        field(50100; "CLIP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "CLIP Course Edition".Edition where("Course No." = field("No."));
        }
    }
}