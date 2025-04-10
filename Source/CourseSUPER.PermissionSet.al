permissionset 50100 "CourseSUPER"
{
    CaptionML = ENU = 'All for Courses app', ESP = 'Todos los permisos para los cursos';
    Assignable = true;
    Permissions = tabledata Course = RIMD,
        tabledata "Courses Setup" = RIMD,
        tabledata "Course Edition" = RIMD,
        table Course = X,
        table "Course Edition" = X,
        table "Courses Setup" = X,
        page "Course Card" = X,
        page "Course Editions" = X,
        page "Course Editions Factbox" = X,
        page "Course List" = X,
        page "Courses Setup" = X;
}