using QuickWeb.Models.RequestModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuickWeb.Controllers.Common
{
    /// <summary>
    /// 业务控制器
    /// </summary>
    public class BusinessController : BaseController
    {
        #region 通用用户验证码校验方法
        protected bool IsValidateCode(string code)
        {
            var vCode = TempData["valid_code"]?.ToString();
            if (vCode == null)
                return false;
            return code.ToLower().Equals(vCode.ToLower());
        }
        #endregion

        #region 分页计算总页数
        protected decimal GetPage(PageModel page)
        {
            return Math.Ceiling(Convert.ToDecimal(page.TotalCount) / page.PageSize);;
        }
        #endregion

        #region 只返回Table数据信息
        /// <summary>
        /// 只返回Table数据信息
        /// </summary>
        /// <returns></returns>
        protected JsonResult Table(object result, PageModel page)
        {
            return new JsonResult
            {
                Data = new
                {
                    rowCount = page.PageSize,
                    pageCount = GetPage(page),
                    rows = result
                },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        /// <summary>
        /// 只返回Table数据信息
        /// </summary>
        /// <returns></returns>
        protected JsonResult Table(PageModel page, params object[] result)
        {
            return new JsonResult
            {
                Data = new
                {
                    rowCount = page.PageSize,
                    pageCount = GetPage(page),
                    rows = result
                },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        #endregion

        #region 跳转自定义错误页面
        protected ActionResult Error() => RedirectToAction("Index", "Error");
        protected ActionResult ParamsError() => RedirectToAction("ParamsError", "Error");
        protected ActionResult NoOrDeleted() => RedirectToAction("NoOrDeleted", "Error");
        #endregion
    }
}