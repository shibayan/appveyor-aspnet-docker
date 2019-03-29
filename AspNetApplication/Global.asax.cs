using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

[assembly: PreApplicationStartMethod(typeof(AspNetApplication.CounterInjector), "Start")]

namespace AspNetApplication
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }

    public static class CounterInjector
    {
        public static void Start()
        {
            Environment.SetEnvironmentVariable("WEBSITE_SITE_NAME", "");
        }
    }
}
