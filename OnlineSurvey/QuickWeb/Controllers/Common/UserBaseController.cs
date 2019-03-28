using Quick.Common;
using Quick.Common.Net;
using Quick.Models.Dto;
using Quick.Models.Entity.Table;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuickWeb.Filters;
using QuickWeb.Models.RequestModel;

namespace QuickWeb.Controllers.Common
{
    [QuickUserPermission]
    public class UserBaseController : BusinessController
    {
        #region 用户Session相关操作

        protected bool IsUserLogin()
        {
            return GetUserSession() != null;
        }

        protected UserInfoOutputDto GetUserSession()
        {
            if (IsDebug)
            {
                UserInfoOutputDto dto = new UserInfoOutputDto() { Id = 2 };
                System.Web.HttpContext.Current.Session.Set(QuickKeys.USER_SESSION, dto, 60 * 12);
                return dto;
            }
            else
                return System.Web.HttpContext.Current.Session.Get<UserInfoOutputDto>(QuickKeys.USER_SESSION);
        }

        protected void SetUserSession(UserInfo user, int timeout = 20)
        {
            UserInfoOutputDto dto = user.Mapper<UserInfoOutputDto>();
            System.Web.HttpContext.Current.Session.Set(QuickKeys.USER_SESSION, dto, timeout);
        }

        protected void SetUserLogOut()
        {
            System.Web.HttpContext.Current.Session.Remove(QuickKeys.USER_SESSION);
            System.Web.HttpContext.Current.Session.Abandon();
        }

        #endregion
    }

    [QuickAdminPermission]
    public class AdminBaseController : BusinessController
    {
        #region 用户Session相关操作

        protected bool IsAdminLogin()
        {
            return GetAdminSession() != null;
        }

        protected UserInfoOutputDto GetAdminSession()
        {
            if (IsDebug)
            {
                UserInfoOutputDto dto = new UserInfoOutputDto() { Id = 2 };
                System.Web.HttpContext.Current.Session.Set(QuickKeys.ADMIN_SESSION, dto, 60 * 12);
                return dto;
            }
            else
                return System.Web.HttpContext.Current.Session.Get<UserInfoOutputDto>(QuickKeys.ADMIN_SESSION);
        }

        protected void SetAdminSession(UserInfo user, int timeout = 20)
        {
            UserInfoOutputDto dto = user.Mapper<UserInfoOutputDto>();
            System.Web.HttpContext.Current.Session.Set(QuickKeys.ADMIN_SESSION, dto, timeout);
        }

        protected void SetAdminLogOut()
        {
            System.Web.HttpContext.Current.Session.Remove(QuickKeys.ADMIN_SESSION);
            System.Web.HttpContext.Current.Session.Abandon();
        }

        #endregion
    }
}