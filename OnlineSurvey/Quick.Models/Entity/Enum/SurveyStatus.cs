/* ==============================================================================
* 命名空间：Quick.Models.Entity.Enum 
* 类 名 称：SurveyStatus
* 创 建 者：Qing
* 创建时间：2019/03/17 17:44:18
* CLR 版本：4.0.30319.42000
* 保存的文件名：SurveyStatus
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
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quick.Models.Entity.Enum
{
    public enum SurveyStatus
    {
        /// <summary>
        /// 创建中
        /// </summary>
        [Description("创建中")]
        Creating,
        /// <summary>
        /// 待发布
        /// </summary>
        [Description("待发布")]
        Waiting,
        /// <summary>
        /// 开启中
        /// </summary>
        [Description("发布中")]
        Starting,
        /// <summary>
        /// 已暂停
        /// </summary>
        [Description("已暂停")]
        Paused,
        /// <summary>
        /// 已结束
        /// </summary>
        [Description("已结束")]
        Finished,
        /// <summary>
        /// 已关闭
        /// </summary>
        [Description("已关闭")]
        Closed
    }
}
