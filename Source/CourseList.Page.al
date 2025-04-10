page 50100 "Course List"
{
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;
    Editable = false;
    CardPageId = "Course Card";
    PromotedActionCategoriesML = ENU = 'New,Process,Report,MyCategory', ESP = 'Nuevo,Procesado,Informes,MiCategoria';

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field(Price; Rec.Price) { }
                field("Language Code"; Rec."Language Code") { }
                field("Type (Enum)"; Rec."Type (Enum)") { }
            }
        }
        area(FactBoxes)
        {
            part(Editions; "Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(CourseEditions)
            {
                CaptionML = ENU = 'Editions', ESP = 'Ediciones';
                RunObject = page "Course Editions";
                RunPageLink = "Course No." = field("No.");
                Promoted = true;
                PromotedCategory = Category4;
            }
        }
    }
}