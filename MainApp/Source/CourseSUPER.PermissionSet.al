permissionset 50100 "CLIP CourseSUPER"
{
    Caption = 'All for Courses app', Comment = 'ESP="Todos los permisos para los cursos"';
    Assignable = true;
    Permissions = tabledata "CLIP Course" = RIMD,
        tabledata "CLIP Courses Setup" = RIMD,
        tabledata "CLIP Course Edition" = RIMD,
        table "CLIP Course" = X,
        table "CLIP Course Edition" = X,
        table "CLIP Courses Setup" = X,
        page "CLIP Course Card" = X,
        page "CLIP Course Editions" = X,
        page "CLIP Course Editions Factbox" = X,
        page "CLIP Course List" = X,
        page "CLIP Courses Setup" = X,
        table "CLIP Course Ledger Entry" = X,
        tabledata "CLIP Course Ledger Entry" = RMID,
        codeunit "CLIPCourse - Sales Management" = X,
        table "CLIP Course Journal Line" = X,
        tabledata "CLIP Course Journal Line" = RMID,
        page "CLIP Course Ledger Entries" = X;
}