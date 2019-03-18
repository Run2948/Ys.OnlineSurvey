using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using Masuit.Tools.Core.Linq;
using Masuit.Tools.Logging;
using Quick.Common;
using Quick.IService;
using Quick.Models.Dto;
using Quick.Models.Entity.Enum;
using Quick.Models.Entity.Table;
using QuickWeb.Controllers.Common;
using QuickWeb.Models.RequestModel;

namespace QuickWeb.Areas.Admin.Controllers
{
    public class QuestionController : AdminBaseController
    {
        // GET: Admin/Question
        public IQuestionService QuestionService { get; set; }
        public ISystemTypeService SystemTypeService { get; set; }

        #region 列表
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetQuestions(SearchModel request)
        {
            Expression<Func<Question, bool>> where = l => true;
            if (!string.IsNullOrEmpty(request.Keyword))
                where = where.And(l => l.Topic.Contains(request.Keyword));
            var result = QuestionService.LoadPageEntities(request.PageIndex, request.PageSize, out request.TotalCount, where, s => s.Id, false).ToList();
            var types = SystemTypeService.GetTypesByName(QuickKeys.TopicType);
            return Table(request, result, types);
        }
        #endregion

        #region 编辑

        [HttpPost]
        public ActionResult Edit(Question dto)
        {
            try
            {
                if (dto.Id == 0)
                {
                    QuestionService.AddEntitySaved(dto);
                }
                else
                {
                    var edit = QuestionService.GetById(dto.Id);


                    QuestionService.UpdateEntitySaved(edit);
                }
            }
            catch (Exception ex)
            {
                LogManager.Error(GetType(), ex);
                return No(ex.Message);
            }
            return Ok();
        }

        [HttpGet]
        public ActionResult Get(long id)
        {
            var dto = QuestionService.GetById(id);
            return Ok(dto);
        }
        #endregion

        #region 删除

        [HttpPost]
        public ActionResult Delete(long id)
        {
            try
            {
                QuestionService.DeleteByIdSaved(id);
            }
            catch (Exception ex)
            {
                LogManager.Error(GetType(), ex);
                return No(ex.Message);
            }
            return Ok();
        }

        [HttpPost]
        public ActionResult MultiDelete(List<long> ids)
        {
            try
            {
                QuestionService.Delete(l => ids.Contains(l.Id));
            }
            catch (Exception ex)
            {
                LogManager.Error(GetType(), ex);
                return No(ex.Message);
            }
            return Ok();
        }
        #endregion
    }
}