---
title: good bye graphql and relay
layout: post
---
# 引入了类型，让我觉得不堪重负
# 还是需要有RootContainer一次性加载数据，子组件通过graphql的查询语句声明数据需求
# 更新操作很重，要声明类型，实现多个方法
# 虽然你声称实现了数据缓存，减少与服务端的交互，自动重发请求，但我用起来很累
