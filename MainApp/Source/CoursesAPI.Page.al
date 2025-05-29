page 50107 CLIPCoursesAPI
{
    PageType = API;
    Caption = 'apiCourses', Locked = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'clipplatform';
    APIGroup = 'communication';
    APIVersion = 'v1.0';
    EntityName = 'course';
    EntitySetName = 'courses';
    SourceTable = "CLIP Course";
    DelayedInsert = true;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field(systemId; Rec.SystemId) { Editable = false; }
                field(courseNo; Rec."No.") { Editable = false; }
                field(courseName; Rec."Name") { NotBlank = true; }
                field(courseDuration; Rec."Duration (hours)") { NotBlank = true; }
            }
        }
    }

    [ServiceEnabled]
    procedure UnProcedimiento(var ActionContext: WebServiceActionContext)
    begin
        // El código que queremos ejecutar de Business Central

        ActionContext.SetObjectType(ObjectType::Table);
        ActionContext.SetObjectId(Database::"CLIP Course");
        ActionContext.AddEntityKey(Rec.FieldNo("No."), Rec."No.");
        ActionContext.SetResultCode(WebServiceActionResultCode::Updated);
    end;
}