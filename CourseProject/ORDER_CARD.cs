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
    
    public partial class ORDER_CARD
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ORDER_CARD()
        {
            this.ORDER_CARD_DETAILS = new HashSet<ORDER_CARD_DETAILS>();
        }
    
        public decimal ORDER_ID { get; set; }
        public Nullable<decimal> ACCOUNT_ID { get; set; }
        public string DELIVERY_CHECKBOX { get; set; }
        public Nullable<decimal> COST { get; set; }
        public Nullable<System.DateTime> ORDER_DATE { get; set; }
        public string STATUS { get; set; }
        public string BOOK_A_RECORD { get; set; }
    
        public virtual CLIENT CLIENT { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ORDER_CARD_DETAILS> ORDER_CARD_DETAILS { get; set; }
    }
}
