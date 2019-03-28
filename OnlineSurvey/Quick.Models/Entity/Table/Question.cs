/* ==============================================================================
* 命名空间：Quick.Models.Entity.Table 
* 类 名 称：Question
* 创 建 者：Qing
* 创建时间：2019/03/17 16:18:32
* CLR 版本：4.0.30319.42000
* 保存的文件名：Question
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
    [Table("Question")]
    public class Question : BaseEntity
    {
        /// <summary>
        /// 话题
        /// </summary>
        [Required]
        public string Topic { get; set; }

        /// <summary>
        /// 项数
        /// </summary>
        [Required]
        public int ItemCount { get; set; }

        /// <summary>
        /// 选项
        /// </summary>
        public string Option1 { get; set; }
        public string Option2 { get; set; }
        public string Option3 { get; set; }
        public string Option4 { get; set; }
        public string Option5 { get; set; }
        public string Option6 { get; set; }
        public string Option7 { get; set; }
        public string Option8 { get; set; }
        public string Option9 { get; set; }

        /// <summary>
        /// 备注信息
        /// </summary>
        public string Comment { get; set; }

        /// <summary>
        /// 话题类别：1.单选题   2.多选题   3.列表菜单  4.文本框  5.文本区域   6.日期题   10.单选+其它(文本框)   20多选+其它(文本框)  
        /// </summary>
        [Required]
        [ForeignKey("SystemType")]
        public int ItemType { get; set; }

        public virtual SystemType SystemType { get; set; }

        public object GetValue(string propertyName)
        {
            return GetType().GetProperty(propertyName)?.GetValue(this, null);
        }
    }
}
