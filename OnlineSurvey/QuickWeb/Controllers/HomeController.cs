using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quick.IService;
using Quick.Models.Dto;
using QuickWeb.Controllers.Common;

namespace QuickWeb.Controllers
{
    public class HomeController : UserBaseController
    {
        public ISurveyService SurveyService { get;set; }	

        // GET: Home
        public ActionResult Index(Guid? id)
        {
            id = new Guid("E2206020-7798-4783-9A8B-3BD83EA36DD8");
            var dto = SurveyService.GetWholeSurvey(id);
            return View(dto??new SurveyQuestionDto());
        }
    }
}