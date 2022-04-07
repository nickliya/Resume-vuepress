module.exports = {
  lang: "zh-CN",
  title: "Yongchin's Resume",
  description: "这是我的第一个 VuePress 站点",
  base: "/Resume-vuepress/",

  // 主题配置
  themeConfig: {
    navbar: false,
    sidebar: [
      {
        title: "简历",
        collapsable: false,
        children: ["/"],
      },
    ],
  },
};
