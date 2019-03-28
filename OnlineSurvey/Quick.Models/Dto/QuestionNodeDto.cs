/* ==============================================================================
* 命名空间：Quick.Models.Dto 
* 类 名 称：QuestionDto
* 创 建 者：Qing
* 创建时间：2019/03/19 10:51:42
* CLR 版本：4.0.30319.42000
* 保存的文件名：QuestionDto
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
using System.Text;
using System.Threading.Tasks;

namespace Quick.Models.Dto
{
    public class QuestionNodeDto : BaseDto
    {
        /// <summary>
        /// 话题
        /// </summary>
        public string Topic { get; set; }
        /// <summary>
        /// 类型
        /// </summary>
        public int ItemType { get; set; }
    }
}
