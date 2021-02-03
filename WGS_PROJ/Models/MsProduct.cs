using System;
using System.Collections.Generic;

namespace WGS_PROJ.Models
{
    public partial class MsProduct
    {
        public MsProduct()
        {
            TrInvoiceDetail = new HashSet<TrInvoiceDetail>();
        }

        public int ProductId { get; set; }
        public string ProductDesc { get; set; }
        public decimal? ProductPrice { get; set; }
        public decimal? ProductWeight { get; set; }

        public virtual ICollection<TrInvoiceDetail> TrInvoiceDetail { get; set; }
    }
}
