tableextension 50100 "CLIP Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("CLIP Course")) "CLIP Course";
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CheckCourseEditionMaxStudents();
            end;
        }
        field(50100; "CLIP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "CLIP Course Edition".Edition where("Course No." = field("No."));

            trigger OnValidate()
            begin
                CheckCourseEditionMaxStudents();
            end;
        }
    }

    local procedure CheckCourseEditionMaxStudents()
    var
        CourseEdition: Record "CLIP Course Edition";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
    begin
        if Rec.Type <> Rec.Type::"CLIP Course" then
            exit;

        if Rec."CLIP Course Edition" = '' then
            exit;

        CourseEdition.SetLoadFields("Max. Students");
        CourseEdition.Get(Rec."No.", Rec."CLIP Course Edition");

        CourseLedgerEntry.SetRange("Course No.", Rec."No.");
        CourseLedgerEntry.SetRange("Course Edition", Rec."CLIP Course Edition");
        CourseLedgerEntry.CalcSums(Quantity);

        if (CourseLedgerEntry.Quantity + Rec.Quantity) > CourseEdition."Max. Students" then
            Message('Con las ventas previas (%1) más la venta actual (%2) para el curso %3 y edición %4, se superaría el número máximo de alumnos (%5)',
                CourseLedgerEntry.Quantity, Rec.Quantity, Rec."No.", Rec."CLIP Course Edition", CourseEdition."Max. Students");
    end;
}