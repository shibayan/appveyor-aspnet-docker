using System.Web.Mvc;

namespace AspNetApplication.Controllers
{
    public class ProbController : Controller
    {
        // GET: Prob
        public ActionResult Index()
        {
            return Content("OK");
        }
    }
}