using System.IO;
using System.Reflection;
using FluentNHibernate;
using FluentNHibernate.Automapping;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using FluentNHibernate.Conventions.Helpers;
using NHibernate;
using NHibernate.Cfg;
using NHibernate.Tool.hbm2ddl;

namespace DataRepository
{
    public class NhibernateSessionFactory
    {
        private NhibernateSessionFactory()
        {

        }

        private static NhibernateSessionFactory _instance = new NhibernateSessionFactory();

        public static NhibernateSessionFactory Instance
        {
            get { return _instance; }
        }

        private static ISessionFactory _sessionFactory;

        public ISession OpenSession()
        {
            if (_sessionFactory == null)
            {
                var cfg = Fluently.Configure()
                    .Database(SQLiteConfiguration.Standard.UsingFile(@"C:\Users\Mati\Documents\Visual Studio 2010\Projects\POC_Projects\CooliteWebSamples\CooliteWebApplication\App_Data\firstProject2.db"))
                    //.Database(
                    //    SQLiteConfiguration.Standard.ConnectionString(
                    //        c => c.FromConnectionStringWithKey("MyConnectionString")))
                    .Mappings(
                        x => 
                            x.AutoMappings.Add(new AutoPersistenceModel().AddMappingsFromAssembly(Assembly.GetExecutingAssembly())
                            .Conventions.Add(PrimaryKey.Name.Is(e => "Id"))));                    
                _sessionFactory = cfg.BuildSessionFactory();
                BuildSchema(cfg);
            }
            return _sessionFactory.OpenSession();
        }

        private void BuildSchema(FluentConfiguration configuration)
        {
            //var sessionSource = new SessionSource(configuration);
            //var session = sessionSource.CreateSession();
            //sessionSource.BuildSchema(session);            
            var cfg = configuration.BuildConfiguration();
            ExportSchema(cfg);
        }

        private void ExportSchema(Configuration config)
        {
            // delete the existing db on each run
            //if (File.Exists("firstProject.db"))
                //File.Delete("firstProject.db");

            // this NHibernate tool takes a configuration (with mapping info in)
            // and exports a database schema from it
            new SchemaExport(config)
              .Create(false, true);
        }


    }
}