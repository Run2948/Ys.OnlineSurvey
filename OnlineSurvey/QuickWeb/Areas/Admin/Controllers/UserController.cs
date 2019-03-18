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
using Quick.Models.Entity.Table;
using QuickWeb.Controllers.Common;
using QuickWeb.Models.RequestModel;

namespace QuickWeb.Areas.Admin.Controllers
{
    public class UserController : AdminBaseController
    {
        public IUserInfoService UserInfoService { get; set; }

        // GET: Admin/User

        #region 列表
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetUsers(SearchModel request)
        {
            Expression<Func<UserInfo, bool>> where = l => l.IsAdmin == false;
            if (!string.IsNullOrEmpty(request.Keyword))
                where = where.And(l => l.NickName.Contains(request.Keyword));
            var result = UserInfoService.LoadPageEntities<string, UserInfoOutputDto>(request.PageIndex, request.PageSize, out request.TotalCount, where, s => s.UserName, true).ToList();
            return Table(result, request);
        } 

        public ActionResult Admin()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetAdminUsers(SearchModel request)
        {
            Expression<Func<UserInfo, bool>> where = l => l.IsAdmin;
            if (!string.IsNullOrEmpty(request.Keyword))
                where = where.And(l => l.NickName.Contains(request.Keyword));
            var result = UserInfoService.LoadPageEntities<string, UserInfoOutputDto>(request.PageIndex, request.PageSize, out request.TotalCount, where, s => s.UserName, true).ToList();
            return Table(result, request);
        } 

        #endregion

        #region 编辑

        [HttpPost]
        public ActionResult Edit(UserInfo dto)
        {
            try
            {
                if (dto.Id == 0)
                    UserInfoService.Register(dto);
                var edit = UserInfoService.GetById(dto.Id);
                edit.UserName = dto.UserName;
                edit.NickName = dto.NickName;
                edit.IsActive = dto.IsActive;
                if (edit.SaltKey.Length < 10)
                    edit.SaltKey = $"{new Random().StrictNext()}{DateTime.Now.GetTotalMilliseconds()}".MDString2(Guid.NewGuid().ToString()).AESEncrypt();
                if (!string.IsNullOrEmpty(dto.Password))
                    edit.Password = dto.Password.MDString3(edit.SaltKey);
                UserInfoService.UpdateEntitySaved(edit);
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
            var dto = UserInfoService.GetById(id).Mapper<UserInfoOutputDto>();
            return Ok(dto);
        } 
        #endregion

        #region 删除

        [HttpPost]
        public ActionResult Delete(long id)
        {
            try
            {
                UserInfoService.DeleteByIdSaved(id);
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
                UserInfoService.Delete(l => ids.Contains(l.Id));
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