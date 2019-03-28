using System.Text;
using NPinyin;

namespace Quick.Common.Strings
{
    public class PinyinHelper
    {
        /// <summary> 
        /// 汉字转化为拼音
        /// </summary> 
        /// <param name="text">汉字</param> 
        /// <returns>全拼</returns> 
        public static string GetPinyin(string text)
        {
            var stringBuilder = new StringBuilder();
            foreach (var t in text)
            {
                var pinyin = Pinyin.GetPinyin(t);
                if (pinyin != "")
                    stringBuilder.Append(pinyin);
            }
            return stringBuilder.ToString().Trim();
        }

        /// <summary> 
        /// 汉字转化为拼音首字母
        /// </summary> 
        /// <param name="text">汉字</param> 
        /// <returns>首字母</returns> 
        public static string GetFirstPinyin(string text)
        {
            Encoding gb2312 = Encoding.GetEncoding("GB2312");
            string s = Pinyin.ConvertEncoding(text, Encoding.UTF8, gb2312);
            return Pinyin.GetInitials(s, gb2312).Trim();
        }
    }
}