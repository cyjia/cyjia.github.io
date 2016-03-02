---
layout: post
title: Install firebird in CentOS 7
---

Today, I need to install firebird in a docker container based on CentOS 7.

[The official site of Firebird](http://www.firebirdsql.org) provides download links pointing to sourceforge.net. When downloading rpm package or tar files following thoses links, Chrome alert me of malicious software, so I turn to find package in other sources.

Following [this link](http://www.firebirdnews.org/epel-7-repository-left-the-beta-stage/), I learned to install from epel repository. I didn't quite understand the epel repository, I guess its a package source for other OS, but since it's rpm packge, CentOS can still use it.

To install it firebird from epel repository, you need two steps.
First, you install epel related files by run command `yum install epel-release`. Second, you need to enable epel repo by passing option `--enablerepo=epel` to `yum` command. For example, if I want to install classic firebird, I will run command `yum --enablerepo=epel install firebird-classic`.

Hope this will save you some time~~
