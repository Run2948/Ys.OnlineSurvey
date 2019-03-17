/* ==============================================================================
* 命名空间：Quick.Models.Entity.Table 
* 类 名 称：SurveyQuestion
* 创 建 者：Qing
* 创建时间：2019/03/17 17:24:34
* CLR 版本：4.0.30319.42000
* 保存的文件名：SurveyQuestion
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
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quick.Models.Entity.Table
{

    #region 外键方式一 - FluentApi作用是通过配置领域类来覆盖默认的约定
    //[Table("SurveyQuestion")]
    //public class SurveyQuestion
    //{
    //    [ForeignKey("Survey")]
    //    public long SurveyId { get; set; }

    //    public virtual Survey Survey { get; set; }

    //    [ForeignKey("Question")]
    //    public long QuestionId { get; set; }

    //    public virtual Question Question { get; set; }
    //}
    #endregion

    #region 外键方式二 - 通过DbModelBuilder类来使用FluentApi，它的功能比数据注释属性更强大
    [Table("SurveyQuestion")]
    public class SurveyQuestion
    {
        public long SurveyId { get; set; }
        public Survey Survey { get; set; }
        public long QuestionId { get; set; }
        public Question Question { get; set; }
    } 
    #endregion
}
