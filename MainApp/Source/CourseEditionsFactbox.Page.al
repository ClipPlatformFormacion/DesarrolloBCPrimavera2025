page 50103 "CLIP Course Editions Factbox"
{
    Caption = 'Course Editions', Comment = 'ESP="Ediciones curso"';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "CLIP Course Edition";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("Course No."; Rec."Course No.")
                {
                    Visible = false;
                }
                field(Edition; Rec.Edition) { }
                field("Start Date"; Rec."Start Date") { }
                field("Max. Students"; Rec."Max. Students") { }
            }
        }
    }
}