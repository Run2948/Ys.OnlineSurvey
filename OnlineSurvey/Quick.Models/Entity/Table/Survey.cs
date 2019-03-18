/* ==============================================================================
* 命名空间：Quick.Models.Entity.Table 
* 类 名 称：Survey
* 创 建 者：Qing
* 创建时间：2019/03/17 15:50:05
* CLR 版本：4.0.30319.42000
* 保存的文件名：Survey
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
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Security.Authentication.ExtendedProtection;
using System.Text;
using System.Threading.Tasks;
using Quick.Models.Entity.Enum;

namespace Quick.Models.Entity.Table
{
    [Table("Survey")]
    public class Survey : BaseEntity
    {
        [Required]
        [MaxLength(255, ErrorMessage = "问卷名称长度不能超过255")]
        public string SurveyName { get; set; }

        [Required(ErrorMessage = "问卷描述信息不能为空")]
        public string Description { get; set; }

        [Required(ErrorMessage = "问卷底部(版权)信息不能为空")]
        public string CopyRight { get; set; }

        /// <summary>
        /// 问卷的索引标识，与id均可唯一确定一份问卷
        /// </summary>
        [Index(IsUnique = true)]
        public Guid GuidId { get; set; } = Guid.NewGuid();

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; } = DateTime.Now;

        /// <summary>
        /// 问卷状态
        /// </summary>
        public SurveyStatus SurveyStatus { get; set; } = SurveyStatus.Creating;
    }
}
