table 50102 "Course Edition"
{
    CaptionML = ENU = 'Course Edition', ESP = 'Edición curso';

    fields
    {
        field(1; "Course No."; Code[20])
        {
            CaptionML = ENU = 'Course No.', ESP = 'Nº curso';
            TableRelation = Course;
        }
        field(2; Edition; Code[20])
        {
            CaptionML = ENU = 'Edition', ESP = 'Edición';
        }
        field(3; "Start Date"; Date)
        {
            CaptionML = ENU = 'Start Date', ESP = 'Fecha inicio';
        }
        field(4; "Max. Students"; Integer)
        {
            CaptionML = ENU = 'Max. Students', ESP = 'Nº máx. alumnos';
        }
    }

    keys
    {
        key(PK; "Course No.", Edition)
        {
            Clustered = true;
        }
    }
}