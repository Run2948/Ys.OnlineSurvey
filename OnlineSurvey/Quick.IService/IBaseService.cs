/* ==============================================================================
* 命名空间：Quick.IService
* 类 名 称：IBaseService
* 创 建 者：Qing
* 创建时间：2018-11-29 22:36:21
* CLR 版本：4.0.30319.42000
* 保存的文件名：IBaseService
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



using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quick.Models.Dto;
using Quick.Models.Entity.Table;

namespace Quick.IService
{
    public partial interface IBaseService<T>
    {
        /// <summary>
        /// SqlSugar 用来处理事务多表查询和复杂的操作
        /// 详细操作见：http://www.codeisbug.com/Doc/8/1166
        /// </summary>
        /// <returns></returns>
        SqlSugarClient SugarClient();
    }

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

    /// <summary>
    /// UserInfo业务接口
    /// </summary>
    public partial interface IUserInfoService
    {
        /// <summary>
        /// 根据用户名获取
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        UserInfo GetByUserName(string name);

        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        UserInfoOutputDto Login(string username, string password);

        /// <summary>
        /// 注册
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        UserInfo Register(UserInfo userInfo);

        /// <summary>
        /// 检查用户名是否存在
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        bool UserNameExist(string name);

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="name">用户名，邮箱或者电话号码</param>
        /// <param name="oldPwd">旧密码</param>
        /// <param name="newPwd">新密码</param>
        /// <returns></returns>
        bool ChangePassword(string name, string oldPwd, string newPwd);

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="id">用户id</param>
        /// <param name="oldPwd">旧密码</param>
        /// <param name="newPwd">新密码</param>
        /// <returns></returns>
        bool ChangePassword(long id, string oldPwd, string newPwd);

        /// <summary>
        /// 重置密码
        /// </summary>
        /// <returns></returns>
        bool ResetPassword(string name, string newPwd = "123456");

    }

    /// <summary>
    /// Survey业务接口
    /// </summary>
    public partial interface ISurveyService
    {
        /// <summary>
        /// 获取完整答卷
        /// </summary>
        /// <param name="guidId"></param>
        /// <returns></returns>
        SurveyQuestionDto GetWholeSurvey(Guid? guidId);
    }
}
