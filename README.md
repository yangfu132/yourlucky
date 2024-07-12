# your_lucky

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 计算的设想
//假设月的健康值为30/365,也就是月实际代表的是一月，爻的健康值实际上是根据日月计算出来的；
//假设日的健康值为10/365,也就是日实际代表的是一旬；爻的健康值实际上是根据日月计算出来的；
//但是单个如何计算，现在还需要确定：直接按照十二长生来；
//每个值的月部分为月的月健康值/12;
//每个值的日部分为日的健康值/12;
//以绝为0；以帝旺为100%，其他部分各自按顺序变化；四平运应该是指没有变化；四衰运应该是指变弱；四旺运应该是指增强；

## 工程设想
尽量讲计算结果变为model；
symbol的model只保存计算结果；
引入store作为viewmodel；
自动生成store、model；
为Android Studio开发一个插件，自动生成store
UI的自动化与控件化，自动化只能提供某种约束，让开发人员按照一定的模式创建文件，控件化也是一种约束，让开发人员按照一定的模式使用控件；

2023-10-25 待完成内容：
历史列表增加用神，门类，备注；（完成）
每次easy的批注，（完成）
增加隐藏批注功能
增加批注列表；
历史列表增加隐藏功能；
在爻的详细里增加保存、目的、针对爻的备注按钮
数据库导出，安卓的永久存储，永久存储的删除
详细里的增加备注功能
篆体加密和解密
增加开发计划改为列表，添加和删除线功能
2024-02-18
今天听到个评论：有个开发者为自己失败的项目编写墓志铭，并将它分享出来。
因为我觉得这是个有意思的想法，所以我也准备将项目中遇到的问题记录成日志，并分享在这里；
这是一个至关重要的想法。研究不是为了证明我们最初的猜测，而是为了获得知识和真理。知道某件事不起作用可能比知道它起作用同样（更）重要。
2024-02-19
因为我对程序如何获得具体的示意感到困惑，所以将《增删卜易》与易经原文结合起来。
希望能借助具体的易经道理，将示意更清晰的展现出来。
2024-02-20
如何推演准确的时间？
2024-07-10
1.日志：原本有完整的单元测试，但是在讲工程从Objective-c迁移为dart的过程中，但愿测试无法对应新的工程，需要全部重建。
因为是重建，没办法按照逻辑分解的方式从头编写测试用例，或者说我的工程已经找不到头了。这可真是很糟糕；
单元测试不是应该和业务逻辑在一起吗？为什么会找不到头呢？大概从一开始我就是摸着石头过河的，所以就没有建立完整的业务逻辑列表；
    1.1 问题：我是否需要考虑建立一个呢？