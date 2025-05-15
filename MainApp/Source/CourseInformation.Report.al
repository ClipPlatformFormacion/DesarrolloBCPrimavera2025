report 50101 "CLIPCourse Information"
{
    Caption = 'Course Information', comment = 'ESP="Información cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RDLC;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Duration__hours_; "Duration (hours)") { }

            dataitem("CLIP Course Edition"; "CLIP Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");

                column(Edition; Edition) { }
                column(Max__Students; "Max. Students") { }
                column(Sales__Qty__; "Sales (Qty.)") { }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }
    }

    rendering
    {
        layout(RDLC)
        {
            Type = RDLC;
            LayoutFile = 'Source/CourseInformation.rdl';
        }
    }
}