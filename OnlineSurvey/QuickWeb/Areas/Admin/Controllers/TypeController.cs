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
using Quick.Models.Entity.Table;
using Quick.Service;
using QuickWeb.Controllers.Common;
using QuickWeb.Models.RequestModel;

namespace QuickWeb.Areas.Admin.Controllers
{
    public class TypeController : AdminBaseController
    {
        // GET: Admin/Type

        public ISystemTypeService SystemTypeService { get; set; }

        #region 列表
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetSystemTypes(SearchModel request)
        {
            Expression<Func<SystemType, bool>> where = l => true;
            if (!string.IsNullOrEmpty(request.Keyword))
                where = where.And(l => l.TypeName.Contains(request.Keyword));
            var result = SystemTypeService.LoadPageEntities(request.PageIndex, request.PageSize, out request.TotalCount, where, s => s.Name, false).ToList();
            return Table(result, request);
        }

        #endregion

        #region 编辑

        [HttpPost]
        public ActionResult Edit(SystemType dto)
        {
            try
            {
                if (dto.Id == 0)
                {
                    SystemTypeService.AddEntitySaved(dto);
                }
                else
                {
                    var edit = SystemTypeService.GetById(dto.Id);
                    edit.TypeName = dto.TypeName;
                    edit.Name = dto.Name;
                    SystemTypeService.UpdateEntitySaved(edit);
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
            var dto = SystemTypeService.GetById(id);
            return Ok(dto);
        }
        #endregion

        #region 删除

        [HttpPost]
        public ActionResult Delete(long id)
        {
            try
            {
                SystemTypeService.DeleteByIdSaved(id);
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
                SystemTypeService.Delete(l => ids.Contains(l.Id));
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