using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuickWeb.Controllers.Common;

namespace QuickWeb.Areas.Admin.Controllers
{
    public class LoginController : BusinessController
    {
        // GET: Admin/Login
        public ActionResult Index()
        {
            return View();
        }
    }
}