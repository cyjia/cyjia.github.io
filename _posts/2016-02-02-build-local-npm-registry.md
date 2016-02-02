---
layout: default
title: 是时候搭建本地NPM仓库了
---

最近接触几个前端项目都是Node平台，用到了大量npm包，少则一百，多则数百。一次全新的`npm install`要耗时十多分钟，再加上国内访问npmjs受限，往往还需翻墙出去。`npm install`带来的停顿和挫折感使Node平台原本畅快淋漓地开发感觉大打折扣。

[淘宝的镜像](http://registry.npm.taobao.org/)速度非常快，还能找回那种畅快的感觉。但需要在多个环境中执行`npm install`时，还是觉得有点慢。比如，我们的CI每次构建都需要在全新的Docker容器中执行`npm install`，每次接近5分钟的执行时间还是相当可观。

如果遇到上述情况，不妨在本地网络搭建NPM仓库，这样就可以充分利用本地网络。

可能有人担心搭建NPM仓库成本过高。其实不然，经过我的调查，有很多种低成本的搭建方法。按照我的使用经验，最简单的搭建方法就是运行一个Node程序。比如[`local-npm`](https://github.com/nolanlawson/local-npm), 只需安装成全局包，然后执行一个命令就可以了。此类程序还有很多，比如[`sinopia`](https://github.com/rlidwka/sinopia),`npm-proxy`等等。

花上几分钟时间安装一个本地仓库，带来的效果是为以后上千次的`npm install`节省几个小时甚至几天。

