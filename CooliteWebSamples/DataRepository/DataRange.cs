using System;
using System.Text;
using FluentNHibernate.Mapping;

namespace DataRepository
{

    public class DataRange
    {
        public virtual int Id { get; protected set; }

        public virtual int? OrderNumber { get; set; }

        public virtual int? From { get; set; }
        public virtual int? To { get; set; }

        public virtual decimal? Min { get; set; }
        public virtual decimal? Max { get; set; }
        public virtual decimal? Default { get; set; }

        public virtual bool Disabled { get; set; }
    }

    public class DataRangeMap : ClassMap<DataRange>
    {
        public DataRangeMap()
        {
            Id(x => x.Id);
        }       
    }
}
