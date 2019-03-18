/* ==============================================================================
* 命名空间：QuickWeb.Models.RequestModel 
* 类 名 称：LoginModel
* 创 建 者：Qing
* 创建时间：2019/03/18 7:59:55
* CLR 版本：4.0.30319.42000
* 保存的文件名：LoginModel
* 文件版本：V1.0.0.0
*
* 功能描述：N/A 
*
* 修改历史：
*
*
* ==============================================================================
*         CopyRight @ 班纳工作室 2019. All rights reserved
* ==============================================================================*/

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace QuickWeb.Models.RequestModel
{
    public class LoginModel
    {
        [Required(ErrorMessage = "用户名不能为空。")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "密码不能为空。")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        public bool RememberMe { get; set; }
    }
}