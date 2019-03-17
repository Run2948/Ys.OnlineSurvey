/* ==============================================================================
* 命名空间：Quick.Models.Entity.Table 
* 类 名 称：SystemType
* 创 建 者：Qing
* 创建时间：2019/03/17 16:29:06
* CLR 版本：4.0.30319.42000
* 保存的文件名：SystemType
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
    [Table("SystemType")]
    public class SystemType
    {
        /// <summary>
        /// 主键
        /// </summary>
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(50,ErrorMessage ="类型名称长度不能超过50")]
        public string TypeName { get; set; }

        [Required]
        [Index(IsUnique = true)]
        [MaxLength(50,ErrorMessage ="名称长度不能超过50")]
        public string Name { get; set; }

    }
}
