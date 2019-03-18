/* ==============================================================================
* 命名空间：QuickWeb.Models.RequestModel 
* 类 名 称：SearchModel
* 创 建 者：Qing
* 创建时间：2019/03/18 10:51:24
* CLR 版本：4.0.30319.42000
* 保存的文件名：SearchModel
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
using System.Linq;
using System.Web;

namespace QuickWeb.Models.RequestModel
{
    public class SearchModel : PageModel
    {
        public string Keyword { get; set; }

    }
}