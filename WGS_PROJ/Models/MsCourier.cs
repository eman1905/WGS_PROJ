using System;
using System.Collections.Generic;

namespace WGS_PROJ.Models
{
    public partial class MsCourier
    {
        public MsCourier()
        {
            TrInvoice = new HashSet<TrInvoice>();
        }

        public int CourierId { get; set; }
        public string CourierName { get; set; }
        public decimal? CourierFee { get; set; }

        public virtual ICollection<TrInvoice> TrInvoice { get; set; }
    }
}
