using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using Masuit.Tools.Core.Linq;
using Masuit.Tools.DateTimeExt;
using Masuit.Tools.Logging;
using Masuit.Tools.Security;
using Masuit.Tools.Win32;
using Quick.Common;
using Quick.IService;
using Quick.Models.Dto;
using Quick.Models.Entity.Enum;
using Quick.Models.Entity.Table;
using QuickWeb.Controllers.Common;
using QuickWeb.Models.RequestModel;

namespace QuickWeb.Areas.Admin.Controllers
{
    public class SurveyController : AdminBaseController
    {
        // GET: Admin/Survey
        public ISurveyService SurveyService { get; set; }

        #region 列表
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetSurveys(SearchModel request)
        {
            Expression<Func<Survey, bool>> where = l => true;
            if (!string.IsNullOrEmpty(request.Keyword))
                where = where.And(l => l.SurveyName.Contains(request.Keyword));
            var result = SurveyService.LoadPageEntities<DateTime, SurveyDto>(request.PageIndex, request.PageSize, out request.TotalCount, where, s => s.CreateTime, true).ToList();
            return Table(result, request);
        } 

        #endregion

        #region 编辑

        [HttpPost]
        public ActionResult Edit(Survey dto)
        {
            try
            {
                if(dto.Id == 0)
                {
                    SurveyService.AddEntitySaved(dto);
                }else
                {
                    var edit = SurveyService.GetById(dto.Id);
                    edit.SurveyName = dto.SurveyName;
                    edit.CopyRight = dto.CopyRight;
                    edit.Description = dto.Description;
                    edit.CreateTime = DateTime.Now;
                    dto.SurveyStatus = SurveyStatus.Creating;
                    SurveyService.UpdateEntitySaved(edit);
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
            var dto = SurveyService.GetById(id).Mapper<SurveyDto>();
            return Ok(dto);
        } 
        #endregion

        #region 删除

        [HttpPost]
        public ActionResult Delete(long id)
        {
            try
            {
                SurveyService.DeleteByIdSaved(id);
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
                SurveyService.Delete(l => ids.Contains(l.Id));
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