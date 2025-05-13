table 50102 "CLIP Course Edition"
{
    Caption = 'Course Edition', Comment = 'ESP="Edición curso"';
    DataClassification = CustomerContent;
    LookupPageId = "CLIP Course Editions";

    fields
    {
        field(1; "Course No."; Code[20])
        {
            Caption = 'Course No.', Comment = 'ESP="Nº curso"';
            TableRelation = "CLIP Course";
        }
        field(2; Edition; Code[20])
        {
            Caption = 'Edition', Comment = 'ESP="Edición"';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date', Comment = 'ESP="Fecha inicio"';
        }
        field(4; "Max. Students"; Integer)
        {
            Caption = 'Max. Students', Comment = 'ESP="Nº máx. alumnos"';
            BlankZero = true;
        }
#pragma warning disable AA0232
        field(5; "Sales (Qty.)"; Decimal)
        {
            Caption = 'Sales (Qty.)', Comment = 'ESP="Ventas (Cdad.)"';
            FieldClass = FlowField;
            CalcFormula = sum("CLIP Course Ledger Entry".Quantity where("Course No." = field("Course No."), "Course Edition" = field(Edition), "Posting Date" = field("Date Filter")));
            Editable = false;
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
#pragma warning restore
        field(6; "Date Filter"; Date)
        {
            Caption = 'Date Filter', Comment = 'ESP="Filtro fecha"';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Course No.", Edition)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Edition, "Max. Students", "Start Date") { }
        fieldgroup(Brick; Edition, "Max. Students", "Start Date") { }
    }
}