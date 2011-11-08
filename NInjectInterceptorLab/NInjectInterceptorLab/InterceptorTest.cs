using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Ninject;
using Ninject.Extensions.Conventions;
using Ninject.Extensions.Interception.Infrastructure.Language;
using Ninject.Extensions.Logging.Log4net;
using Ninject.Modules;
using NUnit.Framework;

namespace NInjectInterceptorLab
{
    public class InterceptorTestModule : NinjectModule
    {
        public override void Load()
        {
            log4net.Config.XmlConfigurator.Configure();
            //Bind<SomeService>().ToSelf().Intercept().With<TimingInterceptor>();
            //Bind<IAnotherService>().To<AnotherService>().Intercept().With<TimingInterceptor>();

            Kernel.Scan(x =>
                {
                    x.FromCallingAssembly();
                    x.BindWithDefaultConventions();                    
                }
            );
        }
    }

    [TestFixture]
    public class InterceptorTest
    {
        private StandardKernel kernel;

        [SetUp]
        public void TestSetup()
        {
            kernel = new StandardKernel(new InterceptorTestModule());
        }

        [Test]
        public void ExecuteTimingTest()
        {
            var foo = kernel.Get<SomeService>();
            foo.TestWithSleep();            
        }
    }
}
