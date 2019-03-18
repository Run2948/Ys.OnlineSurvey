/* ==============================================================================
* 命名空间：Quick.Models.Dto 
* 类 名 称：SurveyDto
* 创 建 者：Qing
* 创建时间：2019/03/18 8:34:08
* CLR 版本：4.0.30319.42000
* 保存的文件名：SurveyDto
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
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quick.Models.Entity.Enum;

namespace Quick.Models.Dto
{
    public class SurveyDto : BaseDto
    {
        /// <summary>
        /// 问卷名称
        /// </summary>
        public string SurveyName { get; set; }

        /// <summary>
        /// 问卷描述信息
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// 问卷底部(版权)信息
        /// </summary>
        public string CopyRight { get; set; }

        /// <summary>
        /// 问卷的索引标识，与id均可唯一确定一份问卷
        /// </summary>
        public Guid GuidId { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 问卷状态
        /// </summary>
        public SurveyStatus SurveyStatus { get; set; }
    }
}
