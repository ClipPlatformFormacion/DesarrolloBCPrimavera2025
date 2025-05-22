page 50106 "CLIPRun Objects"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;

    actions
    {
        area(Processing)
        {
            action(ExportSalesOrders)
            {
                image = Export;
                RunObject = xmlport "CLIPExport Sales Orders";
            }
        }
    }
}