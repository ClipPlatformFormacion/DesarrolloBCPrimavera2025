xmlport 50101 "CLIPImport Course"
{
    Format = Xml;
    Direction = Import;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Course; "CLIP Course")
            {
                // AutoReplace = true;
                AutoUpdate = true;
                // UseTemporary = true;

                fieldelement(CourseNo; Course."No.") { }
                fieldelement(CourseName; Course."Name") { }
                fieldelement(CoursePrice; Course.Price) { }

                trigger OnBeforeInsertRecord()
                begin
                    DoExtraCalculations(Course);
                    // Course.Insert();
                end;

                trigger OnBeforeModifyRecord()
                begin
                    DoExtraCalculations(Course);
                    // Course.Modify();
                end;
            }
        }
    }

    local procedure DoExtraCalculations(var Course: Record "CLIP Course")
    begin
        Course."Duration (hours)" := Round(Course.Price / 100, 1);
    end;
}