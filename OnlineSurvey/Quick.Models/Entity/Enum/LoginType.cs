﻿/* ==============================================================================
* 命名空间：Quick.Models.Entity.Enum
* 类 名 称：LoginType
* 创 建 者：Qing
* 创建时间：2018-11-30 09:35:01
* CLR 版本：4.0.30319.42000
* 保存的文件名：LoginType
* 文件版本：V1.0.0.0
*
* 功能描述：N/A 
*
* 修改历史：
*
*
* ==============================================================================
*         CopyRight @ 班纳工作室 2018. All rights reserved
* ==============================================================================*/


using System.ComponentModel;

namespace Quick.Models.Entity.Enum
{
    /// <summary>
    /// 登录类型
    /// </summary>
    public enum LoginType
    {
        [Description("电脑")]
        Default,
        [Description("手机")]
        Phone,
    }
}
