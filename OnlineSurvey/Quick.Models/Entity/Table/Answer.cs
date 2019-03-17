/* ==============================================================================
* 命名空间：Quick.Models.Entity.Table 
* 类 名 称：Answer
* 创 建 者：Qing
* 创建时间：2019/03/17 17:15:59
* CLR 版本：4.0.30319.42000
* 保存的文件名：Answer
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

namespace Quick.Models.Entity.Table
{
    [Table("Answer")]
    public class Answer : BaseEntity
    {
        /// <summary>
        /// 问卷Id
        /// </summary>
        public long SurveyId { get; set; }

        /// <summary>
        /// 答卷者Id
        /// </summary>
        public long UserId { get; set; }

        /// <summary>
        /// 答卷时间
        /// </summary>
        public DateTime AnswerTime { get; set; }

        /// <summary>
        /// 答卷者Ip地址
        /// </summary>
        [MaxLength(17)]
        public string AnswerIp { get; set; }

        /// <summary>
        /// 备注信息
        /// </summary>
        public string Comment { get; set; }

        /// <summary>
        /// 答案信息
        /// </summary>
        #region 一套问卷最多可设置30道题

        public string Topic1 { get; set; }
        public string Topic2 { get; set; }
        public string Topic3 { get; set; }
        public string Topic4 { get; set; }
        public string Topic5 { get; set; }
        public string Topic6 { get; set; }
        public string Topic7 { get; set; }
        public string Topic8 { get; set; }
        public string Topic9 { get; set; }
        public string Topic10 { get; set; }
        public string Topic11 { get; set; }
        public string Topic12 { get; set; }
        public string Topic13 { get; set; }
        public string Topic14 { get; set; }
        public string Topic15 { get; set; }
        public string Topic16 { get; set; }
        public string Topic17 { get; set; }
        public string Topic18 { get; set; }
        public string Topic19 { get; set; }
        public string Topic20 { get; set; }
        public string Topic21 { get; set; }
        public string Topic22 { get; set; }
        public string Topic23 { get; set; }
        public string Topic24 { get; set; }
        public string Topic25 { get; set; }
        public string Topic26 { get; set; }
        public string Topic27 { get; set; }
        public string Topic28 { get; set; }
        public string Topic29 { get; set; }
        public string Topic30 { get; set; }

        #endregion

        /// <summary>
        /// 其他答案
        /// </summary>
        #region 一套问卷最多可设置30个其他选项

        public string Qt1 { get; set; }
        public string Qt2 { get; set; }
        public string Qt3 { get; set; }
        public string Qt4 { get; set; }
        public string Qt5 { get; set; }
        public string Qt6 { get; set; }
        public string Qt7 { get; set; }
        public string Qt8 { get; set; }
        public string Qt9 { get; set; }
        public string Qt10 { get; set; }
        public string Qt11 { get; set; }
        public string Qt12 { get; set; }
        public string Qt13 { get; set; }
        public string Qt14 { get; set; }
        public string Qt15 { get; set; }
        public string Qt16 { get; set; }
        public string Qt17 { get; set; }
        public string Qt18 { get; set; }
        public string Qt19 { get; set; }
        public string Qt20 { get; set; }
        public string Qt21 { get; set; }
        public string Qt22 { get; set; }
        public string Qt23 { get; set; }
        public string Qt24 { get; set; }
        public string Qt25 { get; set; }
        public string Qt26 { get; set; }
        public string Qt27 { get; set; }
        public string Qt28 { get; set; }
        public string Qt29 { get; set; }
        public string Qt30 { get; set; }

        #endregion
    }
}
