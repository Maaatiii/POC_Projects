using System;
using System.Threading;
using Ninject;
using Ninject.Extensions.Interception;
using Ninject.Extensions.Interception.Attributes;
using Ninject.Extensions.Interception.Request;

namespace NInjectInterceptorLab
{
    public interface ISomeService
    {
        void TestWithSleep();
    }

    public interface IAnotherService
    {
        void SomeMethod();
    }

    public class SomeService : ISomeService
    {
        [Inject]
        public IAnotherService AnotherService { get; set; }

        [LogExecutionTime]
        public virtual void TestWithSleep()
        {
            AnotherService.SomeMethod();

            //sleep
            Thread.Sleep(500);
        }
    }    

    public class AnotherService : IAnotherService
    {
        [LogExecutionTime]
        public virtual void SomeMethod()
        {            
        }
    }
}