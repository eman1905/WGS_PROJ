using System;
using System.Collections.Generic;

namespace WGS_PROJ.Models
{
    public partial class TrInvoiceDetail
    {
        public int InvoiceDetailId { get; set; }
        public int? InvoiceId { get; set; }
        public int? ProductId { get; set; }
        public int? Qty { get; set; }
        public decimal? TotalPrice { get; set; }
        public decimal? TotalWeight { get; set; }

        public virtual TrInvoice Invoice { get; set; }
        public virtual MsProduct Product { get; set; }
    }
}
