codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    // [Test]
    // procedure Test001()
    // begin
    // end;

    // [Test]
    // procedure Test002()
    // begin
    //     Error('Un error del test');
    // end;

    [Test]
    procedure Test003()
    var
        CLIPMin: Codeunit CLIPMin;
        Value1: Decimal;
        Value2: Decimal;
        Result: Decimal;
    begin
        // [Scenario] Una función llamada GetMin devuelve el menor de 2 valores numéricos

        // [Given] 2 valores numéricos
        Value1 := 1;
        Value2 := 2;

        // [When] se realice la llamada a la función GetMin
        Result := CLIPMin.GetMin(Value1, Value2);

        // [Then] El resultado tiene que ser el más pequeño de los valores numéricos
        if Result <> Value1 then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure Test004()
    var
        CLIPMin: Codeunit CLIPMin;
        Value1: Decimal;
        Value2: Decimal;
        Result: Decimal;
    begin
        // [Scenario] Una función llamada GetMin devuelve el menor de 2 valores numéricos

        // [Given] 2 valores numéricos
        Value1 := 20;
        Value2 := 10;

        // [When] se realice la llamada a la función GetMin
        Result := CLIPMin.GetMin(Value1, Value2);

        // [Then] El resultado tiene que ser el más pequeño de los valores numéricos
        if Result <> Value2 then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure SelectingACourseOnASalesLine()
    var
        Course: Record "CLIP Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "CLIP Library - Course";
    begin
        // [Scenario] al seleccionar un curso en una línea de venta, el sistema rellena la información relacionada

        // [Given] Un curso con descripción, precio y grupos contables
        //         Un documento de venta
        Course := LibraryCourse.CreateCourse();

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Invoice, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] seleccionamos el curso en el documento de venta
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");

        // [Then] la línea de venta tiene la Descripción, Precio y Grupos contables especificados en el curso
        LibraryAssert.AreEqual(Course.Name, SalesLine.Description, 'La descripción no es correcta');
        LibraryAssert.AreEqual(Course.Price, SalesLine."Unit Price", 'El precio no es correcto');
        LibraryAssert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'El grupo registro producto no es correcto');
        LibraryAssert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'El grupo registro IVA prod. no es correcto');
    end;

    [Test]
    procedure CourseSalesPosting()
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "CLIP Library - Course";
        DocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un pedido de venta para un curso y edición, la información de la edición se guarda en los documentos registrados (albarán y factura)

        // [Given] Un curso
        //         Una edición
        //         Un pedido de venta para el curso y edición
        Course := LibraryCourse.CreateCourse();
        CourseEdition := LibraryCourse.CreateEdition(Course);
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"CLIP Course", Course."No.", 1);
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Modify(true);

        // [When] Registremos el albarán
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, false);
        // [Then] La edición es correcta en el albarán
        SalesShipmentLine.Get(DocumentNo, SalesLine."Line No.");
        LibraryAssert.AreEqual(SalesLine."CLIP Course Edition", SalesShipmentLine."CLIP Course Edition", 'La edición no es correcta en el albarán');

        // [When] Registremos la factura
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, false, true);
        // [Then] La edición es correcta en la factura
        SalesInvoiceLine.Get(DocumentNo, SalesLine."Line No.");
        LibraryAssert.AreEqual(SalesLine."CLIP Course Edition", SalesInvoiceLine."CLIP Course Edition", 'La edición no es correcta en la factura');
    end;
}