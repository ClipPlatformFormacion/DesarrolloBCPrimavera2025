page 50100 "CLIP Course List"
{
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    Editable = false;
    CardPageId = "CLIP Course Card";

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
                field(Updated; Rec.Updated) { }
                field(errorMessage; Rec."Error Message") { }
            }
        }
        area(FactBoxes)
        {
            part(Editions; "CLIP Course Editions Factbox")
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
                Caption = 'Editions', Comment = 'ESP="Ediciones"';
                Image = List;
                RunObject = page "CLIP Course Editions";
                RunPageLink = "Course No." = field("No.");
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Ledger E&ntries';
                    Image = ResourceLedger;
                    RunObject = Page "CLIP Course Ledger Entries";
                    RunPageLink = "Course No." = field("No.");
#pragma Warning Disable AL0254
                    RunPageView = sorting("Course No.")
                                  order(descending);
#pragma Warning Restore
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
            action(ImportCourses)
            {
                RunObject = xmlport "CLIPImport Course";
                Image = Import;
            }
        }
        area(Promoted)
        {
            group(Category_Category4)
            {
                Caption = 'MyCategory', Comment = 'ESP="MiCategoria"';
                ShowAs = SplitButton;

                actionref(CourseEditions_Promoted; CourseEditions)
                {
                }
                actionref(LedgerEntries_Promoted; "Ledger E&ntries")
                { }
                actionref(ImportCourses_Promoted; ImportCourses)
                {
                }
            }
        }
    }
}