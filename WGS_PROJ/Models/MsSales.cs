using System;
using System.Collections.Generic;

namespace WGS_PROJ.Models
{
    public partial class MsSales
    {
        public MsSales()
        {
            TrInvoice = new HashSet<TrInvoice>();
        }

        public int SalesId { get; set; }
        public string SalesName { get; set; }

        public virtual ICollection<TrInvoice> TrInvoice { get; set; }
    }
}
