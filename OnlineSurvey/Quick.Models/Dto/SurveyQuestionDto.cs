/* ==============================================================================
* 命名空间：Quick.Models.Dto 
* 类 名 称：SurveyQuestionDto
* 创 建 者：Qing
* 创建时间：2019/03/19 15:23:22
* CLR 版本：4.0.30319.42000
* 保存的文件名：SurveyQuestionDto
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

using Quick.Models.Entity.Table;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quick.Models.Dto
{
    public class SurveyQuestionDto : SurveyDto
    {
        public List<Question> Questions { get; set; }
    }
}
