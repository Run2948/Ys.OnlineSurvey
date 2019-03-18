/* ==============================================================================
* 命名空间：Quick.IService 
* 类 名 称：ISystemTypeService
* 创 建 者：Qing
* 创建时间：2019/03/18 19:03:48
* CLR 版本：4.0.30319.42000
* 保存的文件名：ISystemTypeService
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
using Quick.Models.Dto;
using Quick.Models.Entity.Table;

namespace Quick.IService
{
    /// <summary>
    /// SystemType业务接口
    /// </summary>
	public partial interface ISystemTypeService : IBaseService<SystemType>
	{
        /// <summary>
        /// 根据类型名获取类型集合
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
		List<SystemTypeDto> GetTypesByName(string name);

	}
}
