public with sharing class ProductController 
{
    private ApexPages.StandardSetController standardController;

    public ProductController(ApexPages.StandardSetController standardController)
    {
        this.standardController = standardController;
    }

    public PageReference bumpProducts()
    {       
        // Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
        List<Product2> selectedCases = (List<Product2>) standardController.getSelected();
        return null;        
    }

    public PageReference updateProduct()
    {       
        // Call StandardSetController 'save' method to update (optional, you can use your own DML)
        return standardController.save();   
    }
}