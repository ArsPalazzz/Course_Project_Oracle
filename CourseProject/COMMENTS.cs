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
    
    public partial class COMMENTS
    {
        public decimal COMMENT_ID { get; set; }
        public Nullable<System.DateTime> COMMENT_DATE { get; set; }
        public Nullable<decimal> USER_ID { get; set; }
        public Nullable<decimal> RECORD_ID { get; set; }
        public string CONTENT { get; set; }
    
        public virtual CLIENT CLIENT { get; set; }
        public virtual RECORD RECORD { get; set; }
    }
}
