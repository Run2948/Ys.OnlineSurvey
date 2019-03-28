/* ==============================================================================
* 命名空间：Quick.Service
* 类 名 称：BaseService
* 创 建 者：Qing
* 创建时间：2018-11-29 21:45:11
* CLR 版本：4.0.30319.42000
* 保存的文件名：BaseService
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



using Quick.Models.Common;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using Masuit.Tools.DateTimeExt;
using Masuit.Tools.Security;
using Masuit.Tools.Win32;
using Quick.Common;
using Quick.IService;
using Quick.Models.Dto;
using Quick.Models.Entity.Table;

namespace Quick.Service
{
    /// <summary>
    /// 业务层基类
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public partial class BaseService<T>
    {
        #region SqlSugar 初始化
        /// <summary>
        /// 初始化ConnectionConfig对象
        /// </summary>
        private ConnectionConfig SqlSugarConnectionConfig => new ConnectionConfig()
        {
            ConnectionString = DbProvider.GetDbConStr(),
            DbType = DbType.SqlServer,
            InitKeyType = InitKeyType.Attribute,//从特性读取主键和自增列信息
            IsAutoCloseConnection = true,//开启自动释放模式和EF原理一样我就不多解释了
        };

        public BaseService()
        {
            DbClient = new SqlSugarClient(SqlSugarConnectionConfig);
#if DEBUG
            //调式代码 用来打印SQL 
            DbClient.Aop.OnLogExecuting = (sql, pars) =>
            {
                Console.WriteLine(sql + "\r\n" + DbClient.Utilities.SerializeObject(pars.ToDictionary(it => it.ParameterName, it => it.Value)));
                Console.WriteLine();
            };
#endif
        }

        // 用来处理lbk_user表的常用操作
        //public SimpleClient<Student> StudentDb => new SimpleClient<Student>(DbClient);

        /// <summary>
        /// 用来处理T表的常用操作
        /// </summary>
        //public SimpleClient<T> SimpleDbClient => new SimpleClient<T>(DbClient);

        /// <summary>
        /// 用来处理事务多表查询和复杂的操作
        /// </summary>
        public SqlSugarClient DbClient;

        #endregion

        /// <summary>
        /// SqlSugar 用来处理事务多表查询和复杂的操作
        /// 详细操作见：http://www.codeisbug.com/Doc/8/1166
        /// </summary>
        /// <returns></returns>
        public SqlSugarClient SugarClient()
        {
            return DbClient;
        }
    }

    /// <summary>
    /// SystemType业务类
    /// </summary>
    public partial class SystemTypeService
    {
        /// <summary>
        /// 根据类型名获取类型集合
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public List<SystemTypeDto> GetTypesByName(string name)
        {
            return LoadEntitiesNoTracking<string, SystemTypeDto>(l => l.Name == name, l => l.Name, true).ToList();
        }
    }

    /// <summary>
    /// UserInfo业务类
    /// </summary>
    public partial class UserInfoService
    {
        /// <summary>
        /// 根据用户名获取
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public UserInfo GetByUserName(string name)
        {
            return GetFirstEntity(u => u.UserName.Equals(name));
        }

        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public UserInfoOutputDto Login(string username, string password)
        {
            UserInfo userInfo = GetByUserName(username);
            if (userInfo != null)
            {
                UserInfoOutputDto user = userInfo.Mapper<UserInfoOutputDto>();
                string key = userInfo.SaltKey;
                string pwd = userInfo.Password;
                password = password.MDString3(key);
                if (pwd.Equals(password))
                {
                    return user;
                }
            }
            return null;
        }

        /// <summary>
        /// 注册
        /// </summary>
        /// <param name="userInfo"></param>
        /// <returns></returns>
        public UserInfo Register(UserInfo userInfo)
        {
            UserInfo exist = GetFirstEntity(u => u.UserName.Equals(userInfo.UserName));
            if (exist is null)
            {
                var salt = $"{new Random().StrictNext()}{DateTime.Now.GetTotalMilliseconds()}".MDString2(Guid.NewGuid().ToString()).AESEncrypt();
                userInfo.Password = userInfo.Password.MDString3(salt);
                userInfo.SaltKey = salt;
                UserInfo added = AddEntity(userInfo);
                int line = SaveChanges();
                return line > 0 ? added : null;
            }
            return null;
        }

        /// <summary>
        /// 检查用户名是否存在
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public bool UserNameExist(string name)
        {
            UserInfo userInfo = GetByUserName(name);
            return userInfo != null;
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="name">用户名，邮箱或者电话号码</param>
        /// <param name="oldPwd">旧密码</param>
        /// <param name="newPwd">新密码</param>
        /// <returns></returns>
        public bool ChangePassword(string name, string oldPwd, string newPwd)
        {
            UserInfo userInfo = GetByUserName(name);
            if (userInfo != null)
            {
                string key = userInfo.SaltKey;
                string pwd = userInfo.Password;
                oldPwd = oldPwd.MDString3(key);
                if (pwd.Equals(oldPwd))
                {
                    var salt = $"{new Random().StrictNext()}{DateTime.Now.GetTotalMilliseconds()}".MDString2(Guid.NewGuid().ToString()).AESEncrypt();
                    userInfo.Password = newPwd.MDString3(salt);
                    userInfo.SaltKey = salt;
                    return SaveChanges() > 0;
                }
            }
            return false;
        }

        public bool ChangePassword(long id, string oldPwd, string newPwd)
        {
            UserInfo userInfo = GetById(id);
            if (userInfo != null)
            {
                string key = userInfo.SaltKey;
                string pwd = userInfo.Password;
                oldPwd = oldPwd.MDString3(key);
                if (pwd.Equals(oldPwd))
                {
                    var salt = $"{new Random().StrictNext()}{DateTime.Now.GetTotalMilliseconds()}".MDString2(Guid.NewGuid().ToString()).AESEncrypt();
                    userInfo.Password = newPwd.MDString3(salt);
                    userInfo.SaltKey = salt;
                    return SaveChanges() > 0;
                }
            }
            return false;
        }

        /// <summary>
        /// 重置密码
        /// </summary>
        /// <returns></returns>
        public bool ResetPassword(string name, string newPwd = "123456")
        {
            UserInfo userInfo = GetByUserName(name);
            if (userInfo != null)
            {
                var salt = $"{new Random().StrictNext()}{DateTime.Now.GetTotalMilliseconds()}".MDString2(Guid.NewGuid().ToString()).AESEncrypt();
                userInfo.Password = newPwd.MDString3(salt);
                userInfo.SaltKey = salt;
                return SaveChanges() > 0;
            }
            return false;
        }
    }

    /// <summary>
    /// Survey业务类
    /// </summary>
    public partial class SurveyService
    {
        public ISurveyQuestionService SurveyQuestionService { get; set; }
        public IQuestionService QuestionService { get; set; }

        /// <summary>
        /// 获取完整答卷
        /// </summary>
        /// <param name="guidId"></param>
        /// <returns></returns>
        public SurveyQuestionDto GetWholeSurvey(Guid? guidId)
        {
            var dto = GetFirstEntityNoTracking<SurveyQuestionDto>(l => l.GuidId == guidId);
            var qIds = SurveyQuestionService.LoadEntitiesNoTracking(l => l.SurveyId == dto.Id).Select(l => l.QuestionId).ToList();
            dto.Questions = QuestionService.LoadEntitiesNoTracking(l => qIds.Contains(l.Id)).ToList();
            return dto;
        }
    }
}
