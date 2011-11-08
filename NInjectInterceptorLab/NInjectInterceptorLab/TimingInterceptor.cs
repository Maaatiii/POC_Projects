using System;
using System.Diagnostics;
using Ninject;
using Ninject.Extensions.Interception;
using Ninject.Extensions.Interception.Attributes;
using Ninject.Extensions.Interception.Request;
using Ninject.Extensions.Logging;

namespace NInjectInterceptorLab
{
    public class LogExecutionTimeAttribute : InterceptAttribute
    {
        public override IInterceptor CreateInterceptor(IProxyRequest request)
        {
            return request.Context.Kernel.Get<TimingInterceptor>();
        }
    }

    public class TimingInterceptor : SimpleInterceptor
    {
        [Inject]
        public ILogger Logger { get; set; }

        readonly Stopwatch _stopwatch = new Stopwatch();
        protected override void BeforeInvoke(IInvocation invocation)
        {                        
            Logger.Info("Start execute method {0}.", invocation.Request.Method.Name);

            _stopwatch.Start();
        }
        protected override void AfterInvoke(IInvocation invocation)
        {            
            _stopwatch.Stop();

            Logger.Info("End execute method {0}.", invocation.Request.Method.Name);
            Logger.Info("Execution of {0} took {1}.", invocation.Request.Method, _stopwatch.Elapsed);
            
            _stopwatch.Reset();
        }
    }
}