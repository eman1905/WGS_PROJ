using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WGS_PROJ.Models
{
  public partial class TrInvoice
  {
    public TrInvoice()
    {
      TrInvoiceDetail = new HashSet<TrInvoiceDetail>();
    }

    public int InvoiceId { get; set; }
    public int? SalesId { get; set; }
    public int? CourierId { get; set; }
    [DataType(DataType.Date)]
    [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/dd/yyyy}")]
    public DateTime? InvoiceDate { get; set; }
    public string InvoiceTo { get; set; }
    public string InvoiceShipTo { get; set; }
    public string PaymentType { get; set; }

    public virtual MsCourier Courier { get; set; }
    public virtual MsSales Sales { get; set; }
    public virtual ICollection<TrInvoiceDetail> TrInvoiceDetail { get; set; }
  }
}
