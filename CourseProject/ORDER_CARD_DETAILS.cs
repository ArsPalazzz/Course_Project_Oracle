//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CourseProject
{
    using System;
    using System.Collections.Generic;
    
    public partial class ORDER_CARD_DETAILS
    {
        public decimal ORDER_DETAILS_ID { get; set; }
        public Nullable<decimal> ORDER_ID { get; set; }
        public Nullable<decimal> RECORD_ID { get; set; }
        public Nullable<decimal> AMOUNT { get; set; }
    
        public virtual ORDER_CARD ORDER_CARD { get; set; }
        public virtual RECORD RECORD { get; set; }
    }
}
