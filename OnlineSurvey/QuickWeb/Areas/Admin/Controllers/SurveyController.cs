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
using QuickWeb.Models.ViewModel;

namespace QuickWeb.Areas.Admin.Controllers
{
    public class SurveyController : AdminBaseController
    {
        // GET: Admin/Survey

        public ISurveyService SurveyService { get; set; }
        public ISystemTypeService SystemTypeService { get; set; }
        public IQuestionService QuestionService { get; set; }
        public ISurveyQuestionService SurveyQuestionService { get; set; }

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
                if (dto.Id == 0)
                {
                    SurveyService.AddEntitySaved(dto);
                }
                else
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

        #region 选题
        [HttpGet]
        public ActionResult GetQuestions(long id)
        {
            if (IsIllegalId(id)) return ParamsError();
            var nodes = GetAllNodes();
            var qIds = SurveyQuestionService.LoadEntitiesNoTracking(l => l.SurveyId == id).Select(l => l.QuestionId).ToList();
            foreach (var node in nodes)
            {
                if (qIds.Contains(node.Id))
                    node.Checked = 1;
            }
            return Ok(nodes);
        }

        [HttpPost]
        public ActionResult Save(long id, List<long> topics)
        {
            if (IsIllegalId(id)) return ParamsError();
            try
            {
                if (topics == null || !topics.Any())
                {
                    SurveyQuestionService.Delete(l => l.SurveyId == id);
                    SurveyService.Update(l=>l.Id == id,o=> new Survey{ SurveyStatus = SurveyStatus.Creating });
                }
                else
                {
                    var sq = new List<SurveyQuestion>();
                    foreach (var t in topics)
                        sq.Add(new SurveyQuestion() { SurveyId = id, QuestionId = t });
                    SurveyQuestionService.AddOrUpdateSaved(s => s.SurveyId, sq.ToArray());

                    SurveyService.Update(l=>l.Id == id,o=> new Survey{ SurveyStatus = SurveyStatus.Waiting });
                }
            }
            catch (Exception e)
            {
                LogManager.Error(GetType(), e);
                return No(e.Message);
            }
            return Ok();
        }

        /// <summary>
        /// 获取所有题目组成选择树
        /// </summary>
        /// <returns></returns>
        public List<NodeInfoView> GetAllNodes()
        {
            List<NodeInfoView> nodes = new List<NodeInfoView>();
            var types = SystemTypeService.GetTypesByName(QuickKeys.TopicType).Mapper<List<NodeInfoView>>();
            nodes.AddRange(types);
            var topics = QuestionService.GetAllNoTracking<QuestionNodeDto>().ToList().Mapper<List<NodeInfoView>>();
            nodes.AddRange(topics);
            return nodes;
        }

        #endregion

        #region 状态
        [HttpPost]
        public ActionResult Status(long? id, SurveyStatus status)
        {
            if (!IsIllegalId(id)) return ParamsError();
            try
            {
                if (status == SurveyStatus.Starting)
                {
                    if (!SurveyQuestionService.Any(l => l.SurveyId == id))
                        return No("问卷为空，发布失败！");
                }
                var model = SurveyService.GetById(id);
                model.SurveyStatus = status;
                SurveyService.UpdateEntitySaved(model);
            }
            catch (Exception e)
            {
                LogManager.Error(GetType(), e);
                return No(e.Message);
            }
            return Ok();
        }

        #endregion
    }
}