/* ==============================================================================
* 命名空间：QuickWeb.Models.ViewModel 
* 类 名 称：NodeInfoView
* 创 建 者：Qing
* 创建时间：2019/03/19 10:08:27
* CLR 版本：4.0.30319.42000
* 保存的文件名：NodeInfoView
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

namespace QuickWeb.Models.ViewModel
{
    [Serializable]
    public class NodeInfoView
    {
        /// <summary>
        /// Desc:
        /// Default:
        /// Nullable:False
        /// </summary>           
        public long Id { get; set; }

        /// <summary>
        /// Desc:节点名称
        /// Default:
        /// Nullable:False
        /// </summary>           
        public string Name { get; set; }

        /// <summary>
        /// Desc:父级节点id
        /// Default:
        /// Nullable:False
        /// </summary>           
        public int PId { get; set; }

        /// <summary>
        /// Desc:是否拥有
        /// Default:
        /// Nullable:False
        /// </summary>           
        public byte? Checked { get; set; }
    }
}