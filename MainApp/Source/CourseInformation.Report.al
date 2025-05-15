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
            column(CourseNo; "No.") { }
            column(CourseName; Name) { }
            column(CourseDuration; "Duration (hours)") { }

            dataitem("CLIP Course Edition"; "CLIP Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");

                column(CourseEdition; Edition) { }
                column(CourseEditionMaxStudents; "Max. Students") { }
                column(CourseEditionSalesQty; "Sales (Qty.)") { }
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