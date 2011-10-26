using System.Collections.Generic;
using NHibernate.Linq;
using Enumerable = System.Linq.Enumerable;

namespace DataRepository
{
    public class DataRepository
    {
        public IList<DataRange> GetRanges()
        {


            var session = NhibernateSessionFactory.Instance.OpenSession();

            //using (var transaction = session.BeginTransaction())
            //{

            var elements = Enumerable.ToList<DataRange>(session.Query<DataRange>());
            return elements;

            //}

            //return null;
            //using(var session = NhibernateSessionFactory.Insta
        }

        public void SaveOrUpdateRanges(IList<DataRange> ranges)
        {
            var session = NhibernateSessionFactory.Instance.OpenSession(); //TODO a
            using (var transaction = session.BeginTransaction())
            {
                foreach(var r in ranges)
                {                    
                    session.SaveOrUpdate(r);        
                }

                transaction.Commit();                            
            }
        }
    }
}