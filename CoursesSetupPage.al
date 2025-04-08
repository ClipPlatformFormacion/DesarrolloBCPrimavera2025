page 50102 "Courses Setup"
{
    AccessByPermission = TableData Course = R;
    ApplicationArea = All;
    CaptionML = ENU = 'Courses Setup', ESP = 'Conf. cursos';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Courses Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                CaptionML = ENU = 'Numbering', ESP = 'Numeración';
                field("Course Nos."; Rec."Course Nos.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the number series code you can use to assign numbers to Courses.', ESP = 'Especifica el código de serie numérica que se puede utilizatr para asignar números a los cursos';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

