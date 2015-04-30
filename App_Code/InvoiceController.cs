using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// This file creates a random invoice number
///  
/// </summary>
public class InvoiceController
{
	public InvoiceController()
	{

	}

    // get the next random invoice number
    public String getInvoiceNumber()
    {
        Random random = new Random((int)DateTime.Now.Ticks);
        return "INV-" + random.Next().ToString().ToUpper().PadLeft(10, '0');
    }
}